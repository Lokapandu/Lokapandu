// Flutter imports

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries_note.dart';
import 'package:lokapandu/domain/usecases/itineraries/edit_user_itineraries.dart';
import 'package:lokapandu/domain/validators/itinerary_validators.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Third-party imports

// Local imports

/// A notifier class that manages the state and operations for tour plan editing.
///
/// This class handles the creation, validation, and saving of tour plans,
/// including both regular itineraries and note-based itineraries.
/// It also provides analytics tracking for user interactions.
class TourPlanEditorNotifier extends ChangeNotifier {
  // ========== Dependencies ==========
  final CreateUserItineraries _createItineraryUseCase;
  final CreateUserItinerariesNote _createItineraryNoteUseCase;
  final EditUserItineraries _editItineraryUseCase;
  final AnalyticsManager _analyticsManager;
  final ItineraryValidators _validators;

  // ========== Private State Variables ==========
  String _name = '';
  DateTime? _date = DateTime.now();
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _notes = '';
  TourismSpot? _selectedTour;
  bool _isSubmitting = false;
  TourPlanModel? _editModel;
  String? _errorMessage;
  String? _successMessage;
  bool _isSnackbarShowing = false;

  // ========== Constants ==========
  static const String _errorUserNotFound = "Gagal mendapatkan data user";
  static const String _errorValidationFailed =
      "Validasi form gagal, mohon periksa kembali";
  static const String _errorSelectTourismSpot = "Pilih tempat wisata";

  // ========== Constructor ==========
  /// Constructor for TourPlanEditorNotifier
  ///
  /// Requires use cases for creating itineraries and analytics manager
  /// for tracking user interactions.
  TourPlanEditorNotifier({
    required CreateUserItineraries useCase,
    required CreateUserItinerariesNote createItineraryUseCase,
    required EditUserItineraries editItineraryUseCase,
    required AnalyticsManager analyticsManager,
    required ItineraryValidators validators,
  }) : _createItineraryUseCase = useCase,
       _createItineraryNoteUseCase = createItineraryUseCase,
       _editItineraryUseCase = editItineraryUseCase,
       _analyticsManager = analyticsManager,
       _validators = validators;

  // ========== Getters ==========
  String get name => _name;

  DateTime? get date => _date;

  DateTime? get endDate => _endDate;

  TimeOfDay? get startTime => _startTime;

  TimeOfDay? get endTime => _endTime;

  String get notes => _notes;

  TourismSpot? get selectedTour => _selectedTour;

  bool get isSubmitting => _isSubmitting;

  String? get errorMessage => _errorMessage;

  bool get hasError => _errorMessage != null;

  String? get successMessage => _successMessage;

  bool get success => _successMessage != null;

  bool get isSnackbarShowing => _isSnackbarShowing;

  // ========== Validation ==========
  /// Validates the form fields to ensure all required data is present
  ///
  /// Returns true if validation fails (form is invalid)
  /// Returns false if validation passes (form is valid)
  bool get isFormInvalid {
    return _name.isEmpty ||
        _date == null ||
        _startTime == null ||
        _endTime == null;
  }

  // ========== Setters ==========
  set name(String value) {
    _name = value;
    _validateSameValue();
    notifyListeners();
  }

  set date(DateTime? value) {
    _date = value;
    _validateSameValue();
    notifyListeners();
  }

  set endDate(DateTime? value) {
    _endDate = value;
    _validateSameValue();
    notifyListeners();
  }

  set startTime(TimeOfDay? value) {
    _startTime = value;
    _validateSameValue();
    notifyListeners();
  }

  set endTime(TimeOfDay? value) {
    _endTime = value;
    _validateSameValue();
    notifyListeners();
  }

  set notes(String value) {
    _notes = value;
    _validateSameValue();
    notifyListeners();
  }

  set selectedTour(TourismSpot? value) {
    _selectedTour = value;
    _validateSameValue();
    _analyticsManager.setUserProperty(
      name: 'selected_tour',
      value: value?.id.toString() ?? 'null',
    );
    notifyListeners();
  }

  // ========== Public Methods ==========
  /// Resets all state variables to their initial values
  ///
  /// This method clears all form data and tracks the reset action
  /// in analytics for user behavior analysis.
  void resetState() {
    _name = '';
    _date = DateTime.now();
    _endDate = null;
    _startTime = null;
    _endTime = null;
    _notes = '';
    _selectedTour = null;
    _editModel = null;
    _isSubmitting = false;
    _errorMessage = null;
    _successMessage = null;
    _isSnackbarShowing = false;

    _analyticsManager.trackEvent(eventName: 'reset_plan');
    notifyListeners();
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    _isSnackbarShowing = false;
    notifyListeners();
  }

  void setSnackbarShowing(bool showing) {
    _isSnackbarShowing = showing;
    notifyListeners();
  }

  bool _validateSameValue() {
    if (_editModel == null) return false;

    final modelName = _editModel!.name;
    final modelStartTime = _editModel!.startTime;
    final modelEndTime = _editModel!.endTime;
    final modelDate = _editModel!.startDate;
    final modelEndDate = _editModel!.endDate;
    final modelNote = _editModel!.notes;
    final modelTourism = _editModel!.tourismSpot;

    return modelName == _name &&
        modelDate == _date &&
        modelEndDate == _endDate &&
        modelStartTime == _startTime &&
        modelEndTime == _endTime &&
        modelNote == _notes &&
        modelTourism == _selectedTour;
  }

  /// Saves the plan (either itinerary or note) based on the selected tour
  Future<void> savePlan() async {
    _setSubmittingState(true);
    _clearMessages();

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        _errorMessage = _errorUserNotFound;
        return;
      }

      if (isFormInvalid) {
        _errorMessage = _errorValidationFailed;
        return;
      }

      final timeFormatValidation = _validators.validateTimeFormat(
        _startTime,
        _endTime,
      );
      if (timeFormatValidation.isLeft()) {
        final failure = timeFormatValidation.fold((l) => l, (r) => null);
        if (failure != null) {
          _handleFailure(failure);
          return;
        }
      }

      final result = _selectedTour == null
          ? await _saveNote(user.id)
          : await _saveItinerary(user.id);

      result.fold((failure) => _handleFailure(failure), (_) {
        var itemSaved = _name.isEmpty ? _notes : _name;
        _successMessage = _editModel != null
            ? '$itemSaved Berhasil diperbarui!'
            : '$itemSaved Berhasil ditambahkan!';
      });
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      _setSubmittingState(false);
    }
  }

  void _handleFailure(Failure failure) {
    failure.maybeWhen(
      server: (message) => _errorMessage = 'Server Error: $message',
      connection: (message) => _errorMessage = 'Connection Error: $message',
      database: (message) => _errorMessage = 'Database Error: $message',
      invalidTimeFormat: (message) => _errorMessage = message,
      schedulingConflict: (message) => _errorMessage = message,
      invalidTimeRange: (message) => _errorMessage = message,
      validation: (message) => _errorMessage = message,
      missingField: (message) => _errorMessage = message,
      orElse: () => _errorMessage = 'Unknown Error',
    );
  }

  // ========== Private Helper Methods ==========
  /// Sets the submitting state and notifies listeners
  void _setSubmittingState(bool isSubmitting) {
    _isSubmitting = isSubmitting;
    notifyListeners();
  }

  /// Saves an itinerary with notes
  Future<Either<Failure, Unit>> _saveNote(String userId) async {
    _analyticsManager.trackEvent(
      eventName: _editModel != null ? 'edit_note' : 'save_note',
      parameters: {
        'name': _name,
        'notes': _notes,
        'start_time': _startTime.toString(),
        'end_time': _endTime.toString(),
        'is_edit': (_editModel != null).toString(),
      },
    );

    if (_editModel != null) {
      return await _editItineraryUseCase.execute(
        EditItinerary(
          id: _editModel!.id!,
          name: _name,
          notes: _notes,
          startTime: _createDateTime(_date!, _startTime!),
          endTime: _createDateTime(_date!, _endTime!),
        ),
      );
    } else {
      return await _createItineraryNoteUseCase.execute(
        CreateItineraryNote(
          name: _name,
          notes: _notes,
          startTime: _createDateTime(_date!, _startTime!),
          endTime: _createDateTime(_date!, _endTime!),
          userId: userId,
        ),
      );
    }
  }

  /// Saves a regular itinerary with tourism spot
  Future<Either<Failure, Unit>> _saveItinerary(String userId) async {
    if (_selectedTour == null) {
      _trackSavePlanFailed(_errorSelectTourismSpot);
      return Left(Failure.validation(_errorSelectTourismSpot));
    }

    _analyticsManager.trackEvent(
      eventName: _editModel != null ? 'edit_itinerary' : 'save_itinerary',
      parameters: {
        'name': _name,
        'tourism_spot_id': _selectedTour!.id,
        'start_time': _startTime.toString(),
        'end_time': _endTime.toString(),
        'is_edit': (_editModel != null).toString(),
      },
    );

    if (_editModel != null) {
      return await _editItineraryUseCase.execute(
        EditItinerary(
          id: _editModel!.id!,
          name: _name,
          notes: _notes,
          startTime: _createDateTime(_date!, _startTime!),
          endTime: _createDateTime(_date!, _endTime!),
          tourismSpot: _selectedTour!.id,
        ),
      );
    } else {
      return await _createItineraryUseCase.execute(
        CreateItinerary(
          name: _name,
          notes: _notes,
          startTime: _createDateTime(_date!, _startTime!),
          endTime: _createDateTime(_date!, _endTime!),
          tourismSpot: _selectedTour!.id,
          userId: userId,
        ),
      );
    }
  }

  /// Creates a DateTime from a date and time of day
  DateTime _createDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// Populates form fields with itinerary data
  void populateFormWithItineraryData(TourPlanModel data) {
    _editModel = data;
    _name = data.name;
    _date = data.startDate;
    _endDate = data.endDate ?? data.startDate; // Ensure endDate is not null
    _startTime = data.startTime;
    _endTime = data.endTime;
    _notes = data.notes ?? '';

    // Set the selected tourism spot if available in the data
    if (data.tourismSpot != null) {
      _selectedTour = data.tourismSpot;
    }

    // Ensure we have valid time values
    if (_startTime == null && _date != null) {
      _startTime = TimeOfDay.now();
    }

    if (_endTime == null && _endDate != null) {
      _endTime = TimeOfDay.now();
    }

    _validateSameValue();

    notifyListeners();
  }

  /// Tracks save plan failed events
  void _trackSavePlanFailed(String error, {String? userId}) {
    _analyticsManager.trackEvent(
      eventName: 'save_plan_failed',
      parameters: {'error': error, if (userId != null) 'user_id': userId},
    );
  }

  // ========== Lifecycle Methods ==========
  @override
  void dispose() {
    resetState();
    super.dispose();
  }
}
