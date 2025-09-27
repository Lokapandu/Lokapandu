import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lokapandu/features/plan/models/plan_item_model.dart';
import '../screens/tour_search_sceen.dart';
import 'package:lokapandu/features/plan/widgets/selected_tour_card.dart';
import 'package:lokapandu/features/tour/models/tour_model.dart';

class TourPlanEditorScreen extends StatefulWidget {
  final PlanItem? planItem;

  const TourPlanEditorScreen({super.key, this.planItem});

  @override
  State<TourPlanEditorScreen> createState() => _TourPlanEditorScreenState();
}

class _TourPlanEditorScreenState extends State<TourPlanEditorScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Tour? _selectedTour;

  bool get isEditing => widget.planItem != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      // TODO: Isi field dari widget.planItem
    }
  }

  Future<void> _navigateToSearchScreen() async {
    final result = await Navigator.push<Tour>(
      context,
      MaterialPageRoute(builder: (context) => const TourSearchScreen()),
    );
    if (result != null && mounted) {
      setState(() {
        _selectedTour = result;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isStart ? _startTime : _endTime) ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Rencana Wisata' : 'Tambah Rencana Wisata',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              label: 'Rencana Pariwisata',
              controller: _titleController,
              hint: 'Contoh: Tour di Taman Tirta Gangga',
            ),
            const SizedBox(height: 24),
            _buildDateTimeField(
              label: 'Tanggal',
              value: _selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                  : 'DD/MM/YYYY',
              icon: Icons.calendar_today_outlined,
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateTimeField(
                    label: 'Waktu Mulai',
                    value: _startTime?.format(context) ?? '00:00',
                    icon: Icons.access_time_outlined,
                    onTap: () => _selectTime(true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateTimeField(
                    label: 'Waktu Selesai',
                    value: _endTime?.format(context) ?? '00:00',
                    icon: Icons.access_time_outlined,
                    onTap: () => _selectTime(false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SelectedTourCard(
              selectedTour: _selectedTour,
              onTap: _navigateToSearchScreen,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              label: 'Catatan',
              controller: _noteController,
              hint: 'Tulis catatan di sini',
              maxLines: 4,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF008080),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Simpan Rencana Wisata',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey, size: 20),
                const SizedBox(width: 12),
                Text(value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
