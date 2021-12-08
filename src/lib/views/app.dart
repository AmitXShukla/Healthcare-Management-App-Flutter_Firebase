// import 'dart:html';

import 'package:src/views/aboutus.dart';
// import 'package:src/views/mdnews.dart';
// import 'package:src/views/businessnews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:src/shared/custom_style.dart';
import 'package:src/views/auth/settings.dart';
import 'package:src/views/auth/signup.dart';
import 'package:src/views/auth/login.dart';
import 'package:src/views/admin/reports.dart';
import 'package:src/views/admin/patient.dart';
import 'package:src/views/admin/appointments.dart';
import 'package:src/views/admin/vaccine.dart';
import 'package:src/views/admin/opd.dart';
import 'package:src/views/admin/messages.dart';
import 'package:src/views/admin/rx.dart';
import 'package:src/views/admin/lab.dart';
import 'package:src/views/admin/admin.dart';
import 'package:src/views/admin/adminedit.dart';
import 'package:src/views/user/person.dart';
import 'package:src/views/user/records.dart';
import 'package:src/views/user/appointment.dart';
import 'package:src/views/user/loom.dart';
import 'package:src/views/user/loomdocs.dart';
import 'package:src/views/scm/purchase.dart';
import 'package:src/views/scm/msr.dart';
import 'package:src/views/scm/center.dart';
import 'package:src/views/scm/vendor.dart';
import 'package:src/views/scm/warehouse.dart';
import 'package:src/views/scm/item.dart';

//import 'package:gallery/l10n/gallery_localizations.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: cAppTitle,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF666666, {
          50: Color.fromRGBO(4, 131, 184, .1),
          100: Color.fromRGBO(4, 131, 184, .2),
          200: Color.fromRGBO(4, 131, 184, .3),
          300: Color.fromRGBO(4, 131, 184, .4),
          400: Color.fromRGBO(4, 131, 184, .5),
          500: Color.fromRGBO(4, 131, 184, .6),
          600: Color.fromRGBO(4, 131, 184, .7),
          700: Color.fromRGBO(4, 131, 184, .8),
          800: Color.fromRGBO(4, 131, 184, .9),
          900: Color.fromRGBO(4, 131, 184, 1),
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: CupertinoTabBarMain(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/': (context) => ERPHomePage(), - can not set if home: ERPHomePage() is setup, only works with initiated route
        AboutUs.routeName: (context) => AboutUs(),
        LogIn.routeName: (context) => LogIn(),
        Settings.routeName: (context) => Settings(),
        SignUp.routeName: (context) => SignUp(),
        Reports.routeName: (context) => Reports(),
        Patient.routeName: (context) => Patient(),
        Person.routeName: (context) => Person(),
        Records.routeName: (context) => Records(),
        Appointment.routeName: (context) => Appointment(),
        Loom.routeName: (context) => Loom(),
        LoomDocs.routeName: (context) => LoomDocs(),
        Appointments.routeName: (context) => Appointments(),
        Vaccine.routeName: (context) => Vaccine(),
        OPD.routeName: (context) => OPD(),
        LAB.routeName: (context) => LAB(),
        Rx.routeName: (context) => Rx(),
        Messages.routeName: (context) => Messages(),
        Purchase.routeName: (context) => Purchase(),
        MSR.routeName: (context) => MSR(),
        Centre.routeName: (context) => Centre(),
        Vendor.routeName: (context) => Vendor(),
        Warehouse.routeName: (context) => Warehouse(),
        Item.routeName: (context) => Item(),
        Admin.routeName: (context) => Admin(),
        AdminEdit.routeName: (context) => AdminEdit(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
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
          title: const Text(cAppTitle)),
      body: ListView(
        children: [
          Center(
            child: LogIn(),
          )
        ],
      ),
    );
  }
}
