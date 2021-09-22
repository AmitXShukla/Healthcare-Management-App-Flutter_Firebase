import 'dart:html';

import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/models/datamodel.dart';
import 'package:src/blocs/validators.dart';

class Admin extends StatefulWidget {
  static const routeName = '/admin';
  @override
  AdminState createState() => AdminState();
}

class AdminState extends State<Admin> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool srchVisible = false;
  String messageTxt = "";
  String messageType = "";
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  SettingsDataModel formData = SettingsDataModel();
  bool _btnEnabled = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
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

  clearSearch() {
    _nameController.text = "";
    _emailController.text = "";
    _phoneController.text = "";
    formData.name = null;
    formData.email = null;
    formData.phone = null;
  }

  toggleSearch() {
    getData(formData);
    setState(() {
      srchVisible = !srchVisible;
    });
  }

  getData(formData) {
    Query qry = authBloc.users;

    if (formData.name != null && formData.name.isNotEmpty) {
      qry = qry.where('name',
          isEqualTo: formData.name); // For example, to be adapted
    }
    if (formData.email != null && formData.email.isNotEmpty) {
      qry = qry.where('email',
          isEqualTo: formData.email); // For example, to be adapted
    }
    if (formData.phone != null && formData.phone.isNotEmpty) {
      qry = qry.where('phone',
          isEqualTo: formData.phone); // For example, to be adapted
    }
    return qry.limit(10).snapshots();
  }

  Future<void> _deleteUser(String docId) async {
    toggleSpinner();
    messageVisible = true;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to delete this record? Record #: $docId')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                users
                    .doc(docId)
                    .delete()
                    .then((res) =>
                        {showMessage(true, "success", "Record deleted.")})
                    .catchError((error) =>
                        {showMessage(true, "error", error.toString())});
                Navigator.of(context).pop();
                toggleSpinner();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                toggleSpinner();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return new Scaffold(
      appBar: AppBar(title: const Text(cAdmin)),
      drawer: Drawer(child: CustomAdminDrawer()),
      body: Center(
        child: Material(
          child: Container(
              margin: EdgeInsets.all(20.0),
              child: authBloc.isSignedIn()
                  ? settings(authBloc)
                  : loginPage(authBloc)),
        ),
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
    return ListView(
      children: [
        Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, color: Colors.grey),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Text("Manager Users", style: cHeaderDarkText),
                  SizedBox(
                    width: 30,
                    height: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.blueAccent),
                    onPressed: () {
                      toggleSearch();
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Container(
                  width: 400,
                  height: 600,
                  child: !srchVisible
                      ? showUsers(context, authBloc)
                      : showSearch(context, authBloc)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              CustomSpinner(toggleSpinner: spinnerVisible),
              CustomMessage(
                  toggleMessage: messageVisible,
                  toggleMessageType: messageType,
                  toggleMessageTxt: messageTxt),
            ],
          ),
        ),
      ],
    );
  }

  Widget showUsers(BuildContext context, AuthBloc authBloc) {
    return StreamBuilder<QuerySnapshot>(
        // stream: users.snapshots(),
        stream: getData(formData),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // return Text('Something went wrong');
            return showMessage(true, "error", "An un-known error has occured.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['name']),
                subtitle: Column(
                  children: [
                    const Divider(
                      color: Colors.black,
                      height: 5,
                      thickness: 2,
                      // indent: 20,
                      // endIndent: 0,
                    ),
                    Row(
                      children: [
                        new Text("email: "),
                        new Text(document.data()['email'])
                      ],
                    ),
                    Row(
                      children: [
                        new Text(" Phone: "),
                        new Text(document.data()['phone']),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text(" Author: "),
                            new Text(document.data()['author']),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text(" Role: "),
                            new Text(document.data()['role'] == null
                                ? "None assigned"
                                : document.data()['role']),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/adminedit',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
                        ),
                        SizedBox(width: 3, height: 50),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteUser(document.data()['author']);
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
        });
  }

  Widget showSearch(BuildContext context, AuthBloc authBloc) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Text("Search user", style: cHeaderDarkText),
                  SizedBox(
                    width: 30,
                    height: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.blueAccent),
                    onPressed: () {
                      toggleSearch();
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              srchForm(authBloc)
            ],
          ),
        ),
      ],
    );
  }

  Widget srchForm(AuthBloc authBloc) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                srchSubmitBtn(context, authBloc),
                SizedBox(
                  width: 30,
                  height: 20,
                ),
                srchClearBtn(context, authBloc),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget srchSubmitBtn(context, authBloc) {
    return ElevatedButton(
      child: Text('search'),
      // onPressed: _btnEnabled == true ? () => toggleSearch() : null,
      onPressed: () => toggleSearch(),
    );
  }

  Widget srchClearBtn(context, authBloc) {
    return ElevatedButton(
      child: Text('clear'),
      // onPressed: _btnEnabled == true ? () => toggleSearch() : null,
      onPressed: () => clearSearch(),
    );
  }
}
