import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recruitmentclient/view/create_CV.dart';
import 'package:recruitmentclient/view/home.dart';

import '../main.dart';
import '../model/cv.dart';
import '../viewmodel/cv_viewmodel.dart';

//view class for the page to view a CV.

class ViewCV extends StatefulWidget {
  //ViewCV({Key? key, required this.userType, }) : super(key: key);

  ViewCV(
      {Key? key,
      required this.userType,
      required this.cv,
      required this.userId})
      : super(key: key);

  CV cv;
  String userType;
  int userId;

  @override
  State<ViewCV> createState() => _ViewCVState();
}

class _ViewCVState extends State<ViewCV> {
  late CVViewModel _thisCvViewModel;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    _thisCvViewModel = Provider.of<CVViewModel>(context, listen: true);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Container(
          color: MyApp.customGrey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: Text("View CV",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customYellow,
                              fontWeight: FontWeight.w400,
                              fontSize: constraints.maxWidth > 600
                                  ? MediaQuery.textScaleFactorOf(context) * 20
                                  : MediaQuery.textScaleFactorOf(context) *
                                      20))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: screenHeight * 0.05,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.03, right: screenWidth * 0.01),
                      child: ElevatedButton(
                          child: Text("Export PDF",
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
                            _thisCvViewModel.generateCVPDf(widget.userId);
                          }),
                    ),
                    widget.userType != "JOBSEEKER"
                        ? Container()
                        : Container(
                            height: screenHeight * 0.05,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.03,
                                right: screenWidth * 0.05),
                            child: ElevatedButton(
                                child: Text("Create New",
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
                                  showAlertDialogCreateNew(context);
                                }),
                          ),
                  ],
                ),
                Container(
                    height: screenHeight * 0.75,
                    child: SingleChildScrollView(
                      child: Column(children: [
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
                                flex: 4,
                                child: Text("Address",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(
                                    widget.cv.address!.addressLine1! +
                                        ", " +
                                        widget.cv.address!.addressLine2! +
                                        ", " +
                                        widget.cv.address!.state! +
                                        ", " +
                                        widget.cv.address!.city!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
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
                                flex: 4,
                                child: Text("Contact Number",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(widget.cv.contactNo!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
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
                                flex: 4,
                                child: Text("Job Sector",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(widget.cv.jobSector!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
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
                                flex: 4,
                                child: Text("GCSE Passes",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(
                                    widget.cv.noOfGCSEpasses!.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.02,
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
                        widget.cv.experiences!.isEmpty
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.02,
                                    bottom: screenHeight * 0.01),
                                child: Text("No Experiences to Show ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))))
                            : Container(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: MyApp.customGrey,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text(
                                                  "Experience " +
                                                      (index + 1).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
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
                                                                  12))),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("Company Name",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget
                                                            .cv
                                                            .experiences![index]
                                                            .companyName!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("Role",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget
                                                            .cv
                                                            .experiences![index]
                                                            .role!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        "Experience Type",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget
                                                            .cv
                                                            .experiences![index]
                                                            .experienceType!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("Start Date",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(widget
                                                                .cv
                                                                .experiences![
                                                                    index]
                                                                .startDate!),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: constraints
                                                                            .maxWidth >
                                                                        600
                                                                    ? MediaQuery.textScaleFactorOf(context) *
                                                                        15
                                                                    : MediaQuery.textScaleFactorOf(context) *
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("End Date",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(widget
                                                                .cv
                                                                .experiences![
                                                                    index]
                                                                .endDate!),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: constraints
                                                                            .maxWidth >
                                                                        600
                                                                    ? MediaQuery.textScaleFactorOf(context) *
                                                                        15
                                                                    : MediaQuery.textScaleFactorOf(context) *
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, position) {
                                    return Divider(
                                      color: MyApp.customYellow,
                                      height: 5,
                                      thickness: 3,
                                      indent: screenWidth * 0.05,
                                      endIndent: screenWidth * 0.05,
                                    );
                                  },
                                  itemCount: widget.cv.experiences!.length,
                                ),
                              ),
                        Container(
                          height: screenHeight * 0.02,
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
                        widget.cv.qualifications!.isEmpty
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.02,
                                    bottom: screenHeight * 0.01),
                                child: Text("No Qualifications to Show ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))))
                            : Container(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: MyApp.customGrey,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text(
                                                  "Qualification " +
                                                      (index + 1).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
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
                                                                  12))),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        "Qualification Name",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget
                                                            .cv
                                                            .qualifications![
                                                                index]
                                                            .qualificationName!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        "Qualification Type",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget
                                                            .cv
                                                            .qualifications![
                                                                index]
                                                            .qualificationType!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        "Qualification Level",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget
                                                            .cv
                                                            .qualifications![
                                                                index]
                                                            .qualificationLevel!
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        "Qualification Date",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(widget
                                                                .cv
                                                                .qualifications![
                                                                    index]
                                                                .qualificationDate!),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: constraints
                                                                            .maxWidth >
                                                                        600
                                                                    ? MediaQuery.textScaleFactorOf(context) *
                                                                        15
                                                                    : MediaQuery.textScaleFactorOf(
                                                                            context) *
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("Expiry Date",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget.cv.qualifications![index].expiryDate == null
                                                            ? "Not Available"
                                                            : DateFormat('dd/MM/yyyy')
                                                                .format(widget
                                                                    .cv
                                                                    .qualifications![
                                                                        index]
                                                                    .expiryDate!),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: constraints.maxWidth >
                                                                        600
                                                                    ? MediaQuery.textScaleFactorOf(context) *
                                                                        15
                                                                    : MediaQuery.textScaleFactorOf(context) *
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, position) {
                                    return Divider(
                                      color: MyApp.customYellow,
                                      height: 5,
                                      thickness: 3,
                                      indent: screenWidth * 0.05,
                                      endIndent: screenWidth * 0.05,
                                    );
                                  },
                                  itemCount: widget.cv.qualifications!.length,
                                ),
                              ),
                        Container(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          color: MyApp.customYellow,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Text("Skill",
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
                        widget.cv.skills!.isEmpty
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.02,
                                    bottom: screenHeight * 0.01),
                                child: Text("No Skills to Show ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth > 600
                                                ? MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    15
                                                : MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    12))))
                            : Container(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: MyApp.customGrey,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text(
                                                  "Skill " +
                                                      (index + 1).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
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
                                                                  12))),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("Skill Name",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget.cv.skills![index]
                                                            .skillName!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text("Skill Type",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                        widget.cv.skills![index]
                                                            .skillType!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poppins(
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
                                                                        12))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, position) {
                                    return Divider(
                                      color: MyApp.customYellow,
                                      height: 5,
                                      thickness: 3,
                                      indent: screenWidth * 0.05,
                                      endIndent: screenWidth * 0.05,
                                    );
                                  },
                                  itemCount: widget.cv.skills!.length,
                                ),
                              ),
                      ]),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.05,
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.03,
                            right: screenWidth * 0.05),
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
                                            userType: widget.userType,
                                          )));
                            }),
                      ),
                    ])
              ],
            ),
          ),
        ),
      );
    });
  }

  showAlertDialogCreateNew(BuildContext context) {
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
                builder: (context) => ViewCV(
                      userType: widget.userType,
                      cv: widget.cv,
                      userId: widget.userId,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateCV(
                      userId: widget.userId,
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
      content: Text("Creatign a New CV will delete your old CV. Continue?",
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
}
