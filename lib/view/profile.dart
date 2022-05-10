import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitmentclient/main.dart';

import '../model/user.dart';

//view class for the profile page

class Profile extends StatefulWidget {
  Profile({Key? key, required this.user}) : super(key: key);

  User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfile dummyUser = new UserProfile("Jonathan", "Corera",
      "No 85 Jaya Mawatha", "jonathancorera@hotmail.com", "Admin");

  TextEditingController _addressController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController.text = dummyUser.address!;
    //print(widget.user!.firstName!);
    // print(widget.user!.role!.description);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                alignment: Alignment.topCenter,
                height: screenHeight * 0.92,
                color: MyApp.customGrey,
              ),
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: screenHeight * .25, right: 20.0, left: 20.0),
            child: new Container(
              height: screenHeight * 0.85,
              width: screenWidth * 0.8,
              child: new Card(
                color: MyApp.customYellow,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: constraints.maxWidth > 600
                              ? screenHeight * 0.07
                              : screenHeight * 0.1),
                      child: Text(
                        (widget.user.firstName! + " " + widget.user.lastName!),
                        // ("Hello"),
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: MyApp.customGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 25
                                    : MediaQuery.textScaleFactorOf(context) *
                                        20)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Text(
                        widget.user.userName!,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: MyApp.customGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: constraints.maxWidth > 600
                                    ? MediaQuery.textScaleFactorOf(context) * 25
                                    : MediaQuery.textScaleFactorOf(context) *
                                        15)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Role",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: MyApp.customGrey,
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              20
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(
                              widget.user.role!.name!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: MyApp.customGrey,
                                      fontSize: constraints.maxWidth > 600
                                          ? MediaQuery.textScaleFactorOf(
                                                  context) *
                                              20
                                          : MediaQuery.textScaleFactorOf(
                                                  context) *
                                              15)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          /*Expanded(
              flex:  8,
              child:TextFormField(
                            controller: _addressController,
                             onChanged: (content) {
                                          _addressController.text = content;
                                        },
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: MyApp.customGrey,
                                    
                                    fontSize: constraints.maxWidth > 600 ?
                                        MediaQuery.textScaleFactorOf(context) * 20
                                        : MediaQuery.textScaleFactorOf(context) * 15)
                                        
                                        ),
                            textAlign: TextAlign.start,
                          ),)
                          */
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: screenHeight * 0.05),
                      /*
       child: Container(
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.05,
                               
                             
                                child: ElevatedButton(
                                  
                                    child: Text("Update",
                                        style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    color: MyApp.customYellow,
                                                    
                                                  
                                                    fontSize:MediaQuery.textScaleFactorOf(context)*15
                                                    
                                                  ))),
                                    style: ElevatedButton.styleFrom(
                                      primary: MyApp.customGrey,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      
                                      setState(() {
                                        dummyUser.address = _addressController.text;
                                
                                      });
     
                                      print(dummyUser.address);
                                      print(dummyUser.firstName);
     
                                    }),
                              
                      ),
                      */
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: constraints.maxHeight > 600
                ? screenHeight * 0.12
                : screenHeight * 0.15,
            left: constraints.maxWidth > 600
                ? screenWidth * 0.45
                : screenWidth * 0.37,
            //bottom: screenHeight*0.3,

            child: CircleAvatar(
              radius: constraints.maxWidth > 600
                  ? screenWidth * 0.05
                  : screenHeight * 0.08,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class UserProfile {
  UserProfile(
      this.firstName, this.lastName, this.address, this.email, this.userRole);
  String? firstName;
  String? lastName;
  String? address;
  String? email;
  String? userRole;

  String setFirstName(String firstName) {
    return this.firstName = firstName;
  }
}
