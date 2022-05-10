//this file contains common validators that would be used on input fields 

class Validators {

static String? validateField (String? value) {
  return (value == null || value.isEmpty) ? "Field Cannot be Empty" : null;

}

static String? validateEmail (String? value) {
  if (value == null || value.isEmpty) 
  return "Field Cannot be Empty";
  else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please Enter a Valid Email Address";
                  }
  else
  return null;

}

static String? validateDropDown (String? value) {
  if (value == null || value.isEmpty  || value == "Please Select") 
  return "Please Select an Option";
  else
  return null;

}

}