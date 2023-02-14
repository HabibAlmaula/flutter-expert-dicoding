import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Exit?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text('Exit'),
        ),
      ],
    );
  }
}
