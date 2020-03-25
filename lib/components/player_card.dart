import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fantasy_app/model/player.dart';
import 'package:fantasy_app/components/consts.dart';
import 'package:fantasy_app/components/team_card.dart';
import 'package:provider/provider.dart';

class Captain extends StatelessWidget {
  const Captain({
    Key key,
    this.edit: false,
  }) : super(key: key);

  final bool edit;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    final player = data.hCurrentPlayers['captain'];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (edit) {
            data.setCaptainPlayers();
            Navigator.pushNamed(context, 'selectcaptain');
          }
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.crown,
                    color: Colors.red[400],
                    size: 50.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      '   (C)',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    player.id > 0 ? player.displayName(true) : 'Captain',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerEdit extends StatelessWidget {
  PlayerEdit(this.player);

  final Player player;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    return Container(
      height: 50.0,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 60.0,
            child: Image(
              image: AssetImage('images/${player.team}.png'),
            ),
          ),
          Container(
            width: 50.0,
            child: playerIcons[player.type],
          ),
          Container(
            width: 150,
            child: Text(
              player.overseas ? player.name + ' (O)' : player.name,
              style: GoogleFonts.robotoSlab(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: teamColors[player.team]['textColor'],
              ),
            ),
          ),
          Text(
            player.salary.toString(),
            style: GoogleFonts.robotoSlab(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: teamColors[player.team]['textColor']),
          ),
          SizedBox(
            width: 10,
          ),
          data.playerSelectable(player)
              ? GestureDetector(
                  onTap: () {
                    data.selectPlayer(player);
                    Navigator.pop(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.checkCircle,
                    color: teamColors[player.team]['textColor'],
                    size: 25,
                  ),
                )
              : Icon(
                  FontAwesomeIcons.timesCircle,
                  color: teamColors[player.team]['textColor'],
                  size: 25,
                ),
        ],
      ),
    );
  }
}

class PlayerShow extends StatelessWidget {
  PlayerShow({this.edit: false, this.playerType});

  final bool edit;
  final String playerType;
  final lSpacePlayers = [
    'player7',
    'player8',
    'player9',
    'player10',
    'player11'
  ];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    final player = data.hCurrentPlayers[playerType];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (edit) {
            data.setSelectablePlayers(playerType);
            Navigator.pushNamed(context, 'selectplayer');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TeamCard(player.team, edit ? 'show2' : 'show'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: playerTypeIcons[playerType],
                ),
                lSpacePlayers.contains(playerType)
                    ? SizedBox(
                        width: 5.0,
                      )
                    : SizedBox.shrink(),
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    player.displayName(false),
                    style: GoogleFonts.robotoSlab(
                      fontSize:
                          player.displayName(false).length > 12 ? 13.0 : 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
