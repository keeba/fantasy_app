import 'package:fantasy_app/components/consts.dart';
import 'package:flutter/material.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      pageWidget: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff82E0AA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Team Composition',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 19.2,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '3 Batsmen  ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            playerIcons[1],
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '2 Allrounders  ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            playerIcons[3],
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '1 WK  ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            playerIcons[4],
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '3 Bowlers  ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            playerIcons[2],
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '2 Any  ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            playerIcons[5],
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff82E0AA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Transfers',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Phase 1: ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              ' 80',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Phase 2: ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              ' 10',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Team is locked at scheduled',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'start of play. No of transfers',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'is deducted by comparing',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'the locked teams of current',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'and previous matches.',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff82E0AA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Batting Points',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          PointsCard('1 Run ', '1 Point', true),
                          PointsCard('1 Four', '1 Point', true),
                          PointsCard('1 Six   ', '2 Points', true),
                          PointsCard('25 Runs', '5 Points', true),
                          PointsCard('50 Runs', '15 Points', true),
                          PointsCard('75 Runs', '30 Points', true),
                          PointsCard('100 Runs', '50 Points', true),
                          Text(
                            'Runs - Balls',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '(doubled if positive)',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff82E0AA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Bowling Points',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PointsCard('1 Wkt ', '30 Points', true),
                          PointsCard('2 Wkts', '5 Points', true),
                          PointsCard('3 Wkts', '15 Points', true),
                          PointsCard('4 Wkts', '30 Points', true),
                          PointsCard('5 Wkts', '50 Points', true),
                          PointsCard('1 Maiden', '25 Points', true),
                          Text(
                            'Balls - Runs',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '(doubled if positive)',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff82E0AA),
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
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    PointsCard('1 Catch/Stumping/Runout ', '10 Points', false),
                    PointsCard('Man of the Match', '25 Points', false),
                    Text(
                      'Points will be doubled for captain.',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PointsCard extends StatelessWidget {
  PointsCard(this.text1, this.text2, this.alignment);
  final String text1;
  final String text2;
  final bool alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          alignment ? MainAxisAlignment.start : MainAxisAlignment.center,
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
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
