import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WrapperWidget extends StatelessWidget {
  WrapperWidget({@required this.pageWidget});
  final Widget pageWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff0077AA),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'IPL Fantasy',
            style: GoogleFonts.robotoSlab(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.white70,
            ),
          ),
          backgroundColor: Color(0xff00AACC),
          centerTitle: true,
        ),
        body: pageWidget,
      ),
    );
  }
}
