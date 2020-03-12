import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_app/components/player_card.dart';
import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import '../components/wrapper_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/teamcard.dart';
import 'package:provider/provider.dart';
import '../model/player.dart';

class SelectPlayerPage extends StatefulWidget {
  SelectPlayerPage({this.playerType});
  final String playerType;
  @override
  _SelectPlayerPageState createState() => _SelectPlayerPageState();
}

class _SelectPlayerPageState extends State<SelectPlayerPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    return WrapperWidget(
      pageWidget: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8),
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.green[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xff009900),
                    activeTrackColor: Color(0xff253529),
                    thumbColor: Colors.amberAccent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  ),
                  child: Slider(
                    value: data.purseUsed.toDouble(),
                    min: 0,
                    max: 1000000,
                    divisions: 100,
                    onChanged: (double newValue) {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Used: ' + data.purseUsed.toString(),
                      style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff800000),
                      ),
                    ),
                    Text(
                      'Left: ' + data.purseLeft.toString(),
                      style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff008000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 105.0,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Filter By :',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        data.filterPlayers('All');
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.yellow[900], width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.yellow[700],
                        ),
                        child: Text(
                          'Show All',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            TeamCard('CSK', 'edit'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TeamCard('DD', 'edit'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TeamCard('KKR', 'edit'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TeamCard('KXIP', 'edit'),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            TeamCard('MI', 'edit'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TeamCard('RCB', 'edit'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TeamCard('RR', 'edit'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TeamCard('SRH', 'edit'),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: StreamBuilder(
                stream: data.selectablePlayers,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      padding: const EdgeInsets.only(top: 5.0),
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.documents[index];
                        final player = Player.fromFireStore(ds);

                        return data.isNotAnExistingPlayer(player)
                            ? PlayerEdit(player)
                            : SizedBox.shrink();
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Players to select',
                        style: GoogleFonts.robotoSlab(fontSize: 20.0),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
