import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_app/model/player.dart';
import 'package:flutter/foundation.dart';

enum DataStatus { Loaded, Loading, NotLoaded, Saved, Failed }

class DataRepository extends ChangeNotifier {
  final Firestore _db = Firestore.instance;

  DataStatus _status = DataStatus.NotLoaded;
  DocumentSnapshot _userData;
  Map _players = {};
  List _matches = [];
  DocumentSnapshot _configurations;
  String _currentMatch;
  String _prevMatch;
  Map _hCurrentPlayers = {};
  String _userEmail;
  String _selectedPlayerIndex;
  int _selectedPlayerType;
  int _purseUsed = 0;
  int _purseLeft = 1000000;
  Stream<QuerySnapshot> _selectablePlayers;
  List<Player> _lSelectedPlayers = [];
  List<int> _lPrevSelectedPlayers = [];
  int _transfersMade = 0;
  int _transfersLeft;
  int _totalTransfers;
  int _pendingTransfers;
  bool _phaseStarted;
  String _selectedMatch;
  List<String> _lTransfers = [];
  String _team1;
  String _team2;
  String _selectedTeam;
  Stream<DocumentSnapshot> _pointsStream;
  Stream<DocumentSnapshot> _rankingsStream;

  DataStatus get status => _status;
  DocumentSnapshot get userData => _userData;
  DocumentSnapshot get configurations => _configurations;
  List get matches => _matches;
  String get currentMatch => _currentMatch;
  String get prevMatch => _prevMatch;
  Map get hCurrentPlayers => _hCurrentPlayers;
  int get purseUsed => _purseUsed;
  int get purseLeft => _purseLeft;
  Stream<QuerySnapshot> get selectablePlayers => _selectablePlayers;
  List<Player> get lSelectedPlayers => _lSelectedPlayers;
  int get transfersMade => _transfersMade;
  int get transfersLeft => _transfersLeft;
  int get totalTransfers => _totalTransfers;
  int get pendingTransfers => _pendingTransfers;
  bool get phaseStarted => _phaseStarted;
  String get selectedMatch => _selectedMatch;
  List<String> get lTransfers => _lTransfers;
  String get team1 => _team1;
  String get team2 => _team2;
  String get selectedTeam => _selectedTeam;
  Stream<DocumentSnapshot> get pointsStream => _pointsStream;
  Stream<DocumentSnapshot> get rankingsStream => _rankingsStream;
  String get userEmail => _userEmail;

  set selectedMatch(match) => _selectedMatch = match;
  set userEmail(email) => _userEmail = email;
  set selectedTeam(team) => _selectedTeam = team;

  Map _hPlayerIndexes = {
    'player1': {'name': 'Player 1', 'type': 1},
    'player2': {'name': 'Player 2', 'type': 1},
    'player3': {'name': 'Player 3', 'type': 1},
    'player4': {'name': 'Player 4', 'type': 3},
    'player5': {'name': 'Player 5', 'type': 3},
    'player6': {'name': 'Player 6', 'type': 4},
    'player7': {'name': 'Player 7', 'type': 2},
    'player8': {'name': 'Player 8', 'type': 2},
    'player9': {'name': 'Player 9', 'type': 2},
    'player10': {'name': 'Player 10', 'type': 5},
    'player11': {'name': 'Player 11', 'type': 5},
    'captain': {'name': 'Captain'}
  };

  Future<void> getData() async {
    try {
      _status = DataStatus.Loading;
      notifyListeners();

      //get players data
      await getPlayersData();

      // get configurations
      await getConfigData();

      // get matches data
      await getMatchesData();

      //get user data
      await getUserData();

      _status = DataStatus.Loaded;
      notifyListeners();
    } catch (e) {
      _status = DataStatus.NotLoaded;
      notifyListeners();
    }
  }

  Future<void> getPlayersData() async {
    QuerySnapshot playersQS = await _db.collection('players').getDocuments();
    playersQS.documents.forEach((doc) => _players[doc['id']] = doc);
  }

  Future<void> getConfigData() async {
    DocumentSnapshot configDS =
        await _db.collection('configurations').document('configurations').get();
    _configurations = configDS;
    _phaseStarted = configDS['phase_started'];
    _totalTransfers = configDS['phase_transfers'];
    _currentMatch = configDS['current_match'];
    _prevMatch = configDS['prev_match'];
    _selectedMatch = _currentMatch;
  }

  Future<void> getMatchesData() async {
    _matches = [];
    QuerySnapshot matchesQS = await _db
        .collection('matches')
        .where("name", isLessThanOrEqualTo: _currentMatch)
        .orderBy("name", descending: true)
        .getDocuments();
    matchesQS.documents.forEach(
      (match) {
        _matches.add(match);
      },
    );
  }

  Future<void> getUserData() async {
    if (_userEmail != null) {
      _status = DataStatus.Loading;
      notifyListeners();
      // get user data
      DocumentSnapshot userDataDS =
          await _db.collection('users').document(_userEmail).get();
      _userData = userDataDS;
      _transfersLeft = userDataDS['transfers_left'];
      _pendingTransfers = userDataDS['pending_transfers'];

      await getPlayersList(_currentMatch);
      await getPrevPlayersList();
    }
  }

  Future<void> getPlayersList(match) async {
    _status = DataStatus.Loading;
    notifyListeners();
    _hCurrentPlayers = {};
    DocumentSnapshot currentMatchDS = await _db
        .collection('users')
        .document(_userEmail)
        .collection(match)
        .document('team')
        .get();

    if (currentMatchDS != null && currentMatchDS.data != null) {
      _hPlayerIndexes.forEach(
        (key, val) {
          Player player = Player.fromFireStore(_players[currentMatchDS[key]]);
          _hCurrentPlayers[key] = player;
        },
      );
    } else {
      _hPlayerIndexes.forEach(
        (key, val) {
          Player player = Player(
            id: 0,
            name: val['name'],
            key: val['name'],
            team: 'NONE',
            salary: 0,
          );
          _hCurrentPlayers[key] = player;
        },
      );
    }
    _status = DataStatus.Loaded;
    notifyListeners();
  }

  Future<void> getPrevPlayersList() async {
    _lPrevSelectedPlayers = [];
    DocumentSnapshot prevMatchDS = await _db
        .collection('users')
        .document(_userEmail)
        .collection(_prevMatch)
        .document('team')
        .get();
    if (prevMatchDS != null && prevMatchDS.data != null) {
      _hPlayerIndexes.forEach(
        (key, val) {
          if (key != 'captain') {
            Player player = Player.fromFireStore(_players[prevMatchDS[key]]);
            _lPrevSelectedPlayers.add(player.id);
          }
        },
      );
    }
  }

  void setSelectablePlayers(String pType) {
    _selectedPlayerIndex = pType;
    _selectedPlayerType = _hPlayerIndexes[pType]['type'];
    updatePurse();

    if (_selectedPlayerType != 5) {
      _selectablePlayers = _db
          .collection('players')
          .where('type', isEqualTo: _selectedPlayerType)
          .snapshots();
    } else {
      _selectablePlayers = _db.collection('players').snapshots();
    }

    notifyListeners();
  }

  void filterPlayers(String team) {
    if (team == 'All') {
      if (_selectedPlayerType != 5) {
        _selectablePlayers = _db
            .collection('players')
            .where('type', isEqualTo: _selectedPlayerType)
            .snapshots();
      } else {
        _selectablePlayers = _db.collection('players').snapshots();
      }
    } else {
      if (_selectedPlayerType != 5) {
        _selectablePlayers = _db
            .collection('players')
            .where('type', isEqualTo: _selectedPlayerType)
            .where('teamname', isEqualTo: team)
            .snapshots();
      } else {
        _selectablePlayers = _db
            .collection('players')
            .where('teamname', isEqualTo: team)
            .snapshots();
      }
    }

    notifyListeners();
  }

  void selectPlayer(Player player) {
    _hCurrentPlayers[_selectedPlayerIndex] = player;
    updateCaptain();
    updatePurse();
    notifyListeners();
  }

  void updateCaptain() {
    if (hCurrentPlayers['captain'].id > 0) {
      int captainID = hCurrentPlayers['captain'].id;
      bool captainCheck = true;
      hCurrentPlayers.forEach(
        (key, player) {
          if (captainCheck && key != 'captain' && player.id == captainID) {
            captainCheck = false;
          }
        },
      );
      if (captainCheck) {
        hCurrentPlayers['captain'] = Player(
          id: 0,
          name: 'captain',
          key: 'captain',
          team: 'NONE',
          salary: 0,
        );
      }
    }
  }

  void updatePurse() {
    _purseUsed = 0;
    _purseLeft = 1000000;
    _hPlayerIndexes.keys.forEach(
      (key) {
        if (key != _selectedPlayerIndex && key != 'captain') {
          _purseUsed += _hCurrentPlayers[key].salary;
        }
      },
    );
    _purseLeft -= _purseUsed;
  }

  bool playerSelectable(Player player) {
    if (_selectedPlayerIndex == 'captain') {
      return true;
    }
    if (player.salary > _purseLeft) {
      return false;
    }
    int isSamePlayer = 0;
    _hCurrentPlayers.keys.forEach(
      (pType) {
        if (isSamePlayer == 0 && _hCurrentPlayers[pType].id == player.id) {
          isSamePlayer = 1;
        }
      },
    );
    if (isSamePlayer == 1) {
      return false;
    }

    return true;
  }

  List<String> checkTeamErrors() {
    List<String> lErrors = [];
    int playerError = 0;
    int overSeasCount = 0;
    int teamError = 0;
    Map hPlayersByTeam = {
      'MI': 0,
      'CSK': 0,
      'RCB': 0,
      'DD': 0,
      'RR': 0,
      'KXIP': 0,
      'SRH': 0,
      'KKR': 0
    };

    _hPlayerIndexes.keys.forEach(
      (pType) {
        if (_hCurrentPlayers[pType] != null && _hCurrentPlayers[pType].id > 0) {
          if (pType != 'captain') {
            if (_hCurrentPlayers[pType].overseas) {
              overSeasCount += 1;
            }
            hPlayersByTeam[_hCurrentPlayers[pType].team] += 1;
          }
        } else {
          playerError = 1;
        }
      },
    );

    hPlayersByTeam.forEach(
      (key, val) {
        if (val > 6) {
          teamError = 1;
        }
      },
    );

    if (teamError == 1) {
      lErrors.add('Not more than 6 players from the same team allowed.');
    }
    if (playerError == 1) {
      lErrors.add('All the 11 players and captain should be selected.');
    }
    if (overSeasCount > 4) {
      lErrors.add('Max 4 Oversears players allowed.');
    }

    getTransfersMade();
    if (_transfersMade > _userData['transfers_left']) {
      lErrors.add(
          'Only ${_userData['transfers_left']} transfers allowed but you made $_transfersMade.');
    }
    return lErrors;
  }

  void getTransfersMade() {
    _transfersMade = 0;
    List<int> lNewPlayers = [];
    List<int> lOldPlayers = [];
    List<int> lCurrentPlayers = [];
    _lTransfers = [];

    if (_lPrevSelectedPlayers.length > 0) {
      _hCurrentPlayers.forEach(
        (k, v) {
          if (k != 'captain') {
            lCurrentPlayers.add(v.id);
            if (!_lPrevSelectedPlayers.contains(v.id)) {
              ++_transfersMade;
              lNewPlayers.add(v.id);
            }
          }
        },
      );
      if (_transfersMade > 0) {
        _lPrevSelectedPlayers.forEach(
          (id) {
            if (!lCurrentPlayers.contains(id)) {
              lOldPlayers.add(id);
            }
          },
        );
        int len = lOldPlayers.length;
        for (int i = 0; i < len; i++) {
          Player player1 = Player.fromFireStore(_players[lOldPlayers[i]]);
          Player player2 = Player.fromFireStore(_players[lNewPlayers[i]]);
          _lTransfers.add(
            player1.displayName(false) + ' => ' + player2.displayName(false),
          );
        }
      }
      _lTransfers.add(_hCurrentPlayers['captain'].name + ' (Captain)');
    } else {
      _lTransfers.add(_hCurrentPlayers['captain'].name + ' (Captain)');
    }
  }

  Future<void> saveTeam() async {
    try {
      _status = DataStatus.Loading;
      notifyListeners();
      await _db
          .collection('users')
          .document(_userEmail)
          .collection(_currentMatch)
          .document('team')
          .setData(
        {
          'player1': _hCurrentPlayers['player1'].id,
          'player2': _hCurrentPlayers['player2'].id,
          'player3': _hCurrentPlayers['player3'].id,
          'player4': _hCurrentPlayers['player4'].id,
          'player5': _hCurrentPlayers['player5'].id,
          'player6': _hCurrentPlayers['player6'].id,
          'player7': _hCurrentPlayers['player7'].id,
          'player8': _hCurrentPlayers['player8'].id,
          'player9': _hCurrentPlayers['player9'].id,
          'player10': _hCurrentPlayers['player10'].id,
          'player11': _hCurrentPlayers['player11'].id,
          'captain': _hCurrentPlayers['captain'].id,
        },
      );
      if (_phaseStarted) {
        await _db
            .collection('users')
            .document(_userEmail)
            .setData({'pending_transfers': _transfersMade}, merge: true);
        _pendingTransfers = _transfersMade;
      }
      _status = DataStatus.Saved;
      notifyListeners();
    } catch (e) {
      _status = DataStatus.Failed;
      notifyListeners();
    }
  }

  void setCaptainPlayers() {
    _selectedPlayerIndex = 'captain';
    _lSelectedPlayers = [];
    _hCurrentPlayers.forEach((k, v) {
      if (k != 'captain' && v.id > 0) {
        _lSelectedPlayers.add(v);
      }
    });
    notifyListeners();
  }

  bool isNotAnExistingPlayer(player) {
    bool existingPlayer = true;
    _hCurrentPlayers.values.forEach(
      (ePlayer) {
        if (ePlayer.id == player.id) {
          existingPlayer = false;
        }
      },
    );
    return existingPlayer;
  }

  Future<void> resetData(update) async {
    try {
      _status = DataStatus.Loading;
      notifyListeners();
      DocumentSnapshot configDS = await _db
          .collection('configurations')
          .document('configurations')
          .get();
      if (_currentMatch != configDS['current_match']) {
        _configurations = configDS;
        _phaseStarted = configDS['phase_started'];
        _totalTransfers = configDS['phase_transfers'];
        _currentMatch = configDS['current_match'];
        _prevMatch = configDS['prev_match'];
        _selectedMatch = _currentMatch;
        getMatchesData();
        if (update) {
          getUserData();
        }
        _status = DataStatus.Loaded;
        notifyListeners();
      } else {
        if (_selectedMatch != _currentMatch) {
          _selectedMatch = _currentMatch;
        }
        if (update) {
          await getPlayersList(_currentMatch);
          if (_lPrevSelectedPlayers.length == 0 &&
              hCurrentPlayers['player1'].id > 0) {
            getPrevPlayersList();
          }
        }

        _status = DataStatus.Loaded;
        notifyListeners();
      }
    } catch (e) {
      _status = DataStatus.NotLoaded;
      notifyListeners();
    }
  }

  void setPointsStream() {
    _pointsStream = _db
        .collection('matches')
        .document(_selectedMatch)
        .collection('points')
        .document(_selectedTeam)
        .snapshots();
    notifyListeners();
  }

  Player getPlayer(playerID) {
    return Player.fromFireStore(_players[int.parse(playerID)]);
  }

  void updatePointsPage(match) {
    _selectedMatch = match;
    _matches.forEach(
      (m) {
        if (m['name'] == match) {
          _team1 = m['team1'];
          _team2 = m['team2'];
          _selectedTeam = _team1;
        }
      },
    );
    setPointsStream();
    notifyListeners();
  }

  void setRankingsStream(match) {
    if (match == 'Overall') {
      _rankingsStream =
          _db.collection('configurations').document('rankings').snapshots();
    } else {
      _rankingsStream = _db
          .collection('matches')
          .document(_selectedMatch)
          .collection('rankings')
          .document('rankings')
          .snapshots();
    }
    notifyListeners();
  }

  Future<String> getUserEmail(team) async {
    _status = DataStatus.Loading;
    notifyListeners();
    QuerySnapshot qs = await _db.collection('users').getDocuments();
    String email;
    qs.documents.forEach(
      (ds) {
        if (ds.data['team_name'] == team) {
          email = ds.documentID;
        }
      },
    );
    return email;
  }
}
