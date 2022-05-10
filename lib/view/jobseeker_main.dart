import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitmentclient/main.dart';
import 'package:recruitmentclient/view/create_CV.dart';
import 'package:recruitmentclient/view/view_CV.dart';

import '../model/cv.dart';

//view class for the job seeker main page

class JobSeekerMain extends StatefulWidget {
  //JobSeekerMain({ Key? key,}) : super(key: key);

  JobSeekerMain({Key? key, required this.cv, required this.userId})
      : super(key: key);

  CV? cv;
  int? userId;

  @override
  State<JobSeekerMain> createState() => _JobSeekerMainState();
}

class _JobSeekerMainState extends State<JobSeekerMain> {
  bool _isCVComplete = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      if (!_isCVComplete) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: MyApp.customYellow, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: Alignment.center,
                  height: screenHeight * 0.5,
                  width: constraints.maxWidth > 600
                      ? screenWidth * 0.5
                      : screenWidth * 0.8,
                  child: (widget.cv == null)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Flexible(
                              child: Text("You have not created a CV yet",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: MyApp.customYellow,
                                          fontWeight: FontWeight.w400,
                                          fontSize: constraints.maxWidth > 600
                                              ? MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  20
                                              : MediaQuery.textScaleFactorOf(
                                                      context) *
                                                  15))),
                            )),
                            Container(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.05),
                              child: Container(
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.05,
                                child: ElevatedButton(
                                    child: Text("Create CV",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: MyApp.customGrey,
                                                fontSize: constraints.maxWidth >
                                                        600
                                                    ? MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        15
                                                    : MediaQuery
                                                            .textScaleFactorOf(
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
                                              builder: (context) => CreateCV(
                                                    userId: widget.userId!,
                                                  )));
                                    }),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.05),
                              child: Container(
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.05,
                                child: ElevatedButton(
                                    child: Text("View CV",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: MyApp.customGrey,
                                                fontSize: constraints.maxWidth >
                                                        600
                                                    ? MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        15
                                                    : MediaQuery
                                                            .textScaleFactorOf(
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
                                              builder: (context) => ViewCV(
                                                    userType: "JOBSEEKER",
                                                    cv: widget.cv!,
                                                    userId: widget.userId!,
                                                  )));
                                    }),
                              ),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
