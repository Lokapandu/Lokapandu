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
  }

  String _getFormatString() {
    switch (widget.mode) {
      case DateTimeInputMode.date:
        return 'EEEE, dd MMMM yyyy';
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 1,
          controller: _controller,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            hintText: widget.hint,
            hintStyle: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.surfaceContainerHighest,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
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
        ),
      ],
    );
  }
}
