import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/models/datamodel.dart';

class Appointments extends StatefulWidget {
  static const routeName = '/appointments';
  @override
  AppointmentsState createState() => AppointmentsState();
}

class AppointmentsState extends State<Appointments> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  String messageTxt = "";
  String messageType = "";
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

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
      appBar: AppBar(title: const Text(cAppointment)),
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: CustomAdminDrawer()),
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
              // Container(
              //   margin: EdgeInsets.only(top: 25.0),
              // ),
              // Container(margin: EdgeInsets.all(20.0), child: CustomAdminNav()),
              // : guestNav(context, authBloc)),
              Container(
                margin: EdgeInsets.only(top: 25.0),
              ),
              Text("Appointments", style: cHeaderDarkText),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon:
                        Icon(Icons.calendar_today_outlined, color: Colors.pink),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/appointments',
                      );
                    },
                  ),
                  Text(
                    "Schedule",
                    style: cBodyText,
                  ),
                ],
              ),
              Container(
                  width: 400,
                  height: 600,
                  child: showAppointments(context, authBloc)),
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

  Widget showAppointments(BuildContext context, AuthBloc authBloc) {
    return StreamBuilder<QuerySnapshot>(
        stream: appointments.snapshots(),
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
                title: new Text(document.data()['appointmentDate']),
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
                        new Text("Name: "),
                        new Text(document.data()['name']),
                        new Text(" Phone: "),
                        new Text(document.data()['phone']),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text(" Comments: "),
                            new Text(document.data()['comments']),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          child: Text('Vaccine'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/vaccine',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
                        ),
                        SizedBox(width: 3, height: 50),
                        ElevatedButton(
                          child: Text('OPD'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/opd',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
                        ),
                        SizedBox(width: 3, height: 50),
                        ElevatedButton(
                          child: Text('IPD'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/ipd',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          child: Text('LAB'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/lab',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
                        ),
                        SizedBox(width: 3, height: 50),
                        ElevatedButton(
                          child: Text('Rx'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/rx',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
                        ),
                        SizedBox(width: 3, height: 50),
                        ElevatedButton(
                          child: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/rx',
                                arguments:
                                    ScreenArguments(document.data()['author']));
                          },
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
