import 'package:fantasy_app/components/dialogs.dart';
import 'package:fantasy_app/providers/data.dart';
import 'package:fantasy_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fantasy_app/components/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    final data = Provider.of<DataRepository>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, 'loginscreen');
        return Future.value(false);
      },
      child: WrapperWidget(
        pageWidget: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyTextFormField(
                  hintText: 'Enter your email',
                  onPressed: (input) => _email = input,
                  onValidate: (value) =>
                      value.isEmpty ? 'Email can not be empty' : null,
                  iconData: Icons.email,
                ),
                SizedBox(
                  height: 5.0,
                ),
                MyTextFormField(
                  hintText: 'Enter your password',
                  onPressed: (input) => _password = input,
                  onValidate: (value) =>
                      value.isEmpty ? 'Password can not be empty' : null,
                  iconData: FontAwesomeIcons.key,
                  obscure: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    user.status == UserStatus.Authenticating ||
                            user.status == UserStatus.Authenticated
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: Color(0XFFB0E0E6),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await user.signIn(_email, _password).then(
                                    (userSignedIn) {
                                      if (userSignedIn) {
                                        Navigator.pushNamed(
                                            context, 'homescreen');
                                        data.userEmail = user.user.email;
                                        data.getData();
                                      } else {
                                        showAlert(
                                          context,
                                          'Error',
                                          user.errorMessage,
                                          Colors.red,
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                              child: Text(
                                'LogIn',
                                style: GoogleFonts.robotoSlab(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        color: Colors.amber[300],
                        onPressed: () {
                          Navigator.pushNamed(context, 'registerscreen');
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'forgotscreen');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white70,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
