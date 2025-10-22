import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_editor_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
import 'package:lokapandu/presentation/plan/utils/snackbar_util.dart';
import 'package:lokapandu/presentation/plan/widgets/date_time_form_field.dart';
import 'package:lokapandu/presentation/plan/widgets/selected_tour_card.dart';
import 'package:provider/provider.dart';

class TourPlanEditorScreen extends StatefulWidget {
  final TourPlanModel? editorModel;
  final TourismSpot? tourismSpot;

  const TourPlanEditorScreen({super.key, this.editorModel, this.tourismSpot});

  @override
  State<TourPlanEditorScreen> createState() => _TourPlanEditorScreenState();
}

class _TourPlanEditorScreenState extends State<TourPlanEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    // Controller initialization
    _nameController = TextEditingController();
    _notesController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final notifier = context.read<TourPlanEditorNotifier>();
        notifier.resetState();

        notifier.selectedTour = widget.tourismSpot;

        if (widget.editorModel != null) {
          notifier.populateFormWithItineraryData(widget.editorModel!);
        }

        _nameController.text = notifier.name;
        _notesController.text = notifier.notes;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSearchScreen() async {
    // Navigasi ke halaman pencarian wisata, menunggu hasil berupa TourismSpot
    // Using pushNamed with unique key to avoid duplicate page keys
    final result = await context.pushNamed<TourismSpot>(
      Routing.planSearch.routeName,
    );

    if (result != null && mounted) {
      context.read<TourPlanEditorNotifier>().selectedTour = result;
    }
  }

  Future<void> _proceedSavePlan(TourPlanEditorNotifier notifier) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await notifier.savePlan();

      if (mounted) {
        if (notifier.hasError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(snackbar('Gagal: ${notifier.errorMessage}'));
        }

        if (notifier.success) {
          context.read<TourPlanNotifier>().fetchItineraries();
          context.goNamed(Routing.plan.routeName);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(snackbar('${notifier.successMessage}'));
        }
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackbar('Mohon isi semua field yang wajib.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
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
            widget.editorModel != null ? 'Edit Rencana' : 'Tambah Rencana',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Nama Rencana', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      maxLines: 1,
                      style: textTheme.bodyLarge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Rencana tidak boleh kosong!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Contoh: Jelajahi Candi Jedong',
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
                                initialDateTime: notifier.startTime
                                    ?.toDateTime(),
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
                              Text(
                                "Waktu Selesai",
                                style: textTheme.titleMedium,
                              ),
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
                      controller: _notesController,
                      maxLines: 4,
                      style: textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        hintText: 'Tulis catatan di sini (opsional)',
                      ),
                      onSaved: (value) => notifier.notes = value ?? '',
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: notifier.isSubmitting
                            ? null
                            : () => _proceedSavePlan(notifier),
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
                          notifier.isSubmitting
                              ? 'Menyimpan...'
                              : 'Simpan Rencana',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
