import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(email))
      sink.add(email);
    else
      sink.addError('Please enter a valid email');
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.addError('Invalid password, please enter more than 4 characters');
    }
  });

  final validateText =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError('Invalid Text, please enter minimum 4 characters');
    }
  });
  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    Pattern pattern = r'^[2-9]\d{2}-\d{3}-\d{4}$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(phone))
      sink.add(phone);
    else
      sink.addError('ex. 123-456-7890');
  });

  bool validateFormText(String txt) {
    //WhitelistingTextInputFormatter(new RegExp(r'^[()\d -]{1,15}$')),
    if (txt.isEmpty) return true;
    return false;
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return regex.hasMatch(input);
  }
}

String evalPassword(String value) {
  Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "password is Required";
  } else if (!regex.hasMatch(value))
    return 'please enter 8 chars alphanumeric password';
  else
    return null;
}

String evalEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "email is required";
  } else if (!regex.hasMatch(value))
    return 'please enter valid email';
  else
    return null;
}

String evalName(String value) {
  if (value.length < 4) {
    return "please enter min. 4 chars text";
  }
  return null;
}

String evalChar(String value) {
  if (value.length < 1) {
    return "please enter min. 1 chars text";
  }
  return null;
}

String evalPhone(String value) {
  Pattern pattern = r'^[2-9]\d{2}-\d{3}-\d{4}$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "phone is required";
  } else if (!regex.hasMatch(value))
    return 'ex. valid phone 000-000-0000';
  else
    return null;
}

final validatorBloc = Validators();
