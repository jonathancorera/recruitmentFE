/*
Displays the home page for all users
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:recruitmentclient/common/common_widgets.dart';
import 'package:recruitmentclient/common/validators.dart';
import 'package:recruitmentclient/main.dart';
import 'package:recruitmentclient/view/home.dart';
import 'package:recruitmentclient/view/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_response.dart';
import '../viewmodel/login_viewmodel.dart';

//view class for the login page

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = "";
  String _password = "";
  bool _loading = false;
  bool _obscureText = true;

  late LoginViewModel _thisLoginViewModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _thisLoginViewModel = Provider.of<LoginViewModel>(context, listen: true);

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 768 || constraints.maxHeight < 500)
          return mobileBody(context, _formKey);
        else
          return webBody(context, _formKey);
      }),
    );
  }

  Widget mobileBody(BuildContext context, GlobalKey<FormState> formKey) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenWidth,
              color: MyApp.customYellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        bottom: screenWidth * 0.01,
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05,
                        top: screenWidth * 0.02),
                    child: Text("Recruitment Application",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: MyApp.customGrey,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) *
                                        30))),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.05),
                      child: Text(
                        "V1.0",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: MyApp.customGrey,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) *
                                        30)),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
            Container(
              height: screenHeight * 0.7,
              width: screenWidth,
              color: MyApp.customGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.05, bottom: screenHeight * 0.02),
                    child: Text("Sign In",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) *
                                        30))),
                    alignment: Alignment.center,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.02,
                    ),
                    child: Text("Please Sign in With your Email and Password",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) *
                                        15))),
                    alignment: Alignment.center,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.15,
                            padding: EdgeInsets.only(top: 20),
                            child: ListTile(
                              title: TextFormField(
                                key: Key("loginEmail"),
                                validator: (String? value) =>
                                    Validators.validateEmail(value),
                                style: TextStyle(color: MyApp.customYellow),
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  alignLabelWithHint: true,
                                  labelStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15)),
                                  fillColor: Colors.white,
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15)),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: MyApp.fieldSelectYellow),
                                  ),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: MyApp.customYellow),
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: MyApp.customYellow),
                                  ),
                                ),
                                onChanged: (val) {
                                  this._username = val;
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.15,
                            padding: EdgeInsets.only(top: 10),
                            child: ListTile(
                              title: TextFormField(
                                key: Key("loginPassword"),
                                validator: (String? value) =>
                                    Validators.validateField(value),
                                style: TextStyle(color: MyApp.customYellow),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: screenHeight * 0.03),
                                    color: MyApp.customYellow,
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  labelText: "Password",
                                  alignLabelWithHint: true,
                                  labelStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15)),
                                  fillColor: Colors.white,
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15)),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: MyApp.fieldSelectYellow),
                                  ),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: MyApp.customYellow),
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: MyApp.customYellow),
                                  ),
                                ),
                                obscureText: _obscureText,
                                onChanged: (val) {
                                  this._password = val;
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: _thisLoginViewModel.loading
                                ? Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            child: LoadingRotating.square(
                                          borderColor: MyApp.customYellow,
                                          size: 20,
                                        )),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Logging you in",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.4,
                                        height: screenHeight * 0.08,
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.02),
                                        child: ElevatedButton(
                                            child: Text("Login",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color: MyApp.customGrey,
                                                        fontSize: MediaQuery
                                                                .textScaleFactorOf(
                                                                    context) *
                                                            15))),
                                            style: ElevatedButton.styleFrom(
                                              primary: MyApp.customYellow,
                                              onPrimary: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                print("valid");

                                                setState(() {
                                                  print(this._username);
                                                  print(this._password);
                                                });

                                                await _thisLoginViewModel.login(
                                                    _username, _password);

                                                print(_thisLoginViewModel
                                                    .loginCredError);
                                                if (_thisLoginViewModel
                                                    .loginSuccess) {
                                                  print(_thisLoginViewModel
                                                      .loginResponse?.jwttoken);
                                                  savePrefs(_thisLoginViewModel
                                                      .loginResponse!);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Home(
                                                              userType:
                                                                  _thisLoginViewModel
                                                                      .loginResponse!
                                                                      .roles![0]
                                                                      .name!)));
                                                } else if (_thisLoginViewModel
                                                    .loginCredError)
                                                  showToast(
                                                      "Error: Invalid Username or Password");
                                                else
                                                  showToast(
                                                      "Error: Something went wrong");
                                              } else {
                                                print("invalid");
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("New User?"),
                                    (TextButton(
                                      style: TextButton.styleFrom(
                                          primary: MyApp.customYellow,
                                          textStyle: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      10))),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
                                      },
                                      child: Text('Sign Up',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.yellow[400],
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15))),
                                    )),
                                  ]))
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget webBody(BuildContext context, GlobalKey<FormState> formKey) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(children: [
      Expanded(
          flex: 4,
          child: Container(
            color: MyApp.customYellow,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: screenWidth * 0.01,
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      top: screenWidth * 0.1),
                  child: Text("Recruitment Application",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 50))),
                ),
                Container(
                    padding: EdgeInsets.only(
                        bottom: screenHeight * 0.1,
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05),
                    child: Text(
                      "V1.0",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 30)),
                      textAlign: TextAlign.center,
                    )),

/*
                              Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: MyApp.customYellow,
                image: DecorationImage(
                  image: Image.asset('/images/login.png').image,
                ),
              )
            )
                              ),
                              */
              ],
            ),
          )),
      Expanded(
          flex: 8,
          child: Container(
            color: MyApp.customGrey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 120,
                  ),
                  child: Text("Sign In",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 30))),
                  alignment: Alignment.center,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 60,
                    bottom: 20,
                  ),
                  child: Text("Please Sign in With your Email and Password",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 20))),
                  alignment: Alignment.center,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.13,
                          padding: EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              key: Key("loginEmail"),
                              validator: (String? value) =>
                                  Validators.validateEmail(value),
                              style: TextStyle(color: MyApp.customYellow),
                              decoration: InputDecoration(
                                labelText: "Email",
                                alignLabelWithHint: true,
                                labelStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15)),
                                fillColor: Colors.white,
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15)),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: MyApp.fieldSelectYellow),
                                ),
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                                errorBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                              ),
                              onChanged: (val) {
                                this._username = val;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          padding: EdgeInsets.only(top: 30),
                          child: ListTile(
                            title: TextFormField(
                              key: Key("loginPassword"),
                              validator: (String? value) =>
                                  Validators.validateField(value),
                              style: TextStyle(color: MyApp.customYellow),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: screenHeight * 0.03),
                                  color: MyApp.customYellow,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                labelText: "Password",
                                alignLabelWithHint: true,
                                labelStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15)),
                                fillColor: Colors.white,
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15)),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: MyApp.fieldSelectYellow),
                                ),
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                                errorBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                              ),
                              obscureText: _obscureText,
                              onChanged: (val) {
                                this._password = val;
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: _thisLoginViewModel.loading
                              ? Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          child: LoadingRotating.square(
                                        borderColor: MyApp.customYellow,
                                        size: 20,
                                      )),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Logging you in",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.05,
                                  child: ElevatedButton(
                                      child: Text("Login",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: MyApp.customGrey,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15))),
                                      style: ElevatedButton.styleFrom(
                                        primary: MyApp.customYellow,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () async {
                                        /*                         
    Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Home(userType: "RECRUITER")
                                                                     // Home(userType: "JOBSEEKER",)
                                                                      ));
                                                                      
          */
                                        if (formKey.currentState!.validate()) {
                                          print("valid");

                                          setState(() {
                                            print(this._username);
                                            print(this._password);
                                          });

                                          await _thisLoginViewModel.login(
                                              _username, _password);

                                          print(_thisLoginViewModel
                                              .loginCredError);
                                          if (_thisLoginViewModel
                                              .loginSuccess) {
                                            print(_thisLoginViewModel
                                                .loginResponse?.jwttoken);
                                            savePrefs(_thisLoginViewModel
                                                .loginResponse!);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Home(
                                                        userType:
                                                            _thisLoginViewModel
                                                                .loginResponse!
                                                                .roles![0]
                                                                .name!)));
                                          } else if (_thisLoginViewModel
                                              .loginCredError)
                                            showToast(
                                                "Error: Invalid Username or Password");
                                          else
                                            showToast(
                                                "Error: Something went wrong");
                                        } else {
                                          print("invalid");
                                        }
                                      }),
                                ),
                        ),
                      ],
                    )),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New User?"),
                          (TextButton(
                            style: TextButton.styleFrom(
                                primary: MyApp.customYellow,
                                textStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            10))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text('Sign Up',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.yellow[400],
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15))),
                          )),
                        ]))
              ],
            ),
          ))
    ]);
  }

  savePrefs(LoginResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", loginResponseToJson(response));
  }
}
