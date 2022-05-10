import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:recruitmentclient/common/common_widgets.dart';
import 'package:recruitmentclient/common/validators.dart';
import 'package:recruitmentclient/viewmodel/signup_viewmodel.dart';

import '../main.dart';
import 'home.dart';

//view class for the page to create a User

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String roleInitialValue = "Please Select";
  bool _firstItemSelected = false;
  String? dropDownRoleValue;

  late SignUpViewModel _thisSignUpViewModel;

  bool _loading = false;

  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    _thisSignUpViewModel = Provider.of<SignUpViewModel>(context, listen: true);
    return Scaffold(body: SingleChildScrollView(child: webBody(context)));
  }

  Widget webBody(BuildContext context) {
    _thisSignUpViewModel = Provider.of<SignUpViewModel>(context, listen: true);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context, constraints) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
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
                                    fontSize:
                                        MediaQuery.textScaleFactorOf(context) *
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
                                borderSide:
                                    BorderSide(color: MyApp.fieldSelectYellow),
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
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {
                              setState(() {
                                _firstName = val;
                              });
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
                                labelText: "Last Name",
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
                              validator: (String? value) =>
                                  Validators.validateField(value),
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
                              validator: (String? value) =>
                                  Validators.validateEmail(value),
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
                          child: Text("Role",
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
                            child: Container(
                              //width: screenWidth*0.5,
                              // height: screenHeight*0.05,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: MyApp.customYellow,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.02,
                                  left: screenWidth * 0.01),
                              child: ButtonTheme(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    key: Key("roleDropDownSelector"),
                                    validator: (value) =>
                                        Validators.validateDropDown(value),
                                    isExpanded: true,
                                    value: roleInitialValue,
                                    dropdownColor: MyApp.customGrey,
                                    icon: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                    ),
                                    iconSize: screenHeight * 0.03,
                                    elevation: 16,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: _firstItemSelected
                                                ? MyApp.customYellow
                                                : Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12)),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        roleInitialValue = newValue!;
                                        _firstItemSelected = true;
                                        dropDownRoleValue = newValue;
                                      });
                                    },
                                    items: <String>[
                                      "Please Select",
                                      "JobSeeker",
                                      "Recruiter"
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
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
                                labelText: "Confirm Password",
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
                              validator: (String? value) =>
                                  Validators.validateField(value),
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
                  _thisSignUpViewModel.loading
                      ? Container(
                          padding: EdgeInsets.only(top: screenHeight * 0.05),
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
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
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
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    15))),
                                    style: ElevatedButton.styleFrom(
                                      primary: MyApp.customYellow,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_password != _confirmPassword)
                                          showToast(
                                              "Error. Passwords Don't Match");
                                        else {
                                          String chosenRole =
                                              dropDownRoleValue == "JobSeeker"
                                                  ? "JOBSEEKER"
                                                  : "RECRUITER";

                                          await _thisSignUpViewModel.signUp(
                                              _firstName,
                                              _lastName,
                                              _email,
                                              _password,
                                              chosenRole);
                                          if (_thisSignUpViewModel
                                              .signUpSuccess) {
                                            showToast("Success! User Created");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Home(
                                                          userType: "RECRUITER",
                                                        )));
                                          } else
                                            showToast(
                                                "Error. Something went wrong");
                                        }
                                      }
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
      );
    });
  }
}
