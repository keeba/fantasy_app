import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ConfirmAction { CANCEL, ACCEPT }

Future<void> showAlert(
  BuildContext context,
  String titleText,
  String errorMessage,
  Color bgColor,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Text(titleText),
        content: Text(
          errorMessage,
          style: GoogleFonts.robotoSlab(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'OK',
              style: GoogleFonts.robotoSlab(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<ConfirmAction> showConfirmAlert(
  BuildContext context,
  String titleText,
  String message,
  Color bgColor,
) {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Text(titleText),
        content: Text(
          message,
          style: GoogleFonts.robotoSlab(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'CANCEL',
              style: GoogleFonts.robotoSlab(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.red[900],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text(
              'ACCEPT',
              style: GoogleFonts.robotoSlab(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
