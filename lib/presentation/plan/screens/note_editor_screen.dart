import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_editor_notifier.dart';
import 'package:lokapandu/presentation/plan/widgets/date_time_form_field.dart';
import 'package:provider/provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final String? id;

  const NoteEditorScreen({super.key, this.id});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = context.read<TourPlanEditorNotifier>();
      notifier.resetState();
      if (widget.id != null) {
        isEditing = true;
        Future.microtask(() {
          notifier.getPlanById(widget.id!);
        });
      }
    });
  }

  Future<void> _proceedSaveNote(TourPlanEditorNotifier notifier) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var itemSaved = notifier.name.isEmpty ? notifier.notes : notifier.name;
      final result = await notifier.savePlan();

      result.fold(
        (failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Gagal: ${failure.message}')));
        },
        (_) {
          context.goNamed(
            Routing.plan.routeName,
            extra: '$itemSaved Berhasil ditambahkan!',
          );
        },
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
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

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
          isEditing ? 'Edit Catatan' : 'Tambah Catatan',
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
                    maxLines: 1,
                    style: textTheme.bodyLarge,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul Catatan tidak boleh kosong!';
                      }
                      return null;
                    },
                    decoration: textInputDecoration(
                      context,
                      'Contoh: Beli oleh-oleh khas Bali',
                    ),
                    onSaved: (value) => notifier.name = value ?? '',
                  ),
                  const SizedBox(height: 24),
                  Text("Waktu Mulai", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DateTimeFormField(
                          label: "Tanggal Mulai",
                          hint: "dd MM YYYY",
                          icon: Icons.calendar_today_outlined,
                          mode: DateTimeInputMode.date,
                          initialDateTime: notifier.date,
                          onDateTimeSelected: (date) => notifier.date = date,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: DateTimeFormField(
                          label: "Tanggal Selesai",
                          hint: "dd MM YYYY",
                          icon: Icons.calendar_today_outlined,
                          mode: DateTimeInputMode.date,
                          initialDateTime: notifier.endDate,
                          onDateTimeSelected: (date) => notifier.endDate = date,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: DateTimeFormField(
                          label: "Waktu Selesai",
                          hint: "HH:mm",
                          icon: Icons.access_time_outlined,
                          mode: DateTimeInputMode.time,
                          initialDateTime: notifier.startTime?.toDateTime(),
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
                        : () => _proceedSaveNote(notifier),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
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
                      notifier.isSubmitting ? 'Menyimpan...' : 'Simpan Catatan',
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
