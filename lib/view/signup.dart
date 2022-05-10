import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:recruitmentclient/common/common_widgets.dart';
import 'package:recruitmentclient/common/validators.dart';
import 'package:recruitmentclient/viewmodel/signup_viewmodel.dart';

import '../main.dart';
import 'login.dart';


//view class for the sign up page

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SignUpViewModel _thisSignUpViewModel;

  @override
  Widget build(BuildContext context) {
     _thisSignUpViewModel = Provider.of<SignUpViewModel>(context, listen: true);
    return Scaffold(body: SingleChildScrollView(child: webBody(context)));
  }

  Widget webBody(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    bool _loading = false;

    String _firstName = "";
    String _lastName = "";
    String _email = "";
    String _password = "";
    String _confirmPassword = "";

    return Row(children: [
      screenWidth > 600
          ? Expanded(
              flex: 4,
              child: Container(
                height: screenHeight,
                color: MyApp.customYellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: screenWidth * 0.01,
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05,
                      ),
                      child: Text("Let's Get You Set Up",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: MyApp.customGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          35))),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            bottom: screenHeight * 0.1,
                            left: screenWidth * 0.05,
                            right: screenWidth * 0.05,
                            top: screenWidth * 0.03),
                        child: Text(
                          "Please Enter Your Details To Create An Account",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: MyApp.customGrey,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          25)),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ))
          : Container(),
      Expanded(
          flex: 8,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                screenWidth < 600
                    ? Container(
                        color: MyApp.customYellow,
                        height: screenHeight * 0.2,
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
                              child: Text("Let's Get you Set Up",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: MyApp.customGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  30))),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.05,
                                    right: screenWidth * 0.05),
                                child: Text(
                                  "Please Enter Your Details To Create An Account",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: MyApp.customGrey,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  20)),
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.05),
                      ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      top: screenHeight * 0.05),
                  color: MyApp.customGrey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text("First Name",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15))),
                          ),
                          Expanded(
                            flex: 9,
                            child: Container(
                              child: TextFormField(
                                style: TextStyle(color: MyApp.customYellow),
                                decoration: InputDecoration(
                                  labelText: "First Name",
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
                                    borderSide:
                                        BorderSide(color: Colors.red),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: MyApp.customYellow),
                                  ),
                                ),
                               validator: (String? value) => Validators.validateField(value),
                                onChanged: (val) {
                                  _firstName = val;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("Last Name",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15))),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(color: MyApp.customYellow),
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
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
                                      borderSide:
                                          BorderSide(color: Colors.red),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: MyApp.customYellow),
                                    ),
                                  ),
                                validator: (String? value) => Validators.validateField(value),
                                  onChanged: (val) {
                                    _lastName = val;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("Email",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15))),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(
                                child: TextFormField(
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
                                      borderSide:
                                          BorderSide(color: Colors.red),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: MyApp.customYellow),
                                    ),
                                  ),
                                  validator: (String? value) => Validators.validateEmail(value),
                                                                  onChanged: (val) {
                                  _email = val;
                                },
                                  
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("Password",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15))),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(color: MyApp.customYellow),
                                  decoration: InputDecoration(
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
                                      borderSide:
                                          BorderSide(color: Colors.red),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: MyApp.customYellow),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field Cannot be Blank';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  onChanged: (val) {
                                    _password = val;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("Confirm Password",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15))),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(color: MyApp.customYellow),
                                  decoration: InputDecoration(
                                    labelText: "Confirm Password",
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
                                      borderSide:
                                          BorderSide(color: Colors.red),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: MyApp.customYellow),
                                    ),
                                  ),
                                  validator: (String? value) => Validators.validateField(value),
                                  obscureText: true,
                                  onChanged: (val) {
                                    _confirmPassword = val;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                                _thisSignUpViewModel.loading ?

       
                         Container(
                           padding: EdgeInsets.only(top: screenHeight*0.05),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    "Creating User",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )
                          :
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: (screenWidth < 600)
                                  ? screenWidth * 0.25
                                  : screenWidth * 0.2,
                              height: screenHeight * 0.08,
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.02),
                              child: ElevatedButton(
                                  child: Text("Create",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: MyApp.customGrey,
                                              fontSize:
                                                  MediaQuery.textScaleFactorOf(
                                                          context) *
                                                      15))),
                                  style: ElevatedButton.styleFrom(
                                    primary: MyApp.customYellow,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: ()  async {
                                    if (_formKey.currentState!.validate()) {
                                      if (_password != _confirmPassword)
                                        showToast(
                                            "Error. Passwords Don't Match");
                                      else {
                                        print("email");
                                        print(_email);
                                       await   _thisSignUpViewModel.signUp(_firstName, _lastName, _email, _password, "JOBSEEKER");
                                        if(_thisSignUpViewModel.signUpSuccess) 
                                        {showToast("Success! User Created");
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                        }
                                        else showToast("Error. Something went wrong");
                                        
                                        
                                      }
                                    }
                                  }),
                            ),
                            Container(
                              width: screenWidth * 0.23,
                              height: screenHeight * 0.08,
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  left: screenWidth * 0.03),
                              child: ElevatedButton(
                                  child: Text("Back",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: MyApp.customGrey,
                                              fontSize:
                                                  MediaQuery.textScaleFactorOf(
                                                          context) *
                                                      15))),
                                  style: ElevatedButton.styleFrom(
                                    primary: MyApp.customYellow,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))
    ]);
  }
}
