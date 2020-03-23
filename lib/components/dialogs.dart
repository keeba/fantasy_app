import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

Future<ConfirmAction> showConfirmTransfersAlert(BuildContext context) {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xffD3D3D3),
        titleTextStyle: GoogleFonts.robotoSlab(
          fontWeight: FontWeight.bold,
          fontSize: 35.0,
          color: Colors.black,
        ),
        title: Text('Transfers'),
        content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: getTransferWidgets(context),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'CANCEL',
              style: GoogleFonts.robotoSlab(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
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

Future<bool> showConfirmAlert(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xffD3D3D3),
        titleTextStyle: GoogleFonts.robotoSlab(
          fontWeight: FontWeight.bold,
          fontSize: 35.0,
          color: Colors.black,
        ),
        title: Text('Confirm'),
        content: Text(
          'Are you sure you want to leave this page?',
          style: GoogleFonts.robotoSlab(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'No',
              style: GoogleFonts.robotoSlab(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text(
              'Yes',
              style: GoogleFonts.robotoSlab(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  );
}

List<Widget> getTransferWidgets(context) {
  final data = Provider.of<DataRepository>(context);
  List<Widget> lTransferWidgets = [];
  lTransferWidgets.add(
    Center(
      child: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100],
          border: Border.all(
            color: Colors.lightGreen[900],
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          data.currentMatch,
          style: GoogleFonts.robotoSlab(
            fontSize: 22.5,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    ),
  );

  if (data.phaseStarted) {
    lTransferWidgets.add(
      Center(
        child: Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            border: Border.all(
              color: Colors.orange[500],
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Transfers',
                style: GoogleFonts.robotoSlab(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Before: ' + data.transfersLeft.toString(),
                    style: GoogleFonts.robotoSlab(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  Text(
                    'After: ' +
                        (data.transfersLeft - data.transfersMade).toString(),
                    style: GoogleFonts.robotoSlab(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    lTransferWidgets.add(
      Center(
        child: Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            border: Border.all(
              color: Colors.orange[500],
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            'Transfers: Unlimited',
            style: GoogleFonts.robotoSlab(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  data.lTransfers.forEach(
    (transfer) {
      lTransferWidgets.add(
        Center(
          child: Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              color: transfer.contains('Captain')
                  ? Colors.red[200]
                  : Colors.amberAccent[100],
              border: Border.all(
                color: transfer.contains('Captain')
                    ? Colors.red[900]
                    : Colors.amber[700],
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              transfer,
              style: GoogleFonts.robotoSlab(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      );
    },
  );
  return lTransferWidgets;
}
