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
            color: Color(0xffABEBC6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54, width: 2.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: new LayoutBuilder(
                builder: (context, constraint) {
                  return new Icon(
                    fontIcon,
                    size: constraint.biggest.height,
                    color: Colors.black54,
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: GoogleFonts.robotoSlab(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
