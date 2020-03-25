import 'package:flutter/material.dart';
import 'package:fantasy_app/components/consts.dart';
import 'package:fantasy_app/model/player.dart';
import 'package:google_fonts/google_fonts.dart';

class PointsCard extends StatelessWidget {
  PointsCard(this.player, this.lPoints);
  final Player player;
  final List<String> lPoints;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 2.5),
      decoration: BoxDecoration(
        color: teamColors[player.team]['iconColor'],
        border: Border.all(
          color: teamColors[player.team]['textColor'],
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Image(
                image: AssetImage('images/${player.team}.png'),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: Text(
                player.displayName(false),
                style: GoogleFonts.robotoSlab(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: teamColors[player.team]['textColor'],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                lPoints[1],
                style: GoogleFonts.robotoSlab(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: teamColors[player.team]['textColor']),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                lPoints[2],
                style: GoogleFonts.robotoSlab(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: teamColors[player.team]['textColor']),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                lPoints[3],
                style: GoogleFonts.robotoSlab(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: teamColors[player.team]['textColor']),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                lPoints[0],
                style: GoogleFonts.robotoSlab(
                    fontSize: 17.5,
                    fontWeight: FontWeight.bold,
                    color: teamColors[player.team]['textColor']),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PointsTitle extends StatelessWidget {
  const PointsTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Team',
                style: GoogleFonts.robotoSlab(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: Text(
                'Player',
                style: GoogleFonts.robotoSlab(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: playerIcons[1],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: playerIcons[2],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Others',
                style: GoogleFonts.robotoSlab(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Total',
                style: GoogleFonts.robotoSlab(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
