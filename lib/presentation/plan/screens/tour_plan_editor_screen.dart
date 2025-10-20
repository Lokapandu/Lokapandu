import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_editor_notifier.dart';
import 'package:lokapandu/presentation/plan/widgets/date_time_form_field.dart';
import 'package:lokapandu/presentation/plan/widgets/selected_tour_card.dart';
import 'package:provider/provider.dart';

class TourPlanEditorScreen extends StatefulWidget {
  final String? id;
  final TourismSpot? tourismSpot;

  const TourPlanEditorScreen({super.key, this.id, this.tourismSpot});

  @override
  State<TourPlanEditorScreen> createState() => _TourPlanEditorScreenState();
}

class _TourPlanEditorScreenState extends State<TourPlanEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<TourPlanEditorNotifier>().resetState();
    // Schedule state changes after the current build frame is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = context.read<TourPlanEditorNotifier>();
      notifier.selectedTour = widget.tourismSpot;

      if (widget.id != null) {
        isEditing = true;
        Future.microtask(() {
          notifier.getPlanById(widget.id!);
        });
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

      var itemSaved = notifier.selectedTour != null
          ? notifier.selectedTour?.name
          : notifier.notes;

      final result = await notifier.savePlan();

      if (mounted) {
        result.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal: ${failure.message}')),
            );
          },
          (_) {
            context.goNamed(
              Routing.plan.routeName,
              extra: '$itemSaved Berhasil ditambahkan!',
            );
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon isi semua field yang wajib.')),
      );
    }
  }

  InputDecoration textInputDecoration(BuildContext context, String hint) =>
      InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        filled: true,

        fillColor: Theme.of(context).colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
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
                  Text('Nama Rencana', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: 1,
                    style: textTheme.bodyLarge,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Rencana tidak boleh kosong!';
                      }
                      return null;
                    },
                    decoration: textInputDecoration(
                      context,
                      'Contoh: Jelajahi Candi Jedong',
                    ),
                    onSaved: (value) => notifier.name = value ?? '',
                  ),
                  const SizedBox(height: 24),
                  Text("Tanggal", style: textTheme.titleMedium),
                  const SizedBox(height: 8),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Waktu Mulai", style: textTheme.titleMedium),
                            const SizedBox(height: 8),
                            DateTimeFormField(
                              label: "Waktu Mulai",
                              hint: 'HH:mm',
                              icon: Icons.access_time_outlined,
                              mode: DateTimeInputMode.time,
                              initialDateTime: notifier.startTime?.toDateTime(),
                              onDateTimeSelected: (date) =>
                                  notifier.startTime = date?.toTimeOfDay(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Waktu Selesai", style: textTheme.titleMedium),
                            const SizedBox(height: 8),
                            DateTimeFormField(
                              label: "Waktu Selesai",
                              hint: 'HH:mm',
                              icon: Icons.access_time_outlined,
                              mode: DateTimeInputMode.time,
                              initialDateTime: notifier.endTime?.toDateTime(),
                              onDateTimeSelected: (date) =>
                                  notifier.endTime = date?.toTimeOfDay(),
                            ),
                          ],
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
                  Text('Catatan', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: 4,
                    style: textTheme.bodyLarge,
                    decoration: textInputDecoration(
                      context,
                      'Tulis catatan di sini (opsional)',
                    ),
                    onSaved: (value) => notifier.notes = value ?? '',
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: notifier.isSubmitting
                        ? null
                        : () => _proceedSavePlan(notifier),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: notifier.isSubmitting
                        ? ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 16,
                              maxWidth: 16,
                            ),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : null,
                    label: Text(
                      notifier.isSubmitting ? 'Menyimpan...' : 'Simpan Rencana',
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
}
