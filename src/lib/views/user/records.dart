import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/models/datamodel.dart';

class Records extends StatefulWidget {
  static const routeName = '/records';
  @override
  RecordsState createState() => RecordsState();
}

class RecordsState extends State<Records> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool isAdmin = false;
  String messageTxt = "";
  String messageType = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference vaccine =
      FirebaseFirestore.instance.collection('vaccine');

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

  @override
  // Widget build(BuildContext context) {
  //   AuthBloc authBloc = AuthBloc();
  //   return Material(
  //       child: Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: authBloc.isSignedIn()
  //               ? settings(authBloc)
  //               : loginPage(authBloc)));
  // }
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return new Scaffold(
      appBar: AppBar(title: const Text(cPRecords)),
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: isAdmin
              // ? adminNav(context, authBloc)
              ? CustomAdminDrawer()
              : CustomGuestDrawer()),
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
          // color: Colors.blue,
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
              // Container(
              //   margin: EdgeInsets.only(top: 25.0),
              // ),
              // Container(margin: EdgeInsets.all(20.0), child: CustomGuestNav()),
              // : guestNav(context, authBloc)),
              Container(
                margin: EdgeInsets.only(top: 25.0),
              ),
              Text("Past Records", style: cHeaderDarkText),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.healing_rounded, color: Colors.pink),
                    onPressed: null,
                  ),
                  // Text(
                  //   "Schedule",
                  //   style: cBodyText,
                  // ),
                ],
              ),
              Container(
                  width: 400,
                  height: 600,
                  child: showRecords(context, authBloc)),
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

  Widget showRecords(BuildContext context, AuthBloc authBloc) {
    return StreamBuilder<QuerySnapshot>(
        stream: vaccine
            .where('author', isEqualTo: auth.currentUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('No records found.');
            // return showMessage(true, "error", "An un-known error has occured.");
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
                    Row(
                      children: [
                        new Text("Vaccination Date: "),
                        new Text(document.data()['appointmentDate']),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text("Next Appointment Date: "),
                            new Text(document.data()['newAppointmentDate']),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                // onTap: () {
                //   Navigator.pushReplacementNamed(context, '/vaccine',
                //       arguments: ScreenArguments(document.data()['author']));
                // },
              );
            }).toList(),
          );
        });
  }
}
