import 'package:flutter/material.dart';
import 'package:khushoo3/l10n/generated/app_localizations.dart';
import 'package:khushoo3/view/modules/salatSlider.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';

Future<void> showPrayerTimeSettingsDialog(
  BuildContext context,
  HomePageVM viewModel,
) async {
  final offsets = await viewModel.loadPrayerTimeOffsets();
  if (!context.mounted) return;

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext);
      return StatefulBuilder(
        builder: (context, setState) {
          return Directionality(
            textDirection: Directionality.of(dialogContext),
            child: AlertDialog(
              backgroundColor: Backgroundcolor,
              title: Text(
                l10n?.prayerTimeSettings ?? 'إعدادات مواقيت الصلاة',
                style: TextStyle(color: LightTextColor),
              ),
              content: SizedBox(
                width: 420,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n?.prayerTimeSettingsDescription ??
                            'التوقيت الصيفي يُحتسب تلقائيًا حسب الموقع والتاريخ. يمكنك ضبط كل وقت يدويًا بالدقائق.',
                        style: TextStyle(color: LightTextColor),
                      ),
                      const SizedBox(height: 12),
                      ...offsets.keys.map((prayer) {
                        final minutes = offsets[prayer]!;
                        final adjustment = minutes == 0
                            ? (l10n?.noAdjustment ?? 'بدون تعديل')
                            : (l10n?.minuteAdjustment(
                                    '${minutes > 0 ? '+' : ''}$minutes') ??
                                '${minutes > 0 ? '+' : ''}$minutes دقيقة');
                        return ListTile(
                          dense: true,
                          title: Text(
                            getLocalizedPrayerName(dialogContext, prayer),
                            style: TextStyle(color: LightTextColor),
                          ),
                          subtitle: Text(
                            adjustment,
                            style: TextStyle(color: LightGolden),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: l10n?.increaseMinute ?? 'تقديم دقيقة',
                                onPressed: minutes >= 120
                                    ? null
                                    : () => setState(
                                          () => offsets[prayer] = minutes + 1,
                                        ),
                                icon: const Icon(Icons.add),
                              ),
                              IconButton(
                                tooltip: l10n?.decreaseMinute ?? 'تأخير دقيقة',
                                onPressed: minutes <= -120
                                    ? null
                                    : () => setState(
                                          () => offsets[prayer] = minutes - 1,
                                        ),
                                icon: const Icon(Icons.remove),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    for (final prayer in offsets.keys) {
                      offsets[prayer] = 0;
                    }
                  }),
                  child: Text(l10n?.reset ?? 'إعادة الضبط'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(l10n?.close ?? 'إلغاء'),
                ),
                FilledButton(
                  onPressed: () async {
                    await viewModel.savePrayerTimeOffsets(offsets);
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: Text(l10n?.close != null ? (l10n?.language == 'Language' ? 'Save' : (l10n?.localeName == 'fr' ? 'Enregistrer' : 'حفظ')) : 'حفظ'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
