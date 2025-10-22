import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateTimeInputMode { date, time }

class DateTimeFormField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final DateTime? initialDateTime;
  final ValueChanged<DateTime?> onDateTimeSelected;
  final DateTimeInputMode mode;

  const DateTimeFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.initialDateTime,
    required this.onDateTimeSelected,
    this.mode = DateTimeInputMode.date,
  });

  @override
  State<DateTimeFormField> createState() => _DateTimeFormFieldState();
}

class _DateTimeFormFieldState extends State<DateTimeFormField> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
    _updateControllerText();
  }

  @override
  void didUpdateWidget(covariant DateTimeFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialDateTime != oldWidget.initialDateTime) {
      _selectedDateTime = widget.initialDateTime;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updateControllerText();
        }
      });
    }
  }

  String _getFormatString() {
    switch (widget.mode) {
      case DateTimeInputMode.date:
        return 'dd/MM/yyyy';
      case DateTimeInputMode.time:
        return 'HH:mm';
    }
  }

  void _updateControllerText() {
    if (_selectedDateTime != null) {
      _controller.text = DateFormat(
        _getFormatString(),
        'id_ID',
      ).format(_selectedDateTime!);
    } else {
      _controller.text = '';
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? dateResult = _selectedDateTime;
    TimeOfDay? timeResult;

    if (mounted && (widget.mode == DateTimeInputMode.date)) {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2030),
        locale: Locale('id'),
      );
      if (pickedDate != null) {
        dateResult = pickedDate;
      } else {
        return;
      }
    } else if (mounted && (widget.mode == DateTimeInputMode.time)) {
      final TimeOfDay initialTime = TimeOfDay.fromDateTime(
        dateResult ?? DateTime.now(),
      );

      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );

      if (pickedTime != null) {
        timeResult = pickedTime;
      } else {
        return;
      }
    }

    DateTime? finalDateTime;
    if (dateResult != null || timeResult != null) {
      DateTime baseDate = dateResult ?? DateTime.now();
      TimeOfDay baseTime =
          timeResult ??
          TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now());

      finalDateTime = DateTime(
        baseDate.year,
        baseDate.month,
        baseDate.day,
        baseTime.hour,
        baseTime.minute,
      );
    }

    if (finalDateTime != null && finalDateTime != _selectedDateTime) {
      setState(() {
        _selectedDateTime = finalDateTime;
        _updateControllerText();
        widget.onDateTimeSelected(_selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        hintText: widget.hint,
      ),
      readOnly: true,
      onTap: () => _selectDateTime(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.label} diperlukan!';
        }
        return null;
      },
      onSaved: (value) => _controller.text = value!,
    );
  }
}
