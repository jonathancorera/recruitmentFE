import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:recruitmentclient/view/create_user.dart';
import 'package:recruitmentclient/view/employee_main.dart';
import 'package:recruitmentclient/view/jobseeker_main.dart';
import 'package:recruitmentclient/view/profile.dart';
import 'package:recruitmentclient/viewmodel/cv_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../model/login_response.dart';
import '../viewmodel/user_viewModel.dart';
import 'login.dart';

//view class for the home page


class Home extends StatefulWidget {
   Home({Key? key, required this.userType }) : super(key: key);



   String userType;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _profileSelected = false;
  bool _ishomeSelected = true;
  bool _isCreateaUserSelected = false;


  bool showBorder = false;

  late UserViewModel _thisUserViewModel;
  late CVViewModel _thisCvViewModel;
bool _loading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


    getUserInfo() async {
      setState(() {
        _loading = true;
      });
      
      LoginResponse? userInfo;
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = loginResponseFromJson(prefs.getString("user")!);
  
    await _thisUserViewModel.getUserbyUserName(userInfo.userName!);
   // await _thisUserViewModel.getUserbyUserName("jonathancorera@hotmail.com");
    //await _thisUserViewModel.getUserbyUserName("jeremydoe@gmail.com");
    await  _thisCvViewModel.getCVbyUserId(_thisUserViewModel.user!.id!);

    await _thisUserViewModel.getUserList(0);
  
 

       setState(() {
        _loading = false;
      });
  }

  


   @override
  void initState() {

    print("initialized");
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  getUserInfo());

  }
  


  @override
  Widget build(BuildContext context) {
     _thisUserViewModel = Provider.of<UserViewModel>(context, listen: true);
     _thisCvViewModel = Provider.of<CVViewModel>(context, listen: true);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return 
    
    LayoutBuilder(builder: (context, constraints)
    {
      if(constraints.maxWidth > 600)
      return Scaffold(
      appBar: PreferredSize(
         preferredSize: Size.fromHeight(screenHeight*0.08),
        child: AppBar(
        
          foregroundColor: MyApp.customYellow,
          backgroundColor: MyApp.customYellow,
          centerTitle: true,
          titleSpacing: 0.0,
          actions: [
            Container(
              padding: EdgeInsets.only(right: screenWidth * 0.02),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: showBorder
                      ? Border(
                          bottom: BorderSide(color: MyApp.customGrey, width: 2),
                        )
                      : null,
                ),
                child: InkWell(
                  onHover: (hovered) {
                    setState(() {
                      showBorder = hovered;
                    });
                  },
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: MyApp.customGrey,
                        textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 10))),
                    onPressed: () {
                         _profileSelected = false;
                        _ishomeSelected = true;
                        _isCreateaUserSelected = false;
                         setState(() {
                           
                         });
                         
                    },
                    child: Text(
                      'Home',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: screenWidth * 0.02),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: showBorder
                      ? Border(
                          bottom: BorderSide(color: MyApp.customGrey, width: 2),
                        )
                      : null,
                ),
                child: InkWell(
                  onHover: (hovered) {
                    setState(() {
                      showBorder = hovered;
                    });
                  },
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: MyApp.customGrey,
                        textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 10))),
                    onPressed: () {
                      print(_thisUserViewModel.user!.firstName);
                      print(_thisUserViewModel.user!.lastName);
                      print(_thisUserViewModel.user!.password);
                           _profileSelected = true;
                        _ishomeSelected = false;
                        _isCreateaUserSelected = false;
                         setState(() {
                           
                         });
                         
                    },
                    child: Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
            widget.userType == "JOBSEEKER" ?
            Container()
            :

            Container(
              padding: EdgeInsets.only(right: screenWidth * 0.02),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: showBorder
                      ? Border(
                          bottom: BorderSide(color: MyApp.customGrey, width: 2),
                        )
                      : null,
                ),
                child: InkWell(
                  onHover: (hovered) {
                    setState(() {
                      showBorder = hovered;
                    });
                  },
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: MyApp.customGrey,
                        textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 10))),
                    onPressed: () {
                        _isCreateaUserSelected = true;
                        _ishomeSelected = false;
                        _profileSelected = false;
                         setState(() {
                           
                         });
                         
                    },
                    child: Text(
                      'Create User',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
      
            Container(
              padding: EdgeInsets.only(right: screenWidth * 0.05),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: showBorder
                      ? Border(
                          bottom: BorderSide(color: MyApp.customGrey, width: 2),
                        )
                      : null,
                ),
                child: InkWell(
                  onHover: (hovered) {
                    setState(() {
                      showBorder = hovered;
                    });
                  },
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: MyApp.customGrey,
                        textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 10))),
                    onPressed: () {
                         Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                    },
                    child: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Row(
             mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                    'Recruitment App',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: MyApp.customGrey,
                            fontWeight: FontWeight.w500,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 20)),
                    textAlign: TextAlign.start,
                  ),
              )
            
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: _loading ?

     Container(
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
                                      "Fetching Your Details",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            )
                         
                          
                          
                        
                       

                    :
     
     _profileSelected ? Profile(user: _thisUserViewModel.user!,)
            : widget.userType == "JOBSEEKER" ? 
            new JobSeekerMain(cv: _thisCvViewModel.cv, userId: _thisUserViewModel.user!.id!,)
            :
              _isCreateaUserSelected ?
              CreateUser()
              :
            new EmployeeMain()
    );

    //mobile view
    else{
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
            
              color: MyApp.customYellow
            ),
            child: Center(
              child: Text(
                      'Navigate',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customGrey,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 20)),
                      textAlign: TextAlign.start,
                    ),
            ),
          ),
          
          ListTile(
            title: Text(
                      'Home',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customYellow,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.start,
                    ),
            onTap: () {
              _profileSelected = false;
              _isCreateaUserSelected = false;
              _ishomeSelected = true;
             
              setState(() {
                
              });
            },
          ),
          
          
          ListTile(
            title: Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customYellow,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.start,
                    ),
            onTap: () {

              setState(() {
                _profileSelected = true;
                _ishomeSelected = false;
                _isCreateaUserSelected = false;
                
                
              });
            },
          ),
          
         
          widget.userType == "JOBSEEKER" ?
          Container() 
          :
          ListTile(
            title: Text(
                      'Create User',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customYellow,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.start,
                    ),
            onTap: () {
                _isCreateaUserSelected = true;
                _ishomeSelected = false;
                _profileSelected = false;
              
                setState(() {
                  
                });
            },
          ),
           ListTile(
            title: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: MyApp.customYellow,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 15)),
                      textAlign: TextAlign.start,
                    ),
            onTap: () {
                Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
            },
          ),
        ],
      ),
    ),
    
      appBar: PreferredSize(
         preferredSize: Size.fromHeight(screenHeight*0.08),
        child: AppBar(
          leading: Builder(
        builder: (context) => IconButton(
            icon: new Icon(Icons.menu, color: MyApp.customGrey,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),),
        
          foregroundColor: MyApp.customYellow,
          backgroundColor: MyApp.customYellow,
          centerTitle: true,
          titleSpacing: 0.0,
          actions: [
         
          
        
      
        
          ],
          title: Row(
             mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                    'Recruitment App',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: MyApp.customGrey,
                            fontWeight: FontWeight.w500,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 20)),
                    textAlign: TextAlign.start,
                  ),
              )
            
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: _profileSelected ? Profile(user: _thisUserViewModel.user!,)
            : 
            widget.userType == "JOBSEEKER" ? 
            new  JobSeekerMain(cv: _thisCvViewModel.cv, userId: _thisUserViewModel.user!.id!)
            :
                 _isCreateaUserSelected ?
              CreateUser():
              
            (new EmployeeMain())
    );

    

    }

    

    });

    
  }

  

}
