import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:recruitmentclient/common/validators.dart';
import 'package:recruitmentclient/main.dart';
import 'package:recruitmentclient/model/cv.dart';
import 'package:recruitmentclient/model/login_response.dart';
import 'package:recruitmentclient/view/view_CV.dart';
import 'package:recruitmentclient/viewmodel/cv_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/get_user_list_response.dart';
import '../viewmodel/user_viewModel.dart';
import 'home.dart';

//view class for the employee main page

class EmployeeMain extends StatefulWidget {
  const EmployeeMain({Key? key}) : super(key: key);

  @override
  State<EmployeeMain> createState() => _EmployeeMainState();
}

class _EmployeeMainState extends State<EmployeeMain> {
  String _filterInitialValue = "Please Select";
  String? _filterSelectedValue;
  bool _filterFirstItemSelected = false;

  String _jobSectorInitialValue = "Please Select";
  String? _jobSectorSelectedValue;
  bool _jobSectorFirstItemSelected = false;

  String _minEduInitialValue = "Please Select";
  String? _minEduSelectedValue;
  bool _minEduFirstItemSelected = false;

  String? _noGCEPassesSelected;
  String? _professionalQualSelected;
  String? _educationallQualSelected;
  String? _skillSelected;
  String? _experienceSelected;

  bool _isFilterSelected = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserViewModel _thisUserViewModel;
  late CVViewModel _thisCvViewModel;

  List<Experience>? expList1;
  List<Experience>? expList2;
  bool _loading = false;

  int currentPage = 0;

  @override
  void initState() {
    print("initialized");
    super.initState();
    //WidgetsBinding.instance
    //    .addPostFrameCallback((_) =>  getUserInfo());

    //WidgetsBinding.instance
    // .addPostFrameCallback((_) =>  clearUSerInfo());
  }

  clearUSerInfo() async {
    _thisUserViewModel.clearUsers();
  }

  getUserInfo() async {
    LoginResponse? userInfo;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = loginResponseFromJson(prefs.getString("user")!);

    await _thisUserViewModel.getUserList(0);
  }

  showAlertDialogDelete(BuildContext context, int userId) {
    print("function called");
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: MyApp.customYellow,
                  letterSpacing: .5,
                  fontSize: MediaQuery.of(context).size.height * 0.02))),
      onPressed: () {
        //Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      userType: "RECRUITER",
                    )));
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: MyApp.customYellow,
                  letterSpacing: .5,
                  fontSize: MediaQuery.of(context).size.height * 0.02))),
      onPressed: () {
        _thisCvViewModel.deleteCV(userId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      userType: "RECRUITER",
                    )));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        side: BorderSide(width: 3.0, color: MyApp.customYellow),
      ),
      backgroundColor: Colors.grey[900],
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          Text("  Confirm Selection",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: MediaQuery.of(context).size.height * 0.025))),
        ],
      ),
      content: Text(
          "Are you sure you want to delete this CV? This operation is permanent.",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: .5,
                  fontSize: MediaQuery.of(context).size.height * 0.018))),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        }).then((_) {
      Navigator.pop(context);
    });
  }

  showAlertDialogDeleteUser(BuildContext context, int userId) {
    bool _dialogLoading = false;

    print("function called");
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: MyApp.customYellow,
                  letterSpacing: .5,
                  fontSize: MediaQuery.of(context).size.height * 0.02))),
      onPressed: () {
        //Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      userType: "RECRUITER",
                    )));
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: MyApp.customYellow,
                  letterSpacing: .5,
                  fontSize: MediaQuery.of(context).size.height * 0.02))),
      onPressed: () {
        _thisUserViewModel.deleteUser(userId);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      userType: "RECRUITER",
                    )));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        side: BorderSide(width: 3.0, color: MyApp.customYellow),
      ),
      backgroundColor: Colors.grey[900],
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          Text("  Confirm Selection",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: MediaQuery.of(context).size.height * 0.025))),
        ],
      ),
      content: Container(
        child: Text(
            "Are you sure you want to delete this user? This operation is permanent.",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: MediaQuery.of(context).size.height * 0.018))),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        }).then((_) {
      Navigator.pop(context);
    });
  }

  TextEditingController _searchQueryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _thisUserViewModel = Provider.of<UserViewModel>(context, listen: true);
    _thisCvViewModel = Provider.of<CVViewModel>(context, listen: true);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: MyApp.customGrey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*
            Center(
              child: Container(
                width: screenWidth*0.5,
                alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      top: screenHeight*0.03,
                        bottom: screenHeight * 0.01),
                    child: TextField(
                      controller: _searchQueryController,
                      decoration: InputDecoration(
                        
                        contentPadding: EdgeInsets.only(left: screenWidth * 0.03),
                        hintText: "Search CVs",
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: screenHeight * 0.02,
                        )),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.clear_sharp,
                              color: MyApp.customYellow,
                            ),
                            padding: EdgeInsets.only(right: 5),
                            tooltip: 'Clear Search',
                            onPressed: () async {
                              print("button pressed");
                              FocusManager.instance.primaryFocus?.unfocus();  
                              _searchQueryController.text = "";    
                             
                            }),
                        filled: true,
                        fillColor: MyApp.customGrey,
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
                                                      BorderSide(color: MyApp.customYellow),
                                                ),
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(8.0),
                                                  borderSide:
                                                      BorderSide(color: MyApp.customYellow),
                                                ),
                      ),
                      style: TextStyle(
                        color: MyApp.customYellow,
                        letterSpacing: 0.5,
                        fontSize: screenHeight * 0.02,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (val) {
                        print(val);
                      },
                    ),
                  ),
            ),
            */
              Container(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: MyApp.customYellow,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: ExpansionTile(
                  title: Text(
                    "Filters",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: MyApp.customYellow,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 20),
                    ),
                    key: Key("filterExpansionTile"),
                  ),
                  iconColor: MyApp.fieldSelectYellow,
                  collapsedIconColor: MyApp.customYellow,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: screenWidth * 0.03),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text("Filter By:",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: MyApp.customYellow,
                                        fontWeight: FontWeight.w400,
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            15),
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: Container(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.02),
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
                                      validator: (value) =>
                                          Validators.validateDropDown(value),
                                      isExpanded: true,
                                      value: _filterInitialValue,
                                      dropdownColor: MyApp.customGrey,
                                      icon: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
                                      ),
                                      iconSize: screenHeight * 0.03,
                                      elevation: 16,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: _filterFirstItemSelected
                                                  ? MyApp.customYellow
                                                  : Colors.white,
                                              fontSize: constraints.maxWidth >
                                                      600
                                                  ? MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15
                                                  : MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      12)),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _filterFirstItemSelected = true;
                                          _filterSelectedValue = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "Please Select",
                                        "Job Sector",
                                        "Min No. Of GCE Passes",
                                        "Min Education Level",
                                        "Educational Qualification",
                                        "Professional Qualification",
                                        "Skill",
                                        "Experience"
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
                      height: screenHeight * 0.02,
                    ),
                    _filterSelectedValue == "Job Sector"
                        ? Container(
                            padding: EdgeInsets.only(
                                right: screenWidth * 0.02,
                                bottom: screenHeight * 0.02),
                            width: screenWidth * 0.75,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          width: screenWidth * 0.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                validator: (value) =>
                                                    Validators.validateDropDown(
                                                        value),
                                                isExpanded: true,
                                                value: _jobSectorInitialValue,
                                                dropdownColor: MyApp.customGrey,
                                                icon: Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.white,
                                                ),
                                                iconSize: screenHeight * 0.03,
                                                elevation: 16,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            _jobSectorFirstItemSelected
                                                                ? MyApp
                                                                    .customYellow
                                                                : Colors.white,
                                                        fontSize: constraints
                                                                    .maxWidth >
                                                                600
                                                            ? MediaQuery
                                                                    .textScaleFactorOf(
                                                                        context) *
                                                                15
                                                            : MediaQuery
                                                                    .textScaleFactorOf(
                                                                        context) *
                                                                12)),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    _jobSectorFirstItemSelected =
                                                        true;
                                                    _jobSectorSelectedValue =
                                                        newValue;
                                                  });
                                                },
                                                items: <String>[
                                                  "Please Select",
                                                  "Business",
                                                  "Marketing",
                                                  "Nursing",
                                                  "Sales",
                                                  "Engineering",
                                                  "IT"
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Row(children: [
                                            Container(
                                              height: screenHeight * 0.05,
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.01,
                                                  right: screenWidth * 0.01),
                                              child: ElevatedButton(
                                                  child: Text("Filter",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: MyApp
                                                                  .customGrey,
                                                              fontSize: constraints
                                                                          .maxWidth >
                                                                      600
                                                                  ? MediaQuery.textScaleFactorOf(
                                                                          context) *
                                                                      15
                                                                  : MediaQuery.textScaleFactorOf(
                                                                          context) *
                                                                      10))),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: MyApp.customYellow,
                                                    onPrimary: Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      print(
                                                          _jobSectorSelectedValue);
                                                      _isFilterSelected = true;
                                                      setState(() {});
                                                      _thisUserViewModel
                                                          .filterUserByJobSector(
                                                              _jobSectorSelectedValue!);
                                                    }
                                                  }),
                                            ),
                                            Container(
                                              height: screenHeight * 0.05,
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.only(
                                                left: screenWidth * 0.03,
                                              ),
                                              child: ElevatedButton(
                                                  child: Text("Clear",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: MyApp
                                                                  .customGrey,
                                                              fontSize: constraints
                                                                          .maxWidth >
                                                                      600
                                                                  ? MediaQuery.textScaleFactorOf(
                                                                          context) *
                                                                      15
                                                                  : MediaQuery.textScaleFactorOf(
                                                                          context) *
                                                                      10))),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: MyApp.customYellow,
                                                    onPrimary: Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    currentPage = 0;
                                                    await _thisUserViewModel
                                                        .getUserList(0);
                                                    _isFilterSelected = false;
                                                    setState(() {});
                                                  }),
                                            ),
                                          ])),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : _filterSelectedValue == "Min No. Of GCE Passes"
                            ? Container(
                                padding: EdgeInsets.only(
                                    right: screenWidth * 0.02,
                                    bottom: screenHeight * 0.02),
                                width: screenWidth * 0.75,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              //height: screenHeight*0.05,
                                              padding: EdgeInsets.only(
                                                  right: screenWidth * 0.02),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: TextStyle(
                                                    color: MyApp.customYellow,
                                                    fontSize: constraints
                                                                .maxWidth >
                                                            600
                                                        ? MediaQuery
                                                                .textScaleFactorOf(
                                                                    context) *
                                                            15
                                                        : MediaQuery
                                                                .textScaleFactorOf(
                                                                    context) *
                                                            12),
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "No. of GCE Passes",
                                                  alignLabelWithHint: true,
                                                  labelStyle: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: constraints
                                                                      .maxWidth >
                                                                  600
                                                              ? MediaQuery.textScaleFactorOf(
                                                                      context) *
                                                                  15
                                                              : MediaQuery.textScaleFactorOf(
                                                                      context) *
                                                                  12)),
                                                  fillColor: Colors.white,
                                                  hintStyle: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: constraints
                                                                      .maxWidth >
                                                                  600
                                                              ? MediaQuery.textScaleFactorOf(
                                                                      context) *
                                                                  15
                                                              : MediaQuery.textScaleFactorOf(
                                                                      context) *
                                                                  12)),
                                                  focusedBorder:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                    borderSide: BorderSide(
                                                        color: MyApp
                                                            .fieldSelectYellow),
                                                  ),
                                                  enabledBorder:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            MyApp.customYellow),
                                                  ),
                                                  errorBorder:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            MyApp.customYellow),
                                                  ),
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            MyApp.customYellow),
                                                  ),
                                                ),
                                                validator: (String? value) =>
                                                    Validators.validateField(
                                                        value),
                                                onChanged: (val) {
                                                  _noGCEPassesSelected = val;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Row(children: [
                                                Container(
                                                  height: screenHeight * 0.05,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding: EdgeInsets.only(
                                                      left: screenWidth * 0.01,
                                                      right:
                                                          screenWidth * 0.01),
                                                  child: ElevatedButton(
                                                      child: Text("Filter",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: MyApp
                                                                      .customGrey,
                                                                  fontSize: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          15
                                                                      : MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          10))),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            MyApp.customYellow,
                                                        onPrimary: Colors.black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          print(
                                                              _noGCEPassesSelected);
                                                          _isFilterSelected =
                                                              true;
                                                          setState(() {});
                                                          _thisUserViewModel
                                                              .filterUsersByMinGCSEPasses(
                                                                  int.parse(
                                                                      _noGCEPassesSelected!));
                                                        }
                                                      }),
                                                ),
                                                Container(
                                                  height: screenHeight * 0.05,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding: EdgeInsets.only(
                                                    left: screenWidth * 0.03,
                                                  ),
                                                  child: ElevatedButton(
                                                      child: Text("Clear",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: MyApp
                                                                      .customGrey,
                                                                  fontSize: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          15
                                                                      : MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          10))),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            MyApp.customYellow,
                                                        onPrimary: Colors.black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        currentPage = 0;
                                                        await _thisUserViewModel
                                                            .getUserList(0);
                                                        _isFilterSelected =
                                                            false;
                                                        setState(() {});
                                                      }),
                                                ),
                                              ])),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : _filterSelectedValue == "Min Education Level"
                                ? Container(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02,
                                        bottom: screenHeight * 0.02),
                                    width: screenWidth * 0.75,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Container(
                                                  width: screenWidth * 0.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                        color:
                                                            MyApp.customYellow,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 0.80),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      right: screenWidth * 0.02,
                                                      left: screenWidth * 0.01),
                                                  child: ButtonTheme(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        validator: (value) =>
                                                            Validators
                                                                .validateDropDown(
                                                                    value),
                                                        isExpanded: true,
                                                        value:
                                                            _minEduInitialValue,
                                                        dropdownColor:
                                                            MyApp.customGrey,
                                                        icon: Icon(
                                                          Icons.arrow_downward,
                                                          color: Colors.white,
                                                        ),
                                                        iconSize:
                                                            screenHeight * 0.03,
                                                        elevation: 16,
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                color: _minEduFirstItemSelected
                                                                    ? MyApp
                                                                        .customYellow
                                                                    : Colors
                                                                        .white,
                                                                fontSize: constraints
                                                                            .maxWidth >
                                                                        600
                                                                    ? MediaQuery.textScaleFactorOf(
                                                                            context) *
                                                                        15
                                                                    : MediaQuery.textScaleFactorOf(
                                                                            context) *
                                                                        12)),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            _minEduFirstItemSelected =
                                                                true;
                                                            _minEduSelectedValue =
                                                                newValue;
                                                          });
                                                        },
                                                        items: <String>[
                                                          "Please Select",
                                                          "Level 1",
                                                          "Level 2",
                                                          "Level 3",
                                                          "Level 4",
                                                          "Level 5",
                                                          "Level 6",
                                                          "Level 7",
                                                          "Level 8"
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 5,
                                                  child: Row(children: [
                                                    Container(
                                                      height:
                                                          screenHeight * 0.05,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          left: screenWidth *
                                                              0.01,
                                                          right: screenWidth *
                                                              0.01),
                                                      child: ElevatedButton(
                                                          child: Text("Filter",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      color:
                                                                          MyApp
                                                                              .customGrey,
                                                                      fontSize: constraints.maxWidth >
                                                                              600
                                                                          ? MediaQuery.textScaleFactorOf(context) *
                                                                              15
                                                                          : MediaQuery.textScaleFactorOf(context) *
                                                                              10))),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: MyApp
                                                                .customYellow,
                                                            onPrimary:
                                                                Colors.black,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              print(
                                                                  _minEduFirstItemSelected);
                                                              _isFilterSelected =
                                                                  true;
                                                              setState(() {});
                                                              int selectedQualValue =
                                                                  0;
                                                              if (_minEduFirstItemSelected ==
                                                                  "Level 1")
                                                                selectedQualValue =
                                                                    1;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 2")
                                                                selectedQualValue =
                                                                    2;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 3")
                                                                selectedQualValue =
                                                                    3;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 4")
                                                                selectedQualValue =
                                                                    4;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 5")
                                                                selectedQualValue =
                                                                    5;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 6")
                                                                selectedQualValue =
                                                                    6;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 7")
                                                                selectedQualValue =
                                                                    7;
                                                              else if (_minEduFirstItemSelected ==
                                                                  "Level 8")
                                                                selectedQualValue =
                                                                    8;

                                                              _thisUserViewModel
                                                                  .filterUsersByMinQualLevel(
                                                                      selectedQualValue);
                                                            }
                                                          }),
                                                    ),
                                                    Container(
                                                      height:
                                                          screenHeight * 0.05,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.03,
                                                      ),
                                                      child: ElevatedButton(
                                                          child: Text("Clear",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      color:
                                                                          MyApp
                                                                              .customGrey,
                                                                      fontSize: constraints.maxWidth >
                                                                              600
                                                                          ? MediaQuery.textScaleFactorOf(context) *
                                                                              15
                                                                          : MediaQuery.textScaleFactorOf(context) *
                                                                              10))),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: MyApp
                                                                .customYellow,
                                                            onPrimary:
                                                                Colors.black,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            currentPage = 0;
                                                            await _thisUserViewModel
                                                                .getUserList(0);
                                                            _isFilterSelected =
                                                                false;
                                                            setState(() {});
                                                          }),
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : _filterSelectedValue ==
                                        "Educational Qualification"
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            right: screenWidth * 0.02,
                                            bottom: screenHeight * 0.02),
                                        width: screenWidth * 0.75,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: Container(
                                                      //height: screenHeight*0.05,
                                                      padding: EdgeInsets.only(
                                                          right: screenWidth *
                                                              0.02),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            color: MyApp
                                                                .customYellow,
                                                            fontSize: constraints
                                                                        .maxWidth >
                                                                    600
                                                                ? MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    15
                                                                : MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    12),
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Educational Qualification",
                                                          alignLabelWithHint:
                                                              true,
                                                          labelStyle: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          15
                                                                      : MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          12)),
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          15
                                                                      : MediaQuery.textScaleFactorOf(
                                                                              context) *
                                                                          12)),
                                                          focusedBorder:
                                                              new OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    8.0),
                                                            borderSide: BorderSide(
                                                                color: MyApp
                                                                    .fieldSelectYellow),
                                                          ),
                                                          enabledBorder:
                                                              new OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    8.0),
                                                            borderSide: BorderSide(
                                                                color: MyApp
                                                                    .customYellow),
                                                          ),
                                                          errorBorder:
                                                              new OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    8.0),
                                                            borderSide: BorderSide(
                                                                color: MyApp
                                                                    .customYellow),
                                                          ),
                                                          border:
                                                              new OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    8.0),
                                                            borderSide: BorderSide(
                                                                color: MyApp
                                                                    .customYellow),
                                                          ),
                                                        ),
                                                        validator: (String?
                                                                value) =>
                                                            Validators
                                                                .validateField(
                                                                    value),
                                                        onChanged: (val) {
                                                          _educationallQualSelected =
                                                              val;
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: screenHeight *
                                                              0.05,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  screenWidth *
                                                                      0.01,
                                                              right:
                                                                  screenWidth *
                                                                      0.01),
                                                          child: ElevatedButton(
                                                              child: Text(
                                                                  "Filter",
                                                                  style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          color: MyApp
                                                                              .customGrey,
                                                                          fontSize: constraints.maxWidth > 600
                                                                              ? MediaQuery.textScaleFactorOf(context) *
                                                                                  15
                                                                              : MediaQuery.textScaleFactorOf(context) *
                                                                                  10))),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: MyApp
                                                                    .customYellow,
                                                                onPrimary:
                                                                    Colors
                                                                        .black,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  print(
                                                                      _educationallQualSelected);
                                                                  _isFilterSelected =
                                                                      true;
                                                                  setState(
                                                                      () {});
                                                                  _thisUserViewModel
                                                                      .filterUsersByQualification(
                                                                          "Educational",
                                                                          _educationallQualSelected!);
                                                                }
                                                              }),
                                                        ),
                                                        Container(
                                                          height: screenHeight *
                                                              0.05,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: screenWidth *
                                                                0.03,
                                                          ),
                                                          child: ElevatedButton(
                                                              child: Text(
                                                                  "Clear",
                                                                  style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          color: MyApp
                                                                              .customGrey,
                                                                          fontSize: constraints.maxWidth > 600
                                                                              ? MediaQuery.textScaleFactorOf(context) *
                                                                                  15
                                                                              : MediaQuery.textScaleFactorOf(context) *
                                                                                  10))),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: MyApp
                                                                    .customYellow,
                                                                onPrimary:
                                                                    Colors
                                                                        .black,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                currentPage = 0;
                                                                await _thisUserViewModel
                                                                    .getUserList(
                                                                        0);
                                                                _isFilterSelected =
                                                                    false;
                                                                setState(() {});
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : _filterSelectedValue ==
                                            "Professional Qualification"
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                right: screenWidth * 0.02,
                                                bottom: screenHeight * 0.02),
                                            width: screenWidth * 0.75,
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 7,
                                                        child: Container(
                                                          //height: screenHeight*0.05,
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  screenWidth *
                                                                      0.02),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                color: MyApp
                                                                    .customYellow,
                                                                fontSize: constraints
                                                                            .maxWidth >
                                                                        600
                                                                    ? MediaQuery.textScaleFactorOf(
                                                                            context) *
                                                                        15
                                                                    : MediaQuery.textScaleFactorOf(
                                                                            context) *
                                                                        12),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Professional Qualification",
                                                              alignLabelWithHint:
                                                                  true,
                                                              labelStyle: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: constraints
                                                                                  .maxWidth >
                                                                              600
                                                                          ? MediaQuery.textScaleFactorOf(context) *
                                                                              15
                                                                          : MediaQuery.textScaleFactorOf(context) *
                                                                              12)),
                                                              fillColor:
                                                                  Colors.white,
                                                              hintStyle: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: constraints
                                                                                  .maxWidth >
                                                                              600
                                                                          ? MediaQuery.textScaleFactorOf(context) *
                                                                              15
                                                                          : MediaQuery.textScaleFactorOf(context) *
                                                                              12)),
                                                              focusedBorder:
                                                                  new OutlineInputBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        8.0),
                                                                borderSide: BorderSide(
                                                                    color: MyApp
                                                                        .fieldSelectYellow),
                                                              ),
                                                              enabledBorder:
                                                                  new OutlineInputBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        8.0),
                                                                borderSide: BorderSide(
                                                                    color: MyApp
                                                                        .customYellow),
                                                              ),
                                                              errorBorder:
                                                                  new OutlineInputBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        8.0),
                                                                borderSide: BorderSide(
                                                                    color: MyApp
                                                                        .customYellow),
                                                              ),
                                                              border:
                                                                  new OutlineInputBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        8.0),
                                                                borderSide: BorderSide(
                                                                    color: MyApp
                                                                        .customYellow),
                                                              ),
                                                            ),
                                                            validator: (String?
                                                                    value) =>
                                                                Validators
                                                                    .validateField(
                                                                        value),
                                                            onChanged: (val) {
                                                              _professionalQualSelected =
                                                                  val;
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  screenHeight *
                                                                      0.05,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              padding: EdgeInsets.only(
                                                                  left:
                                                                      screenWidth *
                                                                          0.01,
                                                                  right:
                                                                      screenWidth *
                                                                          0.01),
                                                              child:
                                                                  ElevatedButton(
                                                                      child: Text(
                                                                          "Filter",
                                                                          style:
                                                                              GoogleFonts.poppins(textStyle: TextStyle(color: MyApp.customGrey, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 10))),
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            MyApp.customYellow,
                                                                        onPrimary:
                                                                            Colors.black,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      onPressed: () {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          print(
                                                                              _professionalQualSelected);
                                                                          _isFilterSelected =
                                                                              true;
                                                                          setState(
                                                                              () {});
                                                                          _thisUserViewModel.filterUsersByQualification(
                                                                              "Professional",
                                                                              _professionalQualSelected!);
                                                                        }
                                                                      }),
                                                            ),
                                                            Container(
                                                              height:
                                                                  screenHeight *
                                                                      0.05,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left:
                                                                    screenWidth *
                                                                        0.03,
                                                              ),
                                                              child:
                                                                  ElevatedButton(
                                                                      child: Text(
                                                                          "Clear",
                                                                          style:
                                                                              GoogleFonts.poppins(textStyle: TextStyle(color: MyApp.customGrey, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 10))),
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            MyApp.customYellow,
                                                                        onPrimary:
                                                                            Colors.black,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      onPressed: () async {
                                                                        currentPage =
                                                                            0;
                                                                        await _thisUserViewModel
                                                                            .getUserList(0);
                                                                        _isFilterSelected =
                                                                            false;
                                                                        setState(
                                                                            () {});
                                                                      }),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : _filterSelectedValue == "Skill"
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    right: screenWidth * 0.02,
                                                    bottom:
                                                        screenHeight * 0.02),
                                                width: screenWidth * 0.75,
                                                child: Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              //height: screenHeight*0.05,
                                                              padding: EdgeInsets.only(
                                                                  right:
                                                                      screenWidth *
                                                                          0.02),
                                                              child:
                                                                  TextFormField(
                                                                style: TextStyle(
                                                                    color: MyApp
                                                                        .customYellow,
                                                                    fontSize: constraints.maxWidth >
                                                                            600
                                                                        ? MediaQuery.textScaleFactorOf(context) *
                                                                            15
                                                                        : MediaQuery.textScaleFactorOf(context) *
                                                                            12),
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Skill",
                                                                  alignLabelWithHint:
                                                                      true,
                                                                  labelStyle: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: constraints.maxWidth > 600
                                                                              ? MediaQuery.textScaleFactorOf(context) * 15
                                                                              : MediaQuery.textScaleFactorOf(context) * 12)),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  hintStyle: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: constraints.maxWidth > 600
                                                                              ? MediaQuery.textScaleFactorOf(context) * 15
                                                                              : MediaQuery.textScaleFactorOf(context) * 12)),
                                                                  focusedBorder:
                                                                      new OutlineInputBorder(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            8.0),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                MyApp.fieldSelectYellow),
                                                                  ),
                                                                  enabledBorder:
                                                                      new OutlineInputBorder(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            8.0),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                MyApp.customYellow),
                                                                  ),
                                                                  errorBorder:
                                                                      new OutlineInputBorder(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            8.0),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                MyApp.customYellow),
                                                                  ),
                                                                  border:
                                                                      new OutlineInputBorder(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            8.0),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                MyApp.customYellow),
                                                                  ),
                                                                ),
                                                                validator: (String?
                                                                        value) =>
                                                                    Validators
                                                                        .validateField(
                                                                            value),
                                                                onChanged:
                                                                    (val) {
                                                                  _skillSelected =
                                                                      val;
                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      screenHeight *
                                                                          0.05,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  padding: EdgeInsets.only(
                                                                      left: screenWidth *
                                                                          0.01,
                                                                      right: screenWidth *
                                                                          0.01),
                                                                  child: ElevatedButton(
                                                                      child: Text("Filter", style: GoogleFonts.poppins(textStyle: TextStyle(color: MyApp.customGrey, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 10))),
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            MyApp.customYellow,
                                                                        onPrimary:
                                                                            Colors.black,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      onPressed: () {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          print(
                                                                              _skillSelected);
                                                                          _isFilterSelected =
                                                                              true;
                                                                          setState(
                                                                              () {});
                                                                          _thisUserViewModel
                                                                              .filterUsersBySkill(_skillSelected!);
                                                                        }
                                                                      }),
                                                                ),
                                                                Container(
                                                                  height:
                                                                      screenHeight *
                                                                          0.05,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left:
                                                                        screenWidth *
                                                                            0.03,
                                                                  ),
                                                                  child: ElevatedButton(
                                                                      child: Text("Clear", style: GoogleFonts.poppins(textStyle: TextStyle(color: MyApp.customGrey, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 10))),
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            MyApp.customYellow,
                                                                        onPrimary:
                                                                            Colors.black,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      onPressed: () async {
                                                                        currentPage =
                                                                            0;
                                                                        await _thisUserViewModel
                                                                            .getUserList(0);
                                                                        _isFilterSelected =
                                                                            false;
                                                                        setState(
                                                                            () {});
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : _filterSelectedValue ==
                                                    "Experience"
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            screenWidth * 0.02,
                                                        bottom: screenHeight *
                                                            0.02),
                                                    width: screenWidth * 0.75,
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 7,
                                                                child:
                                                                    Container(
                                                                  //height: screenHeight*0.05,
                                                                  padding: EdgeInsets.only(
                                                                      right: screenWidth *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        color: MyApp
                                                                            .customYellow,
                                                                        fontSize: constraints.maxWidth > 600
                                                                            ? MediaQuery.textScaleFactorOf(context) *
                                                                                15
                                                                            : MediaQuery.textScaleFactorOf(context) *
                                                                                12),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "Experience",
                                                                      alignLabelWithHint:
                                                                          true,
                                                                      labelStyle: GoogleFonts.poppins(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12)),
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      hintStyle: GoogleFonts.poppins(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12)),
                                                                      focusedBorder:
                                                                          new OutlineInputBorder(
                                                                        borderRadius:
                                                                            new BorderRadius.circular(8.0),
                                                                        borderSide:
                                                                            BorderSide(color: MyApp.fieldSelectYellow),
                                                                      ),
                                                                      enabledBorder:
                                                                          new OutlineInputBorder(
                                                                        borderRadius:
                                                                            new BorderRadius.circular(8.0),
                                                                        borderSide:
                                                                            BorderSide(color: MyApp.customYellow),
                                                                      ),
                                                                      errorBorder:
                                                                          new OutlineInputBorder(
                                                                        borderRadius:
                                                                            new BorderRadius.circular(8.0),
                                                                        borderSide:
                                                                            BorderSide(color: MyApp.customYellow),
                                                                      ),
                                                                      border:
                                                                          new OutlineInputBorder(
                                                                        borderRadius:
                                                                            new BorderRadius.circular(8.0),
                                                                        borderSide:
                                                                            BorderSide(color: MyApp.customYellow),
                                                                      ),
                                                                    ),
                                                                    validator: (String?
                                                                            value) =>
                                                                        Validators.validateField(
                                                                            value),
                                                                    onChanged:
                                                                        (val) {
                                                                      _experienceSelected =
                                                                          val;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 5,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          screenHeight *
                                                                              0.05,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      padding: EdgeInsets.only(
                                                                          left: screenWidth *
                                                                              0.01,
                                                                          right:
                                                                              screenWidth * 0.01),
                                                                      child: ElevatedButton(
                                                                          child: Text("Filter", style: GoogleFonts.poppins(textStyle: TextStyle(color: MyApp.customGrey, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 10))),
                                                                          style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                MyApp.customYellow,
                                                                            onPrimary:
                                                                                Colors.black,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              print(_experienceSelected);
                                                                              _isFilterSelected = true;
                                                                              setState(() {});
                                                                              _thisUserViewModel.filterUsersByExperience(_experienceSelected!);
                                                                            }
                                                                          }),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          screenHeight *
                                                                              0.05,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: screenWidth *
                                                                            0.03,
                                                                      ),
                                                                      child: ElevatedButton(
                                                                          child: Text("Clear", style: GoogleFonts.poppins(textStyle: TextStyle(color: MyApp.customGrey, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 10))),
                                                                          style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                MyApp.customYellow,
                                                                            onPrimary:
                                                                                Colors.black,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                          ),
                                                                          onPressed: () async {
                                                                            currentPage =
                                                                                0;
                                                                            await _thisUserViewModel.getUserList(0);
                                                                            _isFilterSelected =
                                                                                false;
                                                                            setState(() {});
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: screenWidth * 0.03, top: screenHeight * 0.03),
                child: Text(
                  "Job Seekers",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: MyApp.customYellow,
                          fontWeight: FontWeight.w400,
                          fontSize:
                              MediaQuery.textScaleFactorOf(context) * 25)),
                  textAlign: TextAlign.start,
                ),
              ),
              _thisUserViewModel.loading
                  ? Container(
                      padding: EdgeInsets.only(top: screenHeight * 0.2),
                      alignment: Alignment.center,
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
                              "Fetching User List",
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: constraints.maxWidth < 600
                          ? screenWidth * 0.9
                          : screenWidth * 0.7,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Content _thisUser =
                              _thisUserViewModel.userList![index];
                          bool isCVUploaded = false;
                          if (_thisUser.cv != null) isCVUploaded = true;

                          return _thisUser.role!.name != "JOBSEEKER"
                              ? Container()
                              : Container(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,

                                    //color: Colors.grey[600],
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: constraints.maxWidth > 600
                                                  ? 2
                                                  : 3,
                                              child: Column(
                                                children: [
                                                  Container(
                                                      child: Text(
                                                    _thisUser.firstName!,
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: constraints
                                                                        .maxWidth >
                                                                    600
                                                                ? MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    15
                                                                : MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    10)),
                                                  )),
                                                  Container(
                                                      child: Text(
                                                    _thisUser.lastName!,
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: constraints
                                                                        .maxWidth >
                                                                    600
                                                                ? MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    15
                                                                : MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    10)),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height: screenHeight * 0.06,
                                                child: VerticalDivider(
                                                    thickness:
                                                        screenWidth * 0.002,
                                                    color: Colors.white)),
                                            Expanded(
                                              flex: constraints.maxWidth > 600
                                                  ? 8
                                                  : 6,
                                              child: ListTile(
                                                title: Container(
                                                  height: screenHeight * 0.05,
                                                  width: screenWidth * 0.5,
                                                  child: Text(
                                                    "Job Sector: " +
                                                        (isCVUploaded
                                                            ? _thisUser
                                                                .cv!.jobSector!
                                                            : "Not Available"),
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            color: MyApp
                                                                .customYellow,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: constraints
                                                                        .maxWidth >
                                                                    600
                                                                ? MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    15
                                                                : MediaQuery.textScaleFactorOf(
                                                                        context) *
                                                                    12)),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                subtitle: Column(children: [
                                                  !isCVUploaded
                                                      ? Center(
                                                          child: Container(
                                                          padding: EdgeInsets.only(
                                                              top:
                                                                  screenHeight *
                                                                      0.04,
                                                              bottom:
                                                                  screenHeight *
                                                                      0.05),
                                                          child: Text(
                                                            "CV Not Uploaded Yet",
                                                            style: GoogleFonts.poppins(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        MediaQuery.textScaleFactorOf(context) *
                                                                            15)),
                                                          ),
                                                        ))
                                                      : Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: constraints.maxWidth >
                                                                            600
                                                                        ? 3
                                                                        : 5,
                                                                    child: Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          "City: ",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            textStyle: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12),
                                                                          ),
                                                                        ))),
                                                                Expanded(
                                                                  flex: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? 9
                                                                      : 7,
                                                                  child:
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            _thisUser.cv!.address!.city!,
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: constraints.maxWidth >
                                                                            600
                                                                        ? 3
                                                                        : 5,
                                                                    child: Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          "Contact No: ",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            textStyle: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12),
                                                                          ),
                                                                        ))),
                                                                Expanded(
                                                                  flex: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? 9
                                                                      : 7,
                                                                  child:
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            _thisUser.cv!.contactNo == null
                                                                                ? "Not Available"
                                                                                : _thisUser.cv!.contactNo.toString(),
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: constraints.maxWidth >
                                                                            600
                                                                        ? 3
                                                                        : 5,
                                                                    child: Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          "GCSE Passes: ",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            textStyle: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12),
                                                                          ),
                                                                        ))),
                                                                Expanded(
                                                                  flex: constraints
                                                                              .maxWidth >
                                                                          600
                                                                      ? 9
                                                                      : 7,
                                                                  child:
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            _thisUser.cv!.noOfGCSEpasses == null
                                                                                ? "Not Available"
                                                                                : _thisUser.cv!.noOfGCSEpasses.toString(),
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: constraints.maxWidth > 600 ? MediaQuery.textScaleFactorOf(context) * 15 : MediaQuery.textScaleFactorOf(context) * 12),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                ]),
                                              ),
                                            ),
                                            Expanded(
                                                flex: constraints.maxWidth > 600
                                                    ? 2
                                                    : 3,
                                                child: Container(
                                                  child: isCVUploaded
                                                      ? Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    screenHeight *
                                                                        0.01,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: TextButton(
                                                                style:
                                                                    ButtonStyle(
                                                                        padding:
                                                                            MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(
                                                                                0)),
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(MyApp
                                                                                .customYellow),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ))),
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ViewCV(
                                                                              userType: "RECRUITER",
                                                                              cv: _thisUser.cv!,
                                                                              userId: _thisUser.id!)));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: constraints
                                                                              .maxWidth <
                                                                          600
                                                                      ? screenWidth *
                                                                          0.08
                                                                      : screenWidth *
                                                                          0.06,
                                                                  child: Text(
                                                                    "View CV",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.textScaleFactorOf(context) *
                                                                                10,
                                                                        color: MyApp
                                                                            .customGrey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: screenHeight *
                                                                          0.02),
                                                            ),
                                                            Container(
                                                                child:
                                                                    TextButton(
                                                              style:
                                                                  ButtonStyle(
                                                                      padding: MaterialStateProperty.all<
                                                                              EdgeInsets>(
                                                                          EdgeInsets.all(
                                                                              0)),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<Color>(MyApp
                                                                              .customYellow),
                                                                      shape: MaterialStateProperty.all<
                                                                              RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ))),
                                                              onPressed: () {
                                                                print("delete");
                                                                showAlertDialogDelete(
                                                                    context,
                                                                    _thisUser
                                                                        .id!);
                                                              },
                                                              child: Container(
                                                                width: constraints
                                                                            .maxWidth <
                                                                        600
                                                                    ? screenWidth *
                                                                        0.08
                                                                    : screenWidth *
                                                                        0.06,
                                                                child: Text(
                                                                  "Delete CV",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          fontSize: MediaQuery.textScaleFactorOf(context) *
                                                                              10,
                                                                          color:
                                                                              MyApp.customGrey)),
                                                                ),
                                                              ),
                                                            )),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: screenHeight *
                                                                          0.02),
                                                            ),
                                                            Container(
                                                                child:
                                                                    TextButton(
                                                              style:
                                                                  ButtonStyle(
                                                                      padding: MaterialStateProperty.all<
                                                                              EdgeInsets>(
                                                                          EdgeInsets.all(
                                                                              0)),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<Color>(MyApp
                                                                              .customYellow),
                                                                      shape: MaterialStateProperty.all<
                                                                              RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ))),
                                                              onPressed: () {
                                                                print(
                                                                    "delete user");
                                                                showAlertDialogDeleteUser(
                                                                    context,
                                                                    _thisUser
                                                                        .id!);
                                                              },
                                                              child: Container(
                                                                width: constraints
                                                                            .maxWidth <
                                                                        600
                                                                    ? screenWidth *
                                                                        0.08
                                                                    : screenWidth *
                                                                        0.06,
                                                                child: Text(
                                                                  "Delete User",
                                                                  style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          fontSize: MediaQuery.textScaleFactorOf(context) *
                                                                              10,
                                                                          color:
                                                                              MyApp.customGrey)),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: screenHeight *
                                                                          0.01),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(
                                                          //height: screenHeight*0.03,
                                                          child: Column(
                                                              children: [
                                                                Container(
                                                                    child:
                                                                        TextButton(
                                                                  style: ButtonStyle(
                                                                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                                                                      backgroundColor: MaterialStateProperty.all<Color>(MyApp.customYellow),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ))),
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        "delete user");
                                                                    showAlertDialogDeleteUser(
                                                                        context,
                                                                        _thisUser
                                                                            .id!);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: constraints.maxWidth <
                                                                            600
                                                                        ? screenWidth *
                                                                            0.08
                                                                        : screenWidth *
                                                                            0.06,
                                                                    child: Text(
                                                                      "Delete User",
                                                                      style: GoogleFonts.poppins(
                                                                          textStyle: TextStyle(
                                                                              fontSize: MediaQuery.textScaleFactorOf(context) * 10,
                                                                              color: MyApp.customGrey)),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                )),
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      top: screenHeight *
                                                                          0.01),
                                                                ),
                                                              ]),
                                                        ),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        },
                        separatorBuilder: (context, position) {
                          return _thisUserViewModel
                                      .userList![position].role!.name !=
                                  "JOBSEEKER"
                              ? Container()
                              : Divider();
                        },
                        itemCount: _thisUserViewModel.userList!.length,
                      ),
                    ),
              _thisUserViewModel.isLastPage
                  ? Container()
                  : _thisUserViewModel.paginationloading
                      ? Container(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  child: LoadingRotating.square(
                                borderColor: MyApp.customYellow,
                                size: 12,
                              )),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Fetching More Users",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        )
                      : _isFilterSelected
                          ? Container()
                          : Container(
                              width: screenWidth * 0.2,
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.02),
                              child: ElevatedButton(
                                  child: Text("Load More",
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
                                  onPressed: () async {
                                    print(_thisCvViewModel.isLastPage);
                                    currentPage++;
                                    await _thisUserViewModel
                                        .getUserList(currentPage);
                                  }),
                            )
            ],
          ),
        ),
      );
    });
  }
}
