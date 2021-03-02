import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:src/blocs/validators.dart';

class Centre extends StatefulWidget {
  static const routeName = '/centre';
  @override
  CentreState createState() => CentreState();
}

class CentreState extends State<Centre> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //       child: Container(margin: EdgeInsets.all(20.0), child: settings()));
  // }
  @override
  // Widget build(BuildContext context) {
  //   return Material(
  //       child: Container(margin: EdgeInsets.all(20.0), child: settings()));
  // }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: const Text(cSCM)),
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: CustomAdminDrawer()),
      body: Center(
        child: Material(
          child: Container(margin: EdgeInsets.all(20.0), child: settings()),
        ),
      ),
    );
  }

  Widget settings() {
    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          // Container(margin: EdgeInsets.all(20.0), child: CustomAdminNav()),
          CustomSCMNav(),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cached, color: Colors.purple),
              Text("Setup Centre", style: cHeaderDarkText),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 300.0,
                  margin: EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    // controller: _nameController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.name,
                    maxLength: 50,
                    obscureText: false,
                    // onChanged: (value) => formData.name = value,
                    validator: evalName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Distrib Centre ID',
                      labelText: 'Dist ID *',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 5.0),
              ),
              DropdownButton<String>(
                // value: idTypeValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                hint: Text("Vendor Type"),
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  // formData.idType = newValue;
                  setState(() {
                    // idTypeValue = newValue;
                  });
                },
                items: <String>[
                  'Warehouse',
                  'Manufacturer',
                  'Dealer',
                  'Vendor',
                  'Direct Purchase',
                  'Factory'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                  width: 300.0,
                  margin: EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    // controller: _id,
                    cursorColor: Colors.blueAccent,
                    maxLength: 50,
                    // onChanged: (value) => formData.id = value,
                    validator: evalName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_add_alt_1_sharp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Address #',
                      labelText: 'Address *',
                      // errorText: snapshot.error,
                    ),
                  )),
              DropdownButton<String>(
                // value: sirTypeValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                hint: Text("Vendor Name"),
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  // formData.sir = newValue;
                  setState(() {
                    // sirTypeValue = newValue;
                  });
                },
                items: <String>[
                  'ABC Corp.',
                  'XYZ Inc',
                  'Delta Corp.',
                  'Alpha LLC',
                  'Gamma LLP'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200.0,
                      margin: EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        // controller: _nameController,
                        cursorColor: Colors.blueAccent,
                        keyboardType: TextInputType.name,
                        maxLength: 50,
                        obscureText: false,
                        // onChanged: (value) => formData.name = value,
                        validator: evalName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          hintText: 'Ph#',
                          labelText: 'Ph. *',
                          // errorText: snapshot.error,
                        ),
                      )),
                  Container(
                      width: 100.0,
                      margin: EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        // controller: _nameController,
                        cursorColor: Colors.blueAccent,
                        keyboardType: TextInputType.name,
                        maxLength: 50,
                        obscureText: false,
                        // onChanged: (value) => formData.name = value,
                        validator: evalName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          hintText: 'code',
                          labelText: 'code *',
                          // errorText: snapshot.error,
                        ),
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
