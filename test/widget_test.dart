// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:recruitmentclient/main.dart';
import 'package:recruitmentclient/model/cv.dart';
import 'package:recruitmentclient/view/create_CV.dart';
import 'package:recruitmentclient/view/create_user.dart';
import 'package:recruitmentclient/view/employee_main.dart';
import 'package:recruitmentclient/view/home.dart';
import 'package:recruitmentclient/view/jobseeker_main.dart';
import 'package:recruitmentclient/view/login.dart';
import 'package:recruitmentclient/view/view_CV.dart';
import 'package:recruitmentclient/viewmodel/cv_viewmodel.dart';
import 'package:recruitmentclient/viewmodel/login_viewmodel.dart';
import 'package:recruitmentclient/viewmodel/signup_viewmodel.dart';
import 'package:recruitmentclient/viewmodel/user_viewModel.dart';

void main() {


  //dummy CV for testing
  List<Experience> expList = [new Experience(companyName: "Orel", endDate:DateTime.now(), startDate: DateTime.now(), experienceType: "General", id: 1, role: "Manager" )];
    List<Qualification> qualList = [new Qualification(expiryDate: DateTime.now(), id: 1, qualificationDate: DateTime.now(), qualificationLevel: 7, qualificationName: "Bsc", qualificationType: "Educational")];
    List<Skill> skillList = [new Skill(id: 1, skillName: "Typing", skillType: "General")];
     
     CV cv = new CV(jobSector: "Engineering",
     address: new Address(addressLine1: "1", addressLine2: "2", city: "3", state: "4"),
     contactNo: "11111111", creationDate: DateTime.now(), noOfGCSEpasses: 5, experiences: expList, qualifications:qualList, skills: skillList );
  
  
  testWidgets('Login Field Tests', (WidgetTester tester) async {
    
    final addField = find.byKey(ValueKey("loginEmail"));

    await tester.pumpWidget(MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(home: Login())));
    await tester.enterText(addField, "jonathancorera@hotmail.com");
    await tester.pump();

    expect(find.text("jonathancorera@hotmail.com"), findsOneWidget);
  });


  testWidgets("Login TextFormField Test",  (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(home: Login())));
    var textField = find.byType(TextFormField);
    expect(textField, findsNWidgets(2));
  });

    testWidgets("Login ElevatedButton Test",  (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child:MaterialApp(home: Login())));
    var textField = find.byType(ElevatedButton);
    expect(textField, findsOneWidget);
  });

   testWidgets('Role Dropdown Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(
        
        home: CreateUser()),
      ));

    final dropdown = find.byKey(ValueKey('roleDropDownSelector'));

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

  
    final dropdownItem = find.text('Please Select').last;
    final dropdownItem2 = find.text('JobSeeker').last;
    final dropdownItem3 = find.text('Recruiter').last;

    await tester.tap(dropdownItem);
      await tester.tap(dropdownItem2);
        await tester.tap(dropdownItem3);
    await tester.pumpAndSettle();
  });



  testWidgets('Job Sector Dropdown Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(
        
        home: CreateCV(userId: 11,)),
      ));

    final dropdown = find.byKey(ValueKey('jobSectorDropDownSelector'));

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

  
    final dropdownItem = find.text('Please Select').last;
    final dropdownItem2 = find.text('Business').last;
    final dropdownItem3 = find.text('Marketing').last;
    final dropdownItem4 = find.text('Nursing').last;
    final dropdownItem5 = find.text('Sales').last;
    final dropdownItem6 = find.text('Engineering').last;
    final dropdownItem7 = find.text('IT').last;

    await tester.tap(dropdownItem);
      await tester.tap(dropdownItem2);
        await tester.tap(dropdownItem3);
        await tester.tap(dropdownItem4);
        await tester.tap(dropdownItem5);
        await tester.tap(dropdownItem6);
        await tester.tap(dropdownItem7);
    await tester.pumpAndSettle();
  });


    testWidgets('Skill Type Dropdown Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(
        
        home: Scaffold(body: SkillFormFields())),
      ));


  

        final dropdown = find.byKey(ValueKey('skillDropDownSelector'));
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

  
    final dropdownItem = find.text('Please Select').last;
    final dropdownItem2 = find.text('Technical').last;
    final dropdownItem3 = find.text('Management').last;
 final dropdownItem4 = find.text('Other').last;



    await tester.tap(dropdownItem);
      await tester.tap(dropdownItem2);
        await tester.tap(dropdownItem3);
        await tester.tap(dropdownItem4);

    await tester.pumpAndSettle();
  });


  testWidgets('Qualification Type Dropdown Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(
        
        home: Scaffold(body: QualificationFormFields())),
      ));


  

        final dropdown = find.byKey(ValueKey('qualificationDropDownSelector'));
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

  
    final dropdownItem = find.text('Please Select').last;
    final dropdownItem2 = find.text('Professional').last;
    final dropdownItem3 = find.text('Educational').last;

    await tester.tap(dropdownItem);
      await tester.tap(dropdownItem2);
        await tester.tap(dropdownItem3);


    await tester.pumpAndSettle();
  });


  testWidgets('Filter Expansiontile Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],
        child: MaterialApp(
        
        home: Scaffold (body: EmployeeMain())),
      ));


        final expTile = find.byKey(ValueKey('filterExpansionTile'));
    await tester.tap(expTile);
    await tester.pumpAndSettle();

  });


    testWidgets('View CV as Jobseeker Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    
    

    
    await tester.pumpWidget(
      
     
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],

    
        child: MaterialApp(
        
        home:  ViewCV(userId: 138, cv: cv, userType: "JOBSEEKER",)),
      ));


        final createCVButton = find.byType(ElevatedButton);


     expect(createCVButton, findsNWidgets(3));


  });


    testWidgets('View CV as Recruiter Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    
    

    
    await tester.pumpWidget(
      
     
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],

    
        child: MaterialApp(
        
        home:  ViewCV(userId: 138, cv: cv, userType: "RECRUITER",)),
      ));


        final createCVButton = find.byType(ElevatedButton);


     expect(createCVButton, findsNWidgets(2));


  });




    testWidgets('New Jobseeker without CV Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    
    await tester.pumpWidget(
      
     
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],

    
        child: MaterialApp(
        
        home:  JobSeekerMain(userId: 138, cv: null, )),
      ));


        final createCVButton = find.byType(ElevatedButton);
        final findText = find.text("You have not created a CV yet");
        
     expect(createCVButton, findsOneWidget);


  });


      testWidgets('New Jobseeker with CV Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    
    await tester.pumpWidget(
      
     
      MultiProvider(
              providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CVViewModel()),

      ],

    
        child: MaterialApp(
        
        home:  JobSeekerMain(userId: 138, cv: cv, )),
      ));


        final createCVButton = find.byType(ElevatedButton);
        final findText = find.text("View CV");
        
     expect(createCVButton, findsOneWidget);


  });


}