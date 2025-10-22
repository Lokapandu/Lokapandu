import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_editor_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
import 'package:lokapandu/presentation/plan/utils/snackbar_util.dart';
import 'package:lokapandu/presentation/plan/widgets/date_time_form_field.dart';
import 'package:provider/provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final TourPlanModel? editorModel;

  const NoteEditorScreen({super.key, this.editorModel});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
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

  Future<void> _proceedSaveNote(TourPlanEditorNotifier notifier) async {
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
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
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
          widget.editorModel != null ? 'Edit Catatan' : 'Tambah Catatan',
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
                children: [
                  Text('Judul Catatan', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    maxLines: 1,
                    style: textTheme.bodyLarge,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul Catatan tidak boleh kosong!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Contoh: Beli oleh-oleh khas Bali',
                    ),

                    onSaved: (value) => notifier.name = value ?? '',
                  ),
                  const SizedBox(height: 24),
                  Text("Waktu Mulai", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DateTimeFormField(
                          label: "Tanggal Mulai",
                          hint: "DD/MM/YYYY",
                          icon: Icons.calendar_today_outlined,
                          mode: DateTimeInputMode.date,
                          initialDateTime: notifier.date,
                          onDateTimeSelected: (date) => notifier.date = date,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DateTimeFormField(
                          label: "Waktu Mulai",
                          hint: "HH:mm",
                          icon: Icons.access_time_outlined,
                          mode: DateTimeInputMode.time,
                          initialDateTime: notifier.startTime?.toDateTime(),
                          onDateTimeSelected: (date) {
                            if (date != null) {
                              notifier.startTime = date.toTimeOfDay();
                            }
                            return;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text("Waktu Selesai", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DateTimeFormField(
                          label: "Tanggal Selesai",
                          hint: "DD/MM/YYYY",
                          icon: Icons.calendar_today_outlined,
                          mode: DateTimeInputMode.date,
                          initialDateTime: notifier.endDate,
                          onDateTimeSelected: (date) => notifier.endDate = date,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DateTimeFormField(
                          label: "Waktu Selesai",
                          hint: "HH:mm",
                          icon: Icons.access_time_outlined,
                          mode: DateTimeInputMode.time,
                          initialDateTime: notifier.endTime?.toDateTime(),
                          onDateTimeSelected: (date) {
                            if (date != null) {
                              notifier.endTime = date.toTimeOfDay();
                            }
                            return;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Catatan', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 4,
                    style: textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Tulis catatan di sini',
                    ),

                    validator: (value) => value == null || value.isEmpty
                        ? 'Catatan tidak boleh kosong!'
                        : null,
                    onSaved: (value) => notifier.notes = value ?? '',
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: notifier.isSubmitting
                          ? null
                          : () => _proceedSaveNote(notifier),
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
                            : 'Simpan Catatan',
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
}
