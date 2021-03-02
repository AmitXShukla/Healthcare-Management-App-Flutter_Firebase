import 'dart:async';
import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:src/models/datamodel.dart';
import 'package:src/blocs/validators.dart';
import 'package:flutter/material.dart';
import 'package:src/views/aboutus.dart';
import 'package:src/views/auth/login.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  final model = LoginDataModel();
  bool _btnEnabled = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  showMessage(bool msgVisible, msgType, message) {
    messageVisible = msgVisible;
    setState(() {
      messageType = msgType == "error"
          ? cMessageType.error.toString()
          : cMessageType.success.toString();
      messageTxt = message;
    });
  }

  fetchData(AuthBloc authBloc) async {
    toggleSpinner();
    var userAuth = await authBloc.signUpWithEmail(model);
    if (userAuth == "") {
      showMessage(true, "success", "Login Successful");
    } else {
      showMessage(
          true,
          "error",
          (userAuth == 'email-already-in-use')
              ? "This email is already registered. Please click on Already have an account below and login. If you lost your password, please send an email to info@elishconsulting.com to unlock your account."
              : ((userAuth == 'weak-password')
                  ? "weak password"
                  : "An un-known error has occured."));
    }
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return new Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu_open),
            color: Colors.deepOrangeAccent,
            iconSize: 28.0,
            onPressed: () {
              // Navigator.pushReplacementNamed(context, '/aboutus');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
          title: const Text(cSignupTitle)),
      body: ListView(
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: authBloc.isSignedIn()
                    ? settingsPage(authBloc)
                    : userForm(authBloc)),
          )
        ],
      ),
    );
  }

  Widget userForm(AuthBloc authBloc) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () =>
          setState(() => _btnEnabled = _formKey.currentState.validate()),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  obscureText: false,
                  onChanged: (value) => model.email = value,
                  validator: evalEmail,
                  // onSaved: (value) => _email = value,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    hintText: 'username@domain.com',
                    labelText: 'EmailID *',
                    // errorText: snapshot.error,
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 5.0),
            ),
            Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  controller: _passwordController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 50,
                  obscureText: true,
                  onChanged: (value) => model.password = value,
                  validator: evalPassword,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    hintText: 'enter password',
                    labelText: 'Password *',
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            CustomSpinner(toggleSpinner: spinnerVisible),
            CustomMessage(
                toggleMessage: messageVisible,
                toggleMessageType: messageType,
                toggleMessageTxt: messageTxt),
            Container(
              margin: EdgeInsets.only(top: 15.0),
            ),
            signinSubmitBtn(context, authBloc),
            Container(
              margin: EdgeInsets.only(top: 15.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(
                //   context,
                //   '/login',
                // );
              },
              child: Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add),
                  ),
                  label: Text("Already have an Account", style: cNavText)),
            )
          ],
        ),
      ),
    );
  }

  Widget signinSubmitBtn(context, authBloc) {
    return ElevatedButton(
      child: Text('Signup'),
      onPressed: _btnEnabled == true ? () => fetchData(authBloc) : null,
    );
  }

  Widget settingsPage(AuthBloc authBloc) {
    return Column(
      children: [
        Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.add),
            ),
            label: Text("Welcome to HMS App", style: cNavText)),
        SizedBox(width: 20, height: 50),
        ElevatedButton(
          child: Text('Logout'),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/login',
            );
          },
        ),
        SizedBox(width: 20, height: 50),
        ElevatedButton(
          child: Text('click here to go to Settings'),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/settings',
            );
          },
        )
      ],
    );
  }
}
