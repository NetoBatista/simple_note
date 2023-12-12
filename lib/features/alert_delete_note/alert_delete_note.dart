import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/core/util/navigation_util.dart';

class AlertDeleteNote {
  final BuildContext _context;

  AlertDeleteNote(this._context);

  Future<bool> showAlertDelete() async {
    if (!_context.mounted) {
      return false;
    }
    var deleteItem = await showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.info_outline,
            size: 32,
          ),
          title: Text('are_you_sure_you_want_to_delete'.i18n()),
          actions: [
            OutlinedButton(
              onPressed: NavigationUtil.pop,
              child: Text('no'.i18n()),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                NavigationUtil.pop(true);
              },
              child: Text('yes'.i18n()),
            ),
          ],
        );
      },
    );
    return deleteItem == true;
  }
}
