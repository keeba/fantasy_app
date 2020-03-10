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
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              fontIcon,
              color: Colors.green[900],
              size: 50,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              style: GoogleFonts.robotoSlab(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
