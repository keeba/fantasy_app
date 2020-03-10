import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fantasy_app/components/consts.dart';
import 'package:provider/provider.dart';

class TeamCard extends StatelessWidget {
  TeamCard(this.teamText, this.iconKey);

  final String teamText;
  final String iconKey;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    if (iconKey == 'show') {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.solidUser,
            color: teamColors[teamText]['iconColor'],
            size: 50.0,
          ),
          Text(
            teamText,
            style: GoogleFonts.robotoSlab(
              fontSize: 12,
              color: teamColors[teamText]['textColor'],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else if (iconKey == 'show2') {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.userEdit,
            color: teamColors[teamText]['iconColor'],
            size: 50.0,
          ),
          Text(
            teamText + '    ',
            style: GoogleFonts.robotoSlab(
              fontSize: 12,
              color: teamColors[teamText]['textColor'],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {
          data.filterPlayers(teamText);
        },
        child: Container(
          height: 40.0,
          width: 60.0,
          margin: EdgeInsets.only(left: 2.0, right: 2.0),
          child: Image(
            image: AssetImage('images/$teamText.png'),
          ),
        ),
      );
    }
  }
}
