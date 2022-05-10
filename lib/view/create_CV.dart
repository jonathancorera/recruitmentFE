import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:recruitmentclient/common/validators.dart';
import 'package:recruitmentclient/model/cv.dart';
import 'package:recruitmentclient/view/home.dart';
import 'package:recruitmentclient/viewmodel/cv_viewmodel.dart';
import '../main.dart';

//view class for the page to create a CV

class CreateCV extends StatefulWidget {
  CreateCV({Key? key, required this.userId}) : super(key: key);

  int? userId;

  @override
  State<CreateCV> createState() => _CreateCVState();
}

class _CreateCVState extends State<CreateCV> {
  late CVViewModel _thisCvViewModel;
  String jobSectorInitialValue = "Please Select";
  bool _firstItemSelected = false;

  List<ExperienceFormFields> expList = [];
  List<Experience> expListFull = [];

  List<QualificationFormFields> qualList = [];
  List<Qualification> qualListFull = [];

  List<SkillFormFields> skillList = [];
  List<Skill> skillListFull = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _expStartDate;

  TextEditingController expStartDateController = new TextEditingController();

  String? _addressLine1;
  String? _addressLine2;
  String? _state;
  String? _city;
  String? _contactNo;
  String? _gcsePasses;
  String? _jobSector;

  @override
  Widget build(BuildContext context) {
    _thisCvViewModel = Provider.of<CVViewModel>(context, listen: true);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Container(
          color: MyApp.customGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: Text("Create CV",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: MyApp.customYellow,
                            fontWeight: FontWeight.w400,
                            fontSize: constraints.maxWidth > 600
                                ? MediaQuery.textScaleFactorOf(context) * 20
                                : MediaQuery.textScaleFactorOf(context) * 20))),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    top: screenHeight * 0.03, left: screenWidth * 0.02),
                child: Text("Please Fill in All the Details Below",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: MyApp.customYellow,
                            fontWeight: FontWeight.w400,
                            fontSize: constraints.maxWidth > 600
                                ? MediaQuery.textScaleFactorOf(context) * 15
                                : MediaQuery.textScaleFactorOf(context) * 12))),
              ),
              Container(
                height: screenHeight * 0.75,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          color: MyApp.customYellow,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Text("General Info",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: MyApp.customGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12))),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text("Address Line 1",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  //height: screenHeight*0.05,
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "Address Line 1",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {
                                      _addressLine1 = val;
                                      setState(() {});
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
                                child: Text("Address Line 2",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  //height: screenHeight*0.05,
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "Address Line 2",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {
                                      _addressLine2 = val;
                                      setState(() {});
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
                                child: Text("City",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  //height: screenHeight*0.05,
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "City",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {
                                      _city = val;
                                      setState(() {});
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
                                child: Text("State / Province",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  //height: screenHeight*0.05,
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "State / Province",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {
                                      _state = val;
                                      setState(() {});
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
                                child: Text("Contact No.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  //height: screenHeight*0.05,
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "Contact No.",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {
                                      _contactNo = val;
                                      setState(() {});
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
                                child: Text("GCSE Passes",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  //height: screenHeight*0.05,
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "GCE Passes.",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {
                                      _gcsePasses = val;
                                      setState(() {});
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
                                child: Text("Job Sector",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customYellow,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
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
                                          key: Key("jobSectorDropDownSelector"),
                                          validator: (value) =>
                                              Validators.validateDropDown(
                                                  value),
                                          isExpanded: true,
                                          value: jobSectorInitialValue,
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
                                              jobSectorInitialValue = newValue!;
                                              _firstItemSelected = true;
                                              _jobSector = newValue;
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
                          height: screenHeight * 0.04,
                        ),
                        Container(
                          color: MyApp.customYellow,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Text("Work Experience",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: MyApp.customGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12))),
                        ),
                        Container(
                          //height: screenHeight*0.3,
                          padding: EdgeInsets.all(20.0),
                          child: ListView.builder(
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                Widget widget = expList.elementAt(index);
                                return widget;
                              },
                              shrinkWrap: true,
                              itemCount: expList.length,
                              physics: NeverScrollableScrollPhysics()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.03),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: MyApp.customYellow,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  expList.add(new ExperienceFormFields());
                                  setState(() {});
                                },
                                child: new Icon(Icons.add,
                                    color: MyApp.customGrey),
                              ),
                            ),
                            expList.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.03),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: MyApp.customYellow,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        expList.removeLast();
                                        setState(() {});
                                      },
                                      child: new Icon(Icons.remove,
                                          color: MyApp.customGrey),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        Container(
                          height: screenHeight * 0.04,
                        ),
                        Container(
                          color: MyApp.customYellow,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Text("Qualifications",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: MyApp.customGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12))),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: ListView.builder(
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                Widget widget = qualList.elementAt(index);
                                return widget;
                              },
                              shrinkWrap: true,
                              itemCount: qualList.length,
                              physics: NeverScrollableScrollPhysics()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.03),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: MyApp.customYellow,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  qualList.add(new QualificationFormFields());
                                  setState(() {});
                                },
                                child: new Icon(
                                  Icons.add,
                                  color: MyApp.customGrey,
                                ),
                              ),
                            ),
                            qualList.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.03),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: MyApp.customYellow,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        qualList.removeLast();
                                        setState(() {});
                                      },
                                      child: new Icon(Icons.remove,
                                          color: MyApp.customGrey),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        Container(
                          height: screenHeight * 0.04,
                        ),
                        Container(
                          color: MyApp.customYellow,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Text("Skills",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: MyApp.customGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12))),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: ListView.builder(
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                Widget widget = skillList.elementAt(index);
                                return widget;
                              },
                              shrinkWrap: true,
                              itemCount: skillList.length,
                              physics: NeverScrollableScrollPhysics()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.03),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: MyApp.customYellow,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  skillList.add(new SkillFormFields());
                                  setState(() {});
                                },
                                child: new Icon(
                                  Icons.add,
                                  color: MyApp.customGrey,
                                ),
                              ),
                            ),
                            skillList.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.03),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: MyApp.customYellow,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        skillList.removeLast();
                                        setState(() {});
                                      },
                                      child: new Icon(Icons.remove,
                                          color: MyApp.customGrey),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _thisCvViewModel.loading
                  ? Container(
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
                              "Creating CV",
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: (screenWidth < 600)
                                ? screenWidth * 0.25
                                : screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                                child: Text("Submit",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customGrey,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    10))),
                                style: ElevatedButton.styleFrom(
                                  primary: MyApp.customYellow,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    submitData();
                                    Address thisAddress = new Address(
                                        addressLine1: _addressLine1,
                                        addressLine2: _addressLine2,
                                        state: _state,
                                        city: _city);

                                    CV thisCV = new CV(
                                      address: thisAddress,
                                      contactNo: _contactNo,
                                      jobSector: _jobSector,
                                      noOfGCSEpasses: int.parse(_gcsePasses!),
                                      creationDate: DateTime.now(),
                                      experiences: expListFull,
                                      skills: skillListFull,
                                      qualifications: qualListFull,
                                    );
                                    await _thisCvViewModel.createCV(
                                        widget.userId!, thisCV);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                  userType: "JOBSEEKER",
                                                )));
                                  }
                                }),
                          ),
                          Container(
                            width: screenWidth * 0.26,
                            height: screenHeight * 0.05,
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.03,
                                right: screenWidth * 0.02),
                            child: ElevatedButton(
                                child: Text("Back",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: MyApp.customGrey,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    10))),
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
                                          builder: (context) => Home(
                                                userType: "JOBSEEKER",
                                              )));
                                }),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }

  submitData() {
    expListFull.clear();

    expList.forEach((element) {
      // expCompanyList.add(element.companyController.text);

      expListFull.add(new Experience(
          companyName: element.companyController.text,
          experienceType: element.typeController.text,
          role: element.roleController.text,
          startDate: DateTime.parse(element.expStartDateController.text),
          endDate: DateTime.parse(element.expEndDateController.text)));
    });

    qualListFull.clear();
    qualList.forEach((element) {
      qualListFull.add(new Qualification(
          qualificationType: element.dropDownValue,
          qualificationName: element.nameController.text,
          qualificationLevel: int.parse(element.levelController.text),
          qualificationDate: DateTime.parse(element.qualDateController.text),
          expiryDate: element.expDateController.text == ""
              ? null
              : DateTime.parse(element.expDateController.text)));
    });

    skillListFull.clear();

    skillList.forEach((element) {
      skillListFull.add(new Skill(
          skillType: element.dropDownValue,
          skillName: element.nameController.text));
    });
  }
}

class ExperienceFormFields extends StatelessWidget {
  TextEditingController companyController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();

  TextEditingController expStartDateController = TextEditingController();
  TextEditingController expEndDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: MyApp.customYellow, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01, left: screenWidth * 0.02),
                  child: Text("Work Experience",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: constraints.maxWidth > 600
                                  ? MediaQuery.textScaleFactorOf(context) * 20
                                  : MediaQuery.textScaleFactorOf(context) *
                                      15))),
                ),
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Company Name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: screenHeight*0.05,
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                            controller: companyController,
                            style: TextStyle(
                                color: MyApp.customYellow,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 15
                                    : MediaQuery.textScaleFactorOf(context) *
                                        12),
                            decoration: InputDecoration(
                              labelText: "Company Name",
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600
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
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12)),
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
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                            ),
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {},
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
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: screenHeight*0.05,
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                            controller: roleController,
                            style: TextStyle(
                                color: MyApp.customYellow,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 15
                                    : MediaQuery.textScaleFactorOf(context) *
                                        12),
                            decoration: InputDecoration(
                              labelText: "Role",
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600
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
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12)),
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
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                            ),
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {},
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
                        child: Text("Experience Type",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: screenHeight*0.05,
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                            controller: typeController,
                            style: TextStyle(
                                color: MyApp.customYellow,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 15
                                    : MediaQuery.textScaleFactorOf(context) *
                                        12),
                            decoration: InputDecoration(
                              labelText: "Experience Type",
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600
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
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12)),
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
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                            ),
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {},
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
                        child: Text("Start Date",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                              controller: expStartDateController,
                              style: TextStyle(
                                  color: MyApp.customYellow,
                                  fontSize: constraints.maxWidth > 600
                                      ? MediaQuery.textScaleFactorOf(context) *
                                          15
                                      : MediaQuery.textScaleFactorOf(context) *
                                          12),
                              decoration: InputDecoration(
                                labelText: "Start Date",
                                alignLabelWithHint: true,
                                labelStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth > 600
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
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12)),
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
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                              ),
                              validator: (String? value) =>
                                  Validators.validateField(value),
                              onChanged: (val) {},
                              onTap: () async {
                                DateTime date = DateTime(1900);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100)) as DateTime;
                                expStartDateController.text = date.toString();
                              }),
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
                        child: Text("End Date",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                              controller: expEndDateController,
                              style: TextStyle(
                                  color: MyApp.customYellow,
                                  fontSize: constraints.maxWidth > 600
                                      ? MediaQuery.textScaleFactorOf(context) *
                                          15
                                      : MediaQuery.textScaleFactorOf(context) *
                                          12),
                              decoration: InputDecoration(
                                labelText: "End Date",
                                alignLabelWithHint: true,
                                labelStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth > 600
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
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12)),
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
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                              ),
                              validator: (String? value) =>
                                  Validators.validateField(value),
                              onChanged: (val) {},
                              onTap: () async {
                                DateTime date = DateTime(1900);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100)) as DateTime;
                                expEndDateController.text = date.toString();
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.03,
          ),
        ],
      );
    });
  }
}

class QualificationFormFields extends StatefulWidget {
  QualificationFormFields({Key? key}) : super(key: key);

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController typeController = new TextEditingController();
  final TextEditingController levelController = new TextEditingController();

  final TextEditingController qualDateController = new TextEditingController();
  final TextEditingController expDateController = new TextEditingController();
  String? dropDownValue;
  bool doesExpire = true;

  @override
  State<QualificationFormFields> createState() =>
      _QualificationFormFieldsState();
}

class _QualificationFormFieldsState extends State<QualificationFormFields> {
  String qualificationInitialValue = "Please Select";
  bool _firstItemSelected = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: MyApp.customYellow, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01, left: screenWidth * 0.02),
                  child: Text("Qualification",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: constraints.maxWidth > 600
                                  ? MediaQuery.textScaleFactorOf(context) * 20
                                  : MediaQuery.textScaleFactorOf(context) *
                                      15))),
                ),
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Qualification Name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: screenHeight*0.05,
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                            controller: widget.nameController,
                            style: TextStyle(
                                color: MyApp.customYellow,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 15
                                    : MediaQuery.textScaleFactorOf(context) *
                                        12),
                            decoration: InputDecoration(
                              labelText: "Qualification Name",
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600
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
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12)),
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
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                            ),
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {},
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
                        child: Text("Type",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
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
                                  key: Key("qualificationDropDownSelector"),
                                  validator: (value) =>
                                      Validators.validateDropDown(value),
                                  isExpanded: true,
                                  value: qualificationInitialValue,
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
                                      qualificationInitialValue = newValue!;
                                      _firstItemSelected = true;
                                      widget.dropDownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    "Please Select",
                                    "Educational",
                                    "Professional"
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
                        child: Text("Qualification Level",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: screenHeight*0.05,
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                            controller: widget.levelController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                                color: MyApp.customYellow,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 15
                                    : MediaQuery.textScaleFactorOf(context) *
                                        12),
                            decoration: InputDecoration(
                              labelText: "Qualification Level",
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600
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
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12)),
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
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                            ),
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {},
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
                        child: Text("Qualification Date",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                              controller: widget.qualDateController,
                              style: TextStyle(
                                  color: MyApp.customYellow,
                                  fontSize: constraints.maxWidth > 600
                                      ? MediaQuery.textScaleFactorOf(context) *
                                          15
                                      : MediaQuery.textScaleFactorOf(context) *
                                          12),
                              decoration: InputDecoration(
                                labelText: "Qualification Date",
                                alignLabelWithHint: true,
                                labelStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth > 600
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
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12)),
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
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide:
                                      BorderSide(color: MyApp.customYellow),
                                ),
                              ),
                              validator: (String? value) =>
                                  Validators.validateField(value),
                              onChanged: (val) {},
                              onTap: () async {
                                DateTime date = DateTime(1900);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100)) as DateTime;
                                widget.qualDateController.text =
                                    date.toString();
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.25, top: screenHeight * 0.01),
                  child: CheckboxListTile(
                    tileColor: Colors.grey,
                    activeColor: MyApp.customYellow,
                    checkColor: MyApp.customGrey,
                    title: Text("Has Expiry?"),
                    value: widget.doesExpire,
                    onChanged: (newValue) {
                      setState(() {
                        widget.doesExpire = newValue!;
                        widget.expDateController.text = "";
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                widget.doesExpire
                    ? Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("Expiry Date",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: MyApp.customYellow,
                                          fontSize: constraints.maxWidth > 600
                                              ? MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15
                                              : MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  12))),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.02),
                                child: TextFormField(
                                    controller: widget.expDateController,
                                    style: TextStyle(
                                        color: MyApp.customYellow,
                                        fontSize: constraints.maxWidth > 600
                                            ? MediaQuery.textScaleFactorOf(
                                                    context) *
                                                15
                                            : MediaQuery.textScaleFactorOf(
                                                    context) *
                                                12),
                                    decoration: InputDecoration(
                                      labelText: "Expiry Date",
                                      alignLabelWithHint: true,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
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
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.fieldSelectYellow),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: MyApp.customYellow),
                                      ),
                                    ),
                                    validator: (String? value) =>
                                        Validators.validateField(value),
                                    onChanged: (val) {},
                                    onTap: () async {
                                      DateTime date = DateTime(1900);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());

                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100)) as DateTime;
                                      widget.expDateController.text =
                                          date.toString();
                                    }),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.03,
          ),
        ],
      );
    });
  }
}

class SkillFormFields extends StatefulWidget {
  SkillFormFields({Key? key}) : super(key: key);

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController typeController = new TextEditingController();

  String? dropDownValue;

  @override
  State<SkillFormFields> createState() => _SkillFormFieldsState();
}

class _SkillFormFieldsState extends State<SkillFormFields> {
  String skillInitialValue = "Please Select";
  bool _firstItemSelected = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: MyApp.customYellow, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01, left: screenWidth * 0.02),
                  child: Text("Skill",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: constraints.maxWidth > 600
                                  ? MediaQuery.textScaleFactorOf(context) * 20
                                  : MediaQuery.textScaleFactorOf(context) *
                                      15))),
                ),
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Skill Name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: screenHeight*0.05,
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: TextFormField(
                            controller: widget.nameController,
                            style: TextStyle(
                                color: MyApp.customYellow,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 15
                                    : MediaQuery.textScaleFactorOf(context) *
                                        12),
                            decoration: InputDecoration(
                              labelText: "Skill Name",
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600
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
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12)),
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
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: MyApp.customYellow),
                              ),
                            ),
                            validator: (String? value) =>
                                Validators.validateField(value),
                            onChanged: (val) {},
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
                        child: Text("Type",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customYellow,
                                    fontSize: constraints.maxWidth > 600
                                        ? MediaQuery.textScaleFactorOf(
                                                context) *
                                            15
                                        : MediaQuery.textScaleFactorOf(
                                                context) *
                                            12))),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: Container(
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
                                  key: Key("skillDropDownSelector"),
                                  validator: (value) =>
                                      Validators.validateDropDown(value),
                                  isExpanded: true,
                                  value: skillInitialValue,
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
                                      skillInitialValue = newValue!;
                                      _firstItemSelected = true;
                                      widget.dropDownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    "Please Select",
                                    "Technical",
                                    "Management",
                                    "Other"
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
                )
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.03,
          ),
        ],
      );
    });
  }
}
