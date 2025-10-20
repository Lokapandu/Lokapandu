// Flutter imports
import 'package:flutter/material.dart';

// Third-party imports
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Local imports
import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries_note.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itinerary_by_id.dart';

/// A notifier class that manages the state and operations for tour plan editing.
///
/// This class handles the creation, validation, and saving of tour plans,
/// including both regular itineraries and note-based itineraries.
/// It also provides analytics tracking for user interactions.
class TourPlanEditorNotifier extends ChangeNotifier {
  // ========== Dependencies ==========
  final CreateUserItineraries _createItineraryUseCase;
  final CreateUserItinerariesNote _createItineraryNoteUseCase;
  final GetUserItineraryById _getItineraryUseCase;
  final AnalyticsManager _analyticsManager;

  // ========== Private State Variables ==========
  String _name = '';
  DateTime? _date = DateTime.now();
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _notes = '';
  TourismSpot? _selectedTour;
  bool _isSubmitting = false;

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
    required GetUserItineraryById getItineraryUseCase,
    required CreateUserItinerariesNote createItineraryUseCase,
    required AnalyticsManager analyticsManager,
  }) : _createItineraryUseCase = useCase,
       _getItineraryUseCase = getItineraryUseCase,
       _createItineraryNoteUseCase = createItineraryUseCase,
       _analyticsManager = analyticsManager;

  // ========== Getters ==========
  String get name => _name;
  DateTime? get date => _date;
  DateTime? get endDate => _endDate;
  TimeOfDay? get startTime => _startTime;
  TimeOfDay? get endTime => _endTime;
  String get notes => _notes;
  TourismSpot? get selectedTour => _selectedTour;
  bool get isSubmitting => _isSubmitting;

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
    notifyListeners();
  }

  set date(DateTime? value) {
    _date = value;
    notifyListeners();
  }

  set endDate(DateTime? value) {
    _endDate = value;
    notifyListeners();
  }

  set startTime(TimeOfDay? value) {
    _startTime = value;
    notifyListeners();
  }

  set endTime(TimeOfDay? value) {
    _endTime = value;
    notifyListeners();
  }

  set notes(String value) {
    _notes = value;
    notifyListeners();
  }

  set selectedTour(TourismSpot? value) {
    _selectedTour = value;
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
    _isSubmitting = false;

    _analyticsManager.trackEvent(eventName: 'reset_plan');
    notifyListeners();
  }

  /// Saves the current plan as either a regular itinerary or a note-based itinerary
  ///
  /// Returns Either&lt;Failure, void&gt; indicating success or failure of the operation.
  /// The method handles validation, user authentication, and different save scenarios
  /// based on whether notes are provided or a tourism spot is selected.
  Future<Either<Failure, void>> savePlan() async {
    if (_isSubmitting) return const Right(null);

    _setSubmittingState(true);

    try {
      // Validate user authentication
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        _trackSavePlanFailed(_errorUserNotFound, userId: 'null');
        return Left(Failure.client(_errorUserNotFound));
      }

      // Validate form data
      if (isFormInvalid) {
        _trackSavePlanFailed(_errorValidationFailed);
        return Left(Failure.validation(_errorValidationFailed));
      }

      Either<Failure, Unit> result;

      // Save based on whether notes are provided or tourism spot is selected
      if (_notes.isNotEmpty) {
        if (_endDate == null) {
          _trackSavePlanFailed(_errorValidationFailed);
          return Left(Failure.validation(_errorValidationFailed));
        }
        result = await _saveItineraryWithNote(user.id);
      } else {
        result = await _saveRegularItinerary(user.id);
      }

      return result;
    } finally {
      _setSubmittingState(false);
    }
  }

  /// Retrieves and loads a plan by its ID
  ///
  /// Returns an error message if the operation fails, null if successful.
  /// This method populates the form fields with the retrieved itinerary data.
  Future<String?> getPlanById(String itineraryId) async {
    String? error;

    final itinerary = await _getItineraryUseCase.execute(itineraryId);

    itinerary.fold((failure) => error = failure.message, (data) {
      _analyticsManager.trackEvent(
        eventName: 'get_plan_by_id_success',
        parameters: {'itinerary_id': itineraryId},
      );
      _populateFormWithItineraryData(data);
    });

    return error;
  }

  // ========== Private Helper Methods ==========
  /// Sets the submitting state and notifies listeners
  void _setSubmittingState(bool isSubmitting) {
    _isSubmitting = isSubmitting;
    notifyListeners();
  }

  /// Saves an itinerary with notes
  Future<Either<Failure, Unit>> _saveItineraryWithNote(String userId) async {
    _analyticsManager.trackEvent(
      eventName: 'save_plan_with_note',
      parameters: {
        'name': _name,
        'notes': _notes,
        'start_time': _startTime.toString(),
        'end_time': _endTime.toString(),
      },
    );

    return await _createItineraryNoteUseCase.execute(
      CreateItineraryNote(
        name: _name,
        notes: _notes,
        startTime: _createDateTime(_date!, _startTime!),
        endTime: _createDateTime(_endDate!, _endTime!),
        userId: userId,
      ),
    );
  }

  /// Saves a regular itinerary with tourism spot
  Future<Either<Failure, Unit>> _saveRegularItinerary(String userId) async {
    if (_selectedTour == null) {
      _trackSavePlanFailed(_errorSelectTourismSpot);
      return Left(Failure.validation(_errorSelectTourismSpot));
    }

    _analyticsManager.trackEvent(
      eventName: 'save_plan_without_note',
      parameters: {
        'name': _name,
        'tourism_spot_id': _selectedTour!.id,
        'start_time': _startTime.toString(),
        'end_time': _endTime.toString(),
      },
    );

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

  /// Creates a DateTime from a date and time of day
  DateTime _createDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// Populates form fields with itinerary data
  void _populateFormWithItineraryData(dynamic data) {
    _name = data.name;
    _date = data.startTime;
    _endDate = data.endTime;
    _startTime = TimeOfDay.fromDateTime(data.startTime);
    _endTime = TimeOfDay.fromDateTime(data.endTime);
    _notes = data.notes ?? '';
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
