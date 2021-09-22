import 'dart:async';
import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:src/models/datamodel.dart';
import 'package:src/blocs/validators.dart';
import 'package:flutter/material.dart';

class AdminEdit extends StatefulWidget {
  static const routeName = '/adminedit';
  @override
  AdminEditState createState() => AdminEditState();
}

class AdminEditState extends State<AdminEdit> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool isAdmin = false;
  String messageTxt = "";
  String messageType = "";
  String dropDownRoleValue = 'none';
  final _formKey = GlobalKey<FormState>();
  SettingsDataModel formData = SettingsDataModel();
  bool _btnEnabled = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _authorController = new TextEditingController();
  TextEditingController _roleController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthBloc authBloc = AuthBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) => this.getData(authBloc));
  }

  @override
  void dispose() {
    authBloc.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _authorController.dispose();
    _roleController.dispose();
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

  getData(AuthBloc authBloc) async {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    toggleSpinner();
    messageVisible = true;
    if (authBloc.isSignedIn()) {
      await authBloc
          .getDocData("users", args.patientID)
          .then((res) => setState(
              () => updateFormData(SettingsDataModel.fromJson(res.data()))))
          .catchError((error) =>
              showMessage(true, "error", "User information is not available."));
    } else {
      showMessage(true, "error", "An un-known error has occured.");
    }
    toggleSpinner();
  }

  updateFormData(data) {
    formData = data;
    // this page is admin already, and formData already has role field
    isAdmin = true;
    // if (formData.role == "admin") {
    //   setState(() {
    //     isAdmin = true;
    //   });
    // }
    _nameController.text = formData.name;
    _phoneController.text = formData.phone;
    _emailController.text = formData.email;
    _authorController.text = formData.author;
    _roleController.text = formData.role == null ? "none" : formData.role;
    if (formData.role != null) dropDownRoleValue = formData.role;
    return false;
  }

  Future setData(AuthBloc authBloc) async {
    toggleSpinner();
    messageVisible = true;
    await authBloc
        .updData(formData)
        .then((res) => {showMessage(true, "success", "Data is saved.")})
        .catchError((error) => {showMessage(true, "error", error.toString())});
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return new Scaffold(
      appBar: AppBar(title: const Text(cAdmin)),
      drawer:
          Drawer(child: isAdmin ? CustomAdminDrawer() : CustomGuestDrawer()),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, color: Colors.grey),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                Text("Edit User", style: cHeaderDarkText),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                IconButton(
                  icon: Icon(Icons.backspace, color: Colors.blueAccent),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/admin');
                  },
                ),
              ],
            ),
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
                    hintText: 'User name',
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
              margin: EdgeInsets.only(top: 5.0),
            ),
            Container(
              width: 100.0,
              margin: EdgeInsets.only(top: 25.0),
              child: DropdownButton<String>(
                value: dropDownRoleValue,
                icon: Icon(Icons.settings),
                iconSize: 24,
                elevation: 16,
                hint: Text("ID Type"),
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  formData.role = newValue;
                  setState(() {
                    dropDownRoleValue = newValue;
                  });
                },
                items: <String>['admin', 'employee', 'patient', 'none']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
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
            saveSubmitBtn(context, authBloc)
          ],
        ),
      ),
    );
  }

  Widget saveSubmitBtn(context, authBloc) {
    return ElevatedButton(
      child: Text('Save'),
      onPressed: _btnEnabled == true ? () => setData(authBloc) : null,
    );
  }
}
