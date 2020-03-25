import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_app/components/points_card.dart';
import 'package:fantasy_app/model/player.dart';

class PointsPage extends StatefulWidget {
  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    if (data.phaseStarted == false && data.totalTransfers == 80) {
      return WrapperWidget(
        pageWidget: Center(
          child: Text(
            'IPL not started yet.',
            style: GoogleFonts.robotoSlab(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
        ),
      );
    } else {
      return WrapperWidget(
        pageWidget: data.status == DataStatus.Loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            data.selectedTeam = data.team1;
                            data.setPointsStream();
                          },
                          child: Container(
                            height: 40.0,
                            width: 60.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: Image(
                              image: AssetImage('images/${data.team1}.png'),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: data.selectedMatch,
                          icon: Icon(FontAwesomeIcons.arrowDown),
                          iconSize: 16,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.amber[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.amberAccent,
                          ),
                          onChanged: (String newValue) async {
                            if (newValue != data.selectedMatch) {
                              data.updatePointsPage(newValue);
                            }
                          },
                          items: data.matches.map<DropdownMenuItem<String>>(
                            (match) {
                              return DropdownMenuItem<String>(
                                value: match['name'],
                                child: Text(match['name']),
                              );
                            },
                          ).toList(),
                        ),
                        GestureDetector(
                          onTap: () {
                            data.selectedTeam = data.team2;
                            data.setPointsStream();
                          },
                          child: Container(
                            height: 40.0,
                            width: 60.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: Image(
                              image: AssetImage('images/${data.team2}.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: StreamBuilder(
                          stream: data.pointsStream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data.data.keys.length > 0) {
                              DocumentSnapshot pointsDS = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: pointsDS.data.keys.length + 1,
                                padding: const EdgeInsets.only(top: 5.0),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return PointsTitle();
                                  } else {
                                    index = index - 1;
                                    String playerID =
                                        pointsDS.data.keys.toList()[index];
                                    String points = pointsDS.data[playerID];
                                    List<String> lPoints = points.split(',');
                                    Player player = data.getPlayer(playerID);
                                    return PointsCard(player, lPoints);
                                  }
                                },
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Points yet to be updated.',
                                  style: GoogleFonts.robotoSlab(fontSize: 20.0),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
      );
    }
  }
}
