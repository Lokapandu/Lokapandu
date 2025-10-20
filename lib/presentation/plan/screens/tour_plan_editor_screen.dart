import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/plan/models/plan_item_model.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_editor_notifier.dart';
import 'package:lokapandu/presentation/plan/widgets/date_time_form_field.dart';
import 'package:lokapandu/presentation/plan/widgets/selected_tour_card.dart';
import 'package:provider/provider.dart';

class TourPlanEditorScreen extends StatefulWidget {
  final PlanItem? planItem;
  final TourismSpot? tourismSpot;

  const TourPlanEditorScreen({super.key, this.planItem, this.tourismSpot});

  @override
  State<TourPlanEditorScreen> createState() => _TourPlanEditorScreenState();
}

class _TourPlanEditorScreenState extends State<TourPlanEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.planItem != null;

  @override
  void initState() {
    super.initState();

    // Schedule state changes after the current build frame is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = context.read<TourPlanEditorNotifier>();

      notifier.selectedTour = widget.tourismSpot;

      if (isEditing) {
        // TODO: Logika untuk mengisi data saat mode edit
        // Misalnya:
        // notifier.setName(widget.planItem!.name);
        // notifier.setDate(widget.planItem!.startTime); // Anggap planItem punya properti ini
      } else {
        notifier.date = DateTime.now();
      }
    });
  }

  Future<void> _navigateToSearchScreen() async {
    // Navigasi ke halaman pencarian wisata, menunggu hasil berupa TourismSpot
    final result = await context.push<TourismSpot>('/plan/search-tour');

    if (result != null && mounted) {
      context.read<TourPlanEditorNotifier>().selectedTour = result;
    }
  }

  Future<void> _proceedSavePlan(TourPlanEditorNotifier notifier) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final result = await notifier.savePlan();

      if (mounted) {
        result.fold(
          (failure) {
            print('ADA ERROR INI: $failure');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal: ${failure.message}')),
            );
          },
          (_) {
            print('SUCCESS!!!');
            // context.goNamed(Routing.plan.routeName);
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon isi semua field yang wajib.')),
      );
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
        shadowColor: theme.shadowColor.withValues(alpha: 0.1),
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
        child: Consumer<TourPlanEditorNotifier>(
          builder: (context, notifier, child) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTextField(
                    context: context,
                    label: 'Nama Rencana',
                    hint: 'Contoh: Jelajahi Candi Jedong',
                    onSaved: (value) => notifier.name = value ?? '',
                  ),
                  const SizedBox(height: 24),
                  DateTimeFormField(
                    label: 'Tanggal',
                    hint: 'Pilih Tanggal',
                    icon: Icons.calendar_today_outlined,
                    initialDateTime: notifier.date,
                    mode: DateTimeInputMode.date,
                    onDateTimeSelected: (date) => notifier.date = date,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DateTimeFormField(
                          label: "Waktu Mulai",
                          hint: 'HH:mm',
                          icon: Icons.access_time_outlined,
                          mode: DateTimeInputMode.time,
                          initialDateTime: notifier.startTime?.toDateTime(),
                          onDateTimeSelected: (date) =>
                              notifier.startTime = date?.toTimeOfDay(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DateTimeFormField(
                          label: "Waktu Selesai",
                          hint: 'HH:mm',
                          icon: Icons.access_time_outlined,
                          mode: DateTimeInputMode.time,
                          initialDateTime: notifier.endTime?.toDateTime(),
                          onDateTimeSelected: (date) =>
                              notifier.endTime = date?.toTimeOfDay(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SelectedTourCard(
                    selectedTour: notifier.selectedTour,
                    onTap: _navigateToSearchScreen,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    context: context,
                    label: 'Catatan',
                    hint: 'Tulis catatan di sini (opsional)',
                    optional: true,
                    maxLines: 4,
                    onSaved: (value) => notifier.notes = value ?? '',
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () => _proceedSavePlan(notifier),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: notifier.isSubmitting
                        ? CircularProgressIndicator()
                        : null,
                    label: Text(
                      notifier.isSubmitting ? 'Menyimpan...' : 'Simpan Rencana',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    bool optional = false,
    void Function(String?)? onSaved,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          style: textTheme.bodyLarge,
          validator: !optional
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$label tidak boleh kosong!';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
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
          ),
          onSaved: onSaved,
        ),
      ],
    );
  }
}
