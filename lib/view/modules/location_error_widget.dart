import 'package:flutter/material.dart';
import 'package:khushoo3/l10n/generated/app_localizations.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    final errorColor = Color(0xffb00020);
    final l10n = AppLocalizations.of(context);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error!,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            box,
            FloatingActionButton(
              child: Text(l10n?.retry ?? "محاولة"),
              onPressed: () {
                if (callback != null) callback!();
              },
            )
          ],
        ),
      ),
    );
  }
}
