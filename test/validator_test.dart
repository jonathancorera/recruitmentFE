import 'package:flutter_test/flutter_test.dart';
import 'package:recruitmentclient/common/validators.dart';
import 'package:test/test.dart' as test;

void main() {


 test.test('Generic Field - Empty Field Validator', (){

   var result = Validators.validateField("");

    test.expect(result, "Field Cannot be Empty");
  });

   test.test('Generic Field - Valid Field Validator', (){

   var result = Validators.validateField("test");

    test.expect(result, null);
  });

 test.test('Email Field - Empty Field Validator', (){

   var result = Validators.validateEmail("");

    test.expect(result, "Field Cannot be Empty");
  });

   test.test('Email Field - Invalid Format Field Validator', (){

   var result = Validators.validateEmail("test");

    test.expect(result, "Please Enter a Valid Email Address");
  });

   test.test('Email Field - Valid Field Validator', (){

   var result = Validators.validateEmail("jonathancorera@hotmail.com");

    test.expect(result, null);
  });

  test.test('Dropdown Field - Empty Field Validator', (){

   var result = Validators.validateDropDown("");

    test.expect(result, "Please Select an Option");
  });

   test.test('Dropdown Field - Not Selected Field Validator', (){

   var result = Validators.validateDropDown("Please Select");

    test.expect(result, "Please Select an Option");
  });

   test.test('Dropdown Field - Valid Field Validator', (){

   var result = Validators.validateDropDown("Test");

    test.expect(result, null);
  });

  
}