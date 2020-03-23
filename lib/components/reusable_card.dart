import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.onPress, @required this.title, @required this.fontIcon});

  final String title;
  final Function onPress;
  final IconData fontIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green[900], width: 2.0)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: new LayoutBuilder(
                builder: (context, constraint) {
                  return Center(
                    child: new Icon(
                      fontIcon,
                      size: constraint.biggest.height,
                      color: Colors.black54,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.robotoSlab(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
