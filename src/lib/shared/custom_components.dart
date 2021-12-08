import 'package:src/shared/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSpinner extends StatelessWidget {
  final bool toggleSpinner;
  const CustomSpinner({Key key, this.toggleSpinner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: toggleSpinner ? CircularProgressIndicator() : null);
  }
}

class CustomMessage extends StatelessWidget {
  final bool toggleMessage;
  final toggleMessageType;
  final String toggleMessageTxt;
  const CustomMessage(
      {Key key,
      this.toggleMessage,
      this.toggleMessageType,
      this.toggleMessageTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: toggleMessage
            ? Text(toggleMessageTxt,
                style: toggleMessageType == cMessageType.error.toString()
                    ? cErrorText
                    : cSuccessText)
            : null);
  }
}

class CustomAdminNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon:
                  Icon(Icons.calendar_today_rounded, color: Colors.deepPurple),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/appointments',
                );
              },
            ),
            Text(
              "Appointments",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 7,
          height: 7,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.dashboard, color: Colors.deepOrange),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/purchase',
                );
              },
            ),
            Text(
              "SupplyChain",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 7,
          height: 7,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.receipt, color: Colors.grey),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/reports',
                );
              },
            ),
            Text(
              "Reports",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 40,
          height: 40,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: Colors.blue),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                );
              },
            ),
            Text(
              "Sign Out",
              style: cBodyText,
            ),
          ],
        ),
      ],
    );
  }
}

class CustomGuestNav extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon:
                  Icon(Icons.calendar_today_rounded, color: Colors.greenAccent),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/appointment',
                );
              },
            ),
            Text(
              "Appointment",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 7,
          height: 7,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.person, color: Colors.pink),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/person',
                );
              },
            ),
            Text(
              "Personal Data",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 7,
          height: 7,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.receipt, color: Colors.orange),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/records',
                );
              },
            ),
            Text(
              "Records",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 7,
          height: 7,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.wallet_travel, color: Colors.greenAccent),
                onPressed: () => _launched = _launchInBrowser(
                    'https://www.youtube.com/watch?v=MkV413X2Kmw&list=PLp0TENYyY8lHL-G7jGbhpJBhVb2UdTOhQ&index=1&t=698s')),
            Text(
              "ContactTracing",
              style: cBodyText,
            ),
          ],
        ),
        SizedBox(
          width: 40,
          height: 40,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: Colors.blue),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                );
              },
            ),
            Text(
              "Sign Out",
              style: cBodyText,
            ),
          ],
        ),
      ],
    );
  }
}

class CustomSCMNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.receipt, color: Colors.orange),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/purchase',
                );
              },
            ),
            Text(
              "PO",
              style: cBodyText,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.outlet_rounded, color: Colors.blueGrey),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/msr',
                );
              },
            ),
            Text(
              "MSR",
              style: cBodyText,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_bag_rounded, color: Colors.blueAccent),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/vendor',
                );
              },
            ),
            Text(
              "Vendor",
              style: cBodyText,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.wallet_travel, color: Colors.red),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/warehouse',
                );
              },
            ),
            Text(
              "Warehouse",
              style: cBodyText,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cached, color: Colors.purple),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/centre',
                );
              },
            ),
            Text(
              "Center",
              style: cBodyText,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.thermostat_outlined, color: Colors.deepOrange),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/item',
                );
              },
            ),
            Text(
              "Items",
              style: cBodyText,
            ),
          ],
        )
      ],
    );
  }
}

class CustomAdminDrawer extends StatelessWidget {
  //final bool toggleSpinner;
  const CustomAdminDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: cLabel,
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
      child: ListView(
// Important: Remove any padding from the ListView.
        padding: EdgeInsets.all(4.0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(cAppTitle),
            accountEmail: Text(cEmailID),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(cSampleImage),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading:
                Icon(Icons.calendar_today_rounded, color: Colors.deepPurple),
            title: Text(
              "Appointments",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointments',
              )
            },
            subtitle: Text('visitor appointments'),
          ),
          ListTile(
            leading: Icon(Icons.healing_rounded, color: Colors.green),
            title: Text(
              "Vaccination",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointments',
              )
            },
            subtitle: Text('Patient Vaccination'),
          ),
          ListTile(
            leading: Icon(Icons.view_headline, color: Colors.greenAccent),
            title: Text(
              "OPD/IPD",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointments',
              )
            },
            subtitle: Text('OPD/IPD'),
          ),
          ListTile(
            leading: Icon(Icons.hot_tub, color: Colors.red),
            title: Text(
              "Pharmacy",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointments',
              )
            },
            subtitle: Text('Pharmacy transactions'),
          ),
          ListTile(
            leading: Icon(Icons.sanitizer, color: Colors.orangeAccent),
            title: Text(
              "Lab Results",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointments',
              )
            },
            subtitle: Text('Patient Pathology Lab records'),
          ),
          ListTile(
            leading: Icon(Icons.sms, color: Colors.deepPurple),
            title: Text(
              "Messages",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointments',
              )
            },
            subtitle: Text('patient messages'),
          ),
          ListTile(
            leading: Icon(Icons.movie, color: Colors.green),
            title: Text(
              "Video",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/loomdocs',
              )
            },
            subtitle: Text('Video messages'),
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.deepOrange),
            title: Text(
              "Supply Chain",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/purchase',
              )
            },
            subtitle: Text('Manage supply chain'),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.receipt, color: Colors.lightBlue),
            title: Text(
              "Reports",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/reports',
              )
            },
            subtitle: Text('Manage Reports'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text(
              "Admin",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/admin',
              )
            },
          ),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/',
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomGuestDrawer extends StatelessWidget {
  //final bool toggleSpinner;
  const CustomGuestDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: cLabel,
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
      child: ListView(
// Important: Remove any padding from the ListView.
        padding: EdgeInsets.all(4.0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(cAppTitle),
            accountEmail: Text(cEmailID),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(cSampleImage),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading:
                Icon(Icons.calendar_today_rounded, color: Colors.deepPurple),
            title: Text(
              "Appointment",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/appointment',
              )
            },
            subtitle: Text('Upcoming appointments'),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.pink),
            title: Text(
              "Personal Data",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/person',
              )
            },
            subtitle: Text('Manage personal data & info.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
          ListTile(
            leading: Icon(Icons.receipt, color: Colors.orange),
            title: Text(
              "Records",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/records',
              )
            },
            subtitle: Text('OPD, IPD, Rx, LAB, COVID Vaccine records.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
          ListTile(
            leading: Icon(Icons.sms, color: Colors.deepPurple),
            title: Text(
              "Text",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/records',
              )
            },
            subtitle: Text('patient messages'),
          ),
          ListTile(
            leading: Icon(Icons.movie, color: Colors.green),
            title: Text(
              "Video",
              style: cNavText,
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(
                context,
                '/loomrecord',
              )
            },
            subtitle: Text('Video messages'),
          ),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/',
              );
            },
          ),
        ],
      ),
    );
  }
}
