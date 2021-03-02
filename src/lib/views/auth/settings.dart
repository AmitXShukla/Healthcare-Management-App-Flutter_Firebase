import 'dart:async';
import 'dart:convert';
import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:src/models/datamodel.dart';
import 'package:src/blocs/validators.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool isAdmin = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  SettingsDataModel formData = SettingsDataModel();
  bool _btnEnabled = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  void initState() {
    AuthBloc authBloc = AuthBloc();
    getData(authBloc);
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _launched;
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
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

  getData(AuthBloc authBloc) async {
    toggleSpinner();
    messageVisible = true;
    if (authBloc.isSignedIn()) {
      if (authBloc.isSignedIn()) {
        await authBloc
            .getData()
            .then((res) => setState(
                () => updateFormData(SettingsDataModel.fromJson(res.data()))))
            .catchError((error) => showMessage(
                true, "error", "User information is not available."));
      }
    } else {
      showMessage(true, "error", "An un-known error has occured.");
    }
    toggleSpinner();
  }

  updateFormData(data) {
    formData = data;
    if (formData.role == "admin") {
      setState(() {
        isAdmin = true;
      });
    }
    _nameController.text = formData.name;
    _phoneController.text = formData.phone;
    _emailController.text = formData.email;
  }

  Future setData(AuthBloc authBloc) async {
    toggleSpinner();
    messageVisible = true;
    await authBloc
        .setData(formData)
        .then((res) => {showMessage(true, "success", "Data is saved.")})
        .catchError((error) => {showMessage(true, "error", error.toString())});
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return new Scaffold(
      appBar: AppBar(title: const Text(cSettingsTitle)),
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: isAdmin
              // ? adminNav(context, authBloc)
              ? CustomAdminDrawer()
              : CustomGuestDrawer()),
      body: ListView(
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: authBloc.isSignedIn()
                    ? settings(authBloc)
                    : loginPage(authBloc)),
          )
        ],
      ),
    );
  }

  Widget loginPage(AuthBloc authBloc) {
    return Column(
      children: [
        SizedBox(width: 10, height: 50),
        ElevatedButton(
          child: Text('Click here to go to Login page'),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/login',
            );
          },
        )
      ],
    );
  }

  Widget settings(AuthBloc authBloc) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () =>
          setState(() => _btnEnabled = _formKey.currentState.validate()),
      child: Center(
        child: Column(
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.only(top: 25.0),
            // ),
            // Container(
            //     margin: EdgeInsets.all(20.0),
            //     child: isAdmin
            //         // ? adminNav(context, authBloc)
            //         ? CustomAdminNav()
            //         : CustomGuestNav()),
            // // : guestNav(context, authBloc)),
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  controller: _nameController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.name,
                  maxLength: 50,
                  obscureText: false,
                  onChanged: (value) => formData.name = value,
                  validator: evalName,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    hintText: 'your name',
                    labelText: 'Name *',
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
                  controller: _emailController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  obscureText: false,
                  onChanged: (value) => formData.email = value,
                  validator: evalEmail,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    hintText: 'name@domain.com',
                    labelText: 'emailID *',
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 5.0),
            ),
            Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  controller: _phoneController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.phone,
                  maxLength: 50,
                  obscureText: false,
                  onChanged: (value) => formData.phone = value,
                  validator: evalPhone,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    hintText: '123-000-0000',
                    labelText: 'phone *',
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
            signinSubmitBtn(context, authBloc)
          ],
        ),
      ),
    );
  }

  Widget signinSubmitBtn(context, authBloc) {
    return ElevatedButton(
      child: Text('Save'),
      onPressed: _btnEnabled == true ? () => setData(authBloc) : null,
    );
  }
}
