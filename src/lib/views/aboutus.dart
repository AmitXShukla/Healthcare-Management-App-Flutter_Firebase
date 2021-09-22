import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:src/shared/custom_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/aboutus';
  // This widget is the about us page of your application.

  AboutUs({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
    return new Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu_book),
            color: Colors.deepOrangeAccent,
            iconSize: 28.0,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          title: const Text(cAboutusTitle)),
      body: ListView(children: [
        Center(
          child: Card(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(
                    Icons.healing_outlined,
                    color: Colors.blue,
                  ),
                  title: Text(
                      'Complete Healthcare Records Management & Strategy App'),
                  subtitle: Text(
                      'This community healthcare management app (HMS hospital management app) built in Flutter Firebase App for iOS, Android, Web & Desktop. Complete Healthcare Hospital Management (Patient, OPD, IPD, Rx, Lab) in Flutter Firebase App for iOS, Android, Web & Desktop.\n\nThis project is a community version and is absolutely free for private use.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.album,
                    color: Colors.greenAccent,
                  ),
                  title: Text(
                      'Covid Vaccine Distribution Records Management & Strategy App'),
                  subtitle: Text(
                      'This community project is part of healthcare management app (HMS hospital management app) built in Flutter Firebase App for iOS, Android, Web & Desktop. Complete Healthcare Hospital Management (Patient, OPD, IPD, Rx, Lab) in Flutter Firebase App for iOS, Android, Web & Desktop. \n\nApp captures useful vaccine distribution record keepings functionality for local governing authorities, healthcare providers secured at their local cloud. \nDue to current Covid-19 situation, Patient\'s private data is not stored in app and location tracing functionality is not available with out government/authorities approval. \nThis app does not endorse, authorize, promote or market any vaccine brand.\nWe strongly recommend and encourage everyone to comply and follow you local government, healthcare providers guidelines setup for Pandemic Covid-19 vaccination.'),
                ),
                const SizedBox(width: 2),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.album, color: Colors.greenAccent),
                      onPressed: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://getcovidvaccine.web.app/');
                      }),
                    ),
                    Text(
                      "Vaccine Distribution App",
                      style: cBodyText,
                    ),
                  ],
                ),
                const ListTile(
                  leading: Icon(
                    Icons.wallet_giftcard,
                    color: Colors.deepOrange,
                  ),
                  title: Text(
                      'Pandemic Contact Tracing, Visitor Management, Mobile Assets/Employee Attendance App'),
                  subtitle: Text(
                      'An Electronic Visitor register App for storing Host & Guest Records, Picture Attendance with GPS Locations using user\'s mobile phone. \n\n click below icon to access this app.'),
                ),
                const SizedBox(width: 2),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.wallet_travel, color: Colors.deepOrange),
                      onPressed: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://www.youtube.com/watch?v=MkV413X2Kmw&list=PLp0TENYyY8lHL-G7jGbhpJBhVb2UdTOhQ&index=1&t=698s');
                      }),
                    ),
                    Text(
                      "Contact Tracing App",
                      style: cBodyText,
                    ),
                  ],
                ),
                const ListTile(
                  leading: Icon(
                    Icons.dashboard_customize,
                    color: Colors.blueGrey,
                  ),
                  title: Text(
                      'Store millions of records with lightening fast data retrieval'),
                  subtitle: Text(
                      'database storage is only restricted by usage/payment per use.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.mic,
                    color: Colors.red,
                  ),
                  title: Text('Hands free /voice activated typing'),
                  subtitle: Text(
                      'uses autofills and phone voice activated typing features.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.workspaces_filled,
                    color: Colors.pink,
                  ),
                  title:
                      Text('Dictionary based auto-completion/auto-sync (Pro)'),
                  subtitle: Text(
                      'Self learning (ML auto complete) data entry (Pro), automatic dictionary update for faster data typing. App autosave in dictionary, most used terms by healthcare providers like Rx name, Path Tests and Diagnosis.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.data_usage,
                    color: Colors.grey,
                  ),
                  title:
                      Text('GBs of pictures, documents, Lab reports, Receipts'),
                  subtitle: Text(
                      'database usage and size is subject to pay per use policy.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.sms,
                    color: Colors.greenAccent,
                  ),
                  title: Text(
                      'Social authentication, SMS, EMAIL, WhatsAPP API (Pro)'),
                  subtitle: Text(
                      'send email to info@elishcosulting.com for Pro version enquiries.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.lock_open,
                    color: Colors.blueGrey,
                  ),
                  title: Text('Role based user access'),
                  subtitle: Text(
                      'different role based app access, patient see only their records, Rx access pharmacy, Lab access Pathology records only.\n\n Doctor/healthcare provider can access every patient record, patient pharmacy and pathology results.'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  title: Text('AI Research script'),
                  subtitle: Text(
                      'Premium section of app, use participant data for an Artificial Intelligence research program, which may provide useful predictive analytics, insight to vaccine distribution strategy to local government healthcare workers to strategize vaccine distribution strategy, like, where when and who should get vaccines.\n\nFurther, this AI research uses public data features like Gender, age, location, travel, past medical history and SIR (suspected, infected, recovered) information. This AI strictly does not use any personal information like name, phone number, email or interest for any research or commercial purpose.'),
                ),
                Container(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.network(
                        "https://raw.githubusercontent.com/AmitXShukla/AmitXShukla.github.io/master/assets/icons/youtube.svg",
                        color: Colors.red,
                        semanticsLabel: 'YouTube',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://www.youtube.com/amitshukla_ai');
                      }),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: SvgPicture.network(
                        'https://raw.githubusercontent.com/AmitXShukla/AmitXShukla.github.io/master/assets/icons/twitter_2.svg',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () => setState(() {
                        _launched =
                            _launchInBrowser('https://twitter.com/ashuklax');
                      }),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: SvgPicture.network(
                        'https://raw.githubusercontent.com/AmitXShukla/AmitXShukla.github.io/master/assets/icons/github.svg',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () => setState(() {
                        _launched =
                            _launchInBrowser('https://amitxshukla.github.io');
                      }),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: SvgPicture.network(
                        'https://raw.githubusercontent.com/AmitXShukla/AmitXShukla.github.io/master/assets/icons/medium.svg',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () => setState(() {
                        _launched =
                            _launchInBrowser('https://medium.com/@Amit_Shukla');
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
