import 'package:fantasy_app/components/consts.dart';
import 'package:flutter/material.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      pageWidget: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.lime[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Team Composition',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 19.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '3 Batsmen  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    playerIcons[1],
                    Text(
                      '  +  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '2 Allrounders  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    playerIcons[3],
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '1 WK  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    playerIcons[4],
                    Text(
                      '  +  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '3 Bowlers  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    playerIcons[2],
                    Text(
                      '  +  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '2 Any  ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    playerIcons[5],
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Transfers',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Phase 1: ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      ' 80',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      'Phase 2: ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      ' 10',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Team is locked at the scheduled start of play.',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'No. of transfers is deducted at the',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'scheduled start of the play by comparaing',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'the locked teams of current and previous',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'matches, till then transfers made are',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'shown as pending transfers.',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.lime[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Batting Points',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                PointsCard('1 Run ', '1 Point'),
                PointsCard('1 Four', '1 Point'),
                PointsCard('1 Six   ', '2 Points'),
                PointsCard('25 Runs', '5 Points'),
                PointsCard('50 Runs', '15 Points'),
                PointsCard('75 Runs', '30 Points'),
                PointsCard('100 Runs', '50 Points'),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Runs - Balls (doubled if positive)',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Bowling Points',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                PointsCard('1 Wkt ', '30 Points'),
                PointsCard('2 Wkts', '5 Points'),
                PointsCard('3 Wkts', '15 Points'),
                PointsCard('4 Wkts', '30 Points'),
                PointsCard('5 Wkts', '50 Points'),
                PointsCard('1 Maiden', '25 Points'),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Balls - Runs (doubled if positive)',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.lime[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Other Points',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                PointsCard('1 Catch/Stumping/Runout ', '10 Points'),
                PointsCard('Man of the Match', '25 Points'),
                Text(
                  'Points will be doubled for captain.',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PointsCard extends StatelessWidget {
  PointsCard(this.text1, this.text2);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text1,
          style: GoogleFonts.robotoSlab(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          ' = ',
          style: GoogleFonts.robotoSlab(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          text2,
          style: GoogleFonts.robotoSlab(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.red[300],
          ),
        ),
      ],
    );
  }
}
