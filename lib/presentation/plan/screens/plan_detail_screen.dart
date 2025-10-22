import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:intl/intl.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_detail_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
import 'package:lokapandu/presentation/plan/route/tour_plan_editor_extra.dart';
import 'package:lokapandu/presentation/plan/utils/snackbar_util.dart';
import 'package:provider/provider.dart';

class PlanDetailScreen extends StatefulWidget {
  final String id;

  const PlanDetailScreen({super.key, required this.id});

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TourPlanDetailNotifier>().fetchItinerary(widget.id);
    });
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    TourPlanDetailNotifier notifier,
  ) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Konfirmasi Hapus'),
              content: isLoading
                  ? Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : const Text(
                      'Apakah Anda yakin ingin menghapus rencana ini?',
                    ),
              actions: isLoading
                  ? []
                  : [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await notifier.removeItinerary(widget.id);
                          if (dialogContext.mounted) {
                            Navigator.of(
                              dialogContext,
                            ).pop(notifier.hasRemoved);
                          }
                        },
                        child: Text(
                          'Hapus',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
            );
          },
        );
      },
    );

    if (result == true && context.mounted) {
      context.read<TourPlanNotifier>().fetchItineraries();
      context.pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackbar('Rencana berhasil dihapus!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 4.0,
          title: Text(
            'Detail Rencana',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            Consumer<TourPlanDetailNotifier>(
              builder: (context, notifier, child) {
                return IconButton(
                  onPressed: notifier.hasData
                      ? () {
                          notifier.hasTourism
                              ? context.pushNamed(
                                  Routing.planAdd.routeName,
                                  extra: TourPlanEditorExtra(
                                    editorModel: notifier.model,
                                  ),
                                )
                              : context.pushNamed(
                                  Routing.planAddNote.routeName,
                                  extra: TourPlanEditorExtra(
                                    editorModel: notifier.model,
                                  ),
                                );
                        }
                      : null,
                  icon: Icon(Icons.edit),
                );
              },
            ),
            Consumer<TourPlanDetailNotifier>(
              builder: (context, notifier, child) {
                return IconButton(
                  onPressed: notifier.hasData
                      ? () => _showDeleteConfirmationDialog(context, notifier)
                      : null,
                  icon: Icon(Icons.delete, color: colorScheme.error),
                );
              },
            ),
          ],
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<TourPlanDetailNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (notifier.hasError) {
                return Center(
                  child: Text('Ada masalah: ${notifier.errorMessage}'),
                );
              }
              if (notifier.hasData) {
                final data = notifier.model!;
                final date = DateFormat(
                  'EEEE, dd MMM yyyy',
                  'id_ID',
                ).format(data.startDate!);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconifyIcon(
                        icon: 'icon-park-solid:vacation',
                        color: colorScheme.secondary,
                      ),
                      title: Text(data.name, style: textTheme.titleMedium),
                      subtitle: Text(
                        '$date | ${data.startTime?.toString24()} - ${data.endTime?.toString24()}',
                        style: textTheme.bodySmall,
                      ),
                    ),
                    if (notifier.hasTourism) ...[
                      Text('Wisata', style: textTheme.bodyMedium),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: BoxBorder.all(color: colorScheme.outline),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  data.tourismSpot?.images.isNotEmpty == true
                                  ? data.tourismSpot!.images.first.imageUrl
                                  : '',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: colorScheme.surfaceContainerHighest,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image_outlined),
                            ),
                          ),
                          title: Text(
                            data.tourismSpot?.name ?? '',
                            style: textTheme.titleMedium,
                          ),
                          subtitle: Row(
                            children: [
                              IconifyIcon(
                                icon: 'material-symbols:location-on-rounded',
                                color: colorScheme.primary,
                                size: 12,
                              ),
                              Text(
                                '${data.tourismSpot?.city}, ${data.tourismSpot?.province}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    Text('Catatan', style: textTheme.bodyMedium),
                    IgnorePointer(
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        minLines: 3,
                        controller: TextEditingController(
                          text: data.notes?.isEmpty ?? true
                              ? 'Tidak ada catatan'
                              : data.notes!,
                        ),
                        style: data.notes?.isEmpty ?? true
                            ? TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              )
                            : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
