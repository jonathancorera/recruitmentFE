import 'package:flutter/material.dart';
import 'package:recruitmentclient/common/common_widgets.dart';
import 'package:recruitmentclient/view/create_CV.dart';
import 'package:recruitmentclient/view/employee_main.dart';
import 'package:recruitmentclient/view/home.dart';
import 'package:recruitmentclient/view/login.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:recruitmentclient/viewmodel/cv_viewmodel.dart';
import 'package:recruitmentclient/viewmodel/login_viewmodel.dart';
import 'package:recruitmentclient/viewmodel/signup_viewmodel.dart';
import 'package:recruitmentclient/viewmodel/user_viewModel.dart';

void main() {
  runApp(MyApp());
}

//text theme data for the appearance of text across the app
final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 97,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.black),
  headline2: GoogleFonts.poppins(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.white),
  headline3: GoogleFonts.poppins(
      fontSize: 48, fontWeight: FontWeight.w400, color: Colors.black),
  headline4: GoogleFonts.poppins(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black),
  headline5: GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
  headline6: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.white),
  subtitle1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.white),
  subtitle2: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.white),
  bodyText1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyText2: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  button: GoogleFonts.poppins(
      fontSize: 16, letterSpacing: 0.3, color: Colors.black),
  caption: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Colors.white),
  overline: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static Color prussianBlue = HexColor("#013C58");
  static Color customYellow = HexColor("#FFE01B");
  static Color customGrey = Colors.grey[900]!;
  static Color fieldSelectYellow = HexColor("F5A201");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),
      ],
      child: MaterialApp(
        title: 'Recruitment Client',
        theme: new ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey[900],
            backgroundColor: Colors.green,
            primarySwatch: Colors.grey,
            textTheme: textTheme),
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
