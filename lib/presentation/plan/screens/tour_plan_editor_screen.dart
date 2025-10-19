import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/plan/models/plan_item_model.dart';
import 'package:lokapandu/presentation/plan/widgets/selected_tour_card.dart';

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
  TourismSpot? _selectedTour;

  bool get isEditing => widget.planItem != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      // TODO: Logika untuk mengisi data saat mode edit
    } else {
      _selectedDate = DateTime(2025, 10, 3);
      _titleController.text = 'Jelajah Air Terjun di Sekitar Ngoro';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSearchScreen() async {
    // Navigasi ke halaman pencarian wisata, menunggu hasil berupa TourismSpot
    final result = await context.push<TourismSpot>('/plan/search-tour');

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
      locale: const Locale('id', 'ID'),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: theme.shadowColor.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          isEditing ? 'Edit Rencana' : 'Tambah Rencana',
          style: theme.textTheme.titleLarge?.copyWith(
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
              theme: theme,
              label: 'Nama Rencana',
              controller: _titleController,
              hint: 'Contoh: Jelajahi Candi Jedong',
            ),
            const SizedBox(height: 24),
            _buildDateTimeField(
              theme: theme,
              label: 'Tanggal',
              value: _selectedDate != null
                  ? DateFormat(
                      'EEEE, dd MMMM yyyy',
                      'id_ID',
                    ).format(_selectedDate!)
                  : 'Pilih Tanggal',
              icon: Icons.calendar_today_outlined,
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateTimeField(
                    theme: theme,
                    label: 'Waktu Mulai',
                    value: _startTime?.format(context) ?? 'Pilih Waktu',
                    icon: Icons.access_time_outlined,
                    onTap: () => _selectTime(true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateTimeField(
                    theme: theme,
                    label: 'Waktu Selesai',
                    value: _endTime?.format(context) ?? 'Pilih Waktu',
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
              theme: theme,
              label: 'Catatan',
              controller: _noteController,
              hint: 'Tulis catatan di sini (opsional)',
              maxLines: 4,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Implementasi logika penyimpanan
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Simpan Rencana',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required ThemeData theme,
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.5),
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
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeField({
    required ThemeData theme,
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.surfaceContainerHighest),
            ),
            child: Row(
              children: [
                Icon(icon, color: colorScheme.onSurfaceVariant, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: theme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
