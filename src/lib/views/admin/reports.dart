import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Reports extends StatefulWidget {
  static const routeName = '/reports';
  @override
  ReportsState createState() => ReportsState();
}

class ReportsState extends State<Reports> {
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This page is in active development.'),
                SizedBox(
                  width: 5,
                  height: 5,
                ),
                Text(
                    'Features -> all custom reports must have active filters, material design, paginations, sorting and run time parameters. Reports should also have a downloadable option.'),
                Text(
                    'Features -> all Reports must have a downloadable option.'),
                SizedBox(
                  width: 5,
                  height: 5,
                ),
                Text(
                    'If you would like to contribute, please clone GitHub repo, PRs are welcome.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: const Text(cReports)),
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
      child: Column(
        children: <Widget>[
          // Container(
          //   margin: EdgeInsets.only(top: 25.0),
          // ),
          // Container(margin: EdgeInsets.all(20.0), child: CustomAdminNav()),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          Row(
            children: [
              Icon(Icons.receipt, color: Colors.grey),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text("Admin Reports", style: cHeaderDarkText),
              SizedBox(
                width: 20,
                height: 20,
              ),
              IconButton(
                  icon: Icon(Icons.info, color: Colors.blue),
                  onPressed: _showMyDialog),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Divider(
                color: Colors.black,
                height: 5,
                thickness: 2,
                // indent: 20,
                // endIndent: 0,
              ),
              Text(
                "Appointments",
                style: cHeaderDarkText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Appointments by date",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Doses by date",
                style: cBodyText,
              ),
              const Divider(
                color: Colors.black,
                height: 5,
                thickness: 2,
                // indent: 20,
                // endIndent: 0,
              ),
              Text(
                "Patient Reports",
                style: cHeaderDarkText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Patient Vaccine records",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "OPD/IPD records",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Pharmacy records",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Pathology Lab records",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              const Divider(
                color: Colors.black,
                height: 5,
                thickness: 2,
                // indent: 20,
                // endIndent: 0,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              GestureDetector(
                child: Text(
                  "COVID Vaccine Distribution management app",
                  style: cNavText,
                ),
                onTap: () => setState(() {
                  _launched = _launchInBrowser(
                      'https://www.youtube.com/watch?v=MkV413X2Kmw&list=PLp0TENYyY8lHL-G7jGbhpJBhVb2UdTOhQ&index=1&t=698s');
                }),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              GestureDetector(
                child: Text(
                  "Patient Contacts Tracing app",
                  style: cNavText,
                ),
                onTap: () => setState(() {
                  _launched =
                      _launchInBrowser('https://getcovidvaccine.web.app/');
                }),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Vaccine Inventory Orders",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Vaccine Qty on Hand",
                style: cBodyText,
              ),
              const Divider(
                color: Colors.black,
                height: 5,
                thickness: 2,
                // indent: 20,
                // endIndent: 0,
              ),
              Text(
                "Supply chain reports",
                style: cHeaderDarkText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "On Hand Inventory Qty by warehouse",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "On Hand Inventory Qty by distribution center",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Vendor PO status by date",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "MSR (Material Service Request) status by date",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Received inventory by date",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Returned inventory by date",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                "Discarded inventory by date",
                style: cBodyText,
              ),
              SizedBox(
                width: 10,
                height: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
