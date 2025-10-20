import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TourPlanEditorNotifier extends ChangeNotifier {
  final CreateUserItineraries useCase;

  TourPlanEditorNotifier(this.useCase);

  String _name = '';
  DateTime? _date = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _notes = '';
  TourismSpot? _selectedTour;

  bool _isSubmitting = false;

  String get name => _name;

  DateTime? get date => _date;

  TimeOfDay? get startTime => _startTime;

  TimeOfDay? get endTime => _endTime;

  String get notes => _notes;

  TourismSpot? get selectedTour => _selectedTour;

  bool get isSubmitting => _isSubmitting;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set date(DateTime? value) {
    _date = value;
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
    notifyListeners();
  }

  bool validateForm() {
    return _name.isEmpty ||
        _date == null ||
        _startTime == null ||
        _endTime == null ||
        _selectedTour == null;
  }

  void resetState() {
    _name = '';
    _date = null;
    _startTime = null;
    _endTime = null;
    _notes = '';
    _selectedTour = null;
    _isSubmitting = false;
  }

  Future<Either<Failure, void>> savePlan() async {
    if (_isSubmitting) return const Right(null);

    _isSubmitting = true;
    notifyListeners();

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      return Left(Failure.client("Gagal mendapatkan data user"));
    }
    if (validateForm()) {
      return Left(
        Failure.validation("Validasi form gagal, mohon periksa kembali"),
      );
    }

    final result = await useCase.execute(
      user.id,
      CreateItinerary(
        name: name,
        notes: notes,
        startTime: DateTime(
          date!.year,
          date!.month,
          date!.day,
          startTime!.hour,
          startTime!.minute,
        ),
        endTime: DateTime(
          date!.year,
          date!.month,
          date!.day,
          endTime!.hour,
          endTime!.minute,
        ),
        tourismSpot: _selectedTour!.id,
      ),
    );

    _isSubmitting = false;
    notifyListeners();

    return result;
  }
}
