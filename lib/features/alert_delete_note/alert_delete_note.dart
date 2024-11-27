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
          title: Text('remove_note'.i18n()),
          content: Text('are_you_sure_you_want_to_delete'.i18n()),
          actions: [
            TextButton(
              onPressed: NavigationUtil.pop,
              child: Text('no'.i18n()),
            ),
            const SizedBox(width: 16),
            TextButton(
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
