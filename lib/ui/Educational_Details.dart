import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_gorgeous_login/details/others.dart';
import 'package:the_gorgeous_login/details/ssc.dart';
import 'package:the_gorgeous_login/details/hsc.dart';
import 'package:the_gorgeous_login/details/ug.dart';
import 'package:the_gorgeous_login/style/theme.dart' as Theme;
import 'package:the_gorgeous_login/ui/Personal_details.dart';

import 'package:the_gorgeous_login/utils/bubble_indication_painter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:the_gorgeous_login/ui/Login_Page.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class EducationalDetails extends StatefulWidget {
  EducationalDetails({Key key}) : super(key: key);

  @override
  EducationState createState() => new EducationState();
}

class EducationState extends State<EducationalDetails>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';

    _pageController = PageController();
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50.0)),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        //painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(
                "Qualifications",
                style: TextStyle(
                    color: right,
                    fontSize: 16.0,
                    fontFamily: "WorkSansSemiBold"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(_myActivitiesResult),
          ),
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 350.0,
                  height: 550.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "SSC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Ssc()));
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "HSC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Hsc()));
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "Under Graduate",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UG()));
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "Post Graduate",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Ssc()));
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "Others",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Other()));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
