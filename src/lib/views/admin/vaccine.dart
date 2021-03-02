import 'dart:async';
import 'dart:convert';
import 'package:src/blocs/auth/auth.bloc.dart';
import 'package:src/shared/custom_components.dart';
import 'package:src/shared/custom_style.dart';
import 'package:src/models/datamodel.dart';
import 'package:src/blocs/validators.dart';
import 'package:flutter/material.dart';

class Vaccine extends StatefulWidget {
  static const routeName = '/vaccine';
  @override
  VaccineState createState() => VaccineState();
}
// TODO: pending newer appointment date for patient after vaccine data is saved.

class VaccineState extends State<Vaccine> {
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool isAdmin = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  VaccineDataModel formData = VaccineDataModel();
  bool _btnEnabled = false;
  TextEditingController _appointmentDate = new TextEditingController();
  TextEditingController _newAppointmentDate = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _idType = new TextEditingController();
  TextEditingController _id = new TextEditingController();
  TextEditingController _sir = new TextEditingController();
  TextEditingController _occupation = new TextEditingController();
  TextEditingController _warrior = new TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _gender = new TextEditingController();
  TextEditingController _medicalHistory = new TextEditingController();
  TextEditingController _race = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _zipcode = new TextEditingController();
  TextEditingController _citiesTravelled = new TextEditingController();
  TextEditingController _siblings = new TextEditingController();
  TextEditingController _familyMembers = new TextEditingController();
  TextEditingController _socialActiveness = new TextEditingController();
  TextEditingController _declineParticipation = new TextEditingController();
  String idTypeValue = 'DrivingLicense';
  String sirTypeValue = 'SIR_Type';
  String warriorTypeValue = 'CORONA_Warrior';
  String genderTypeValue = 'Others';

  @override
  void initState() {
    AuthBloc authBloc = AuthBloc();
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    _nameController.dispose();
    _idType.dispose();
    _id.dispose();
    _sir.dispose();
    _occupation.dispose();
    _warrior.dispose();
    _dob.dispose();
    _gender.dispose();
    _medicalHistory.dispose();
    _race.dispose();
    _address.dispose();
    _zipcode.dispose();
    _citiesTravelled.dispose();
    _siblings.dispose();
    _familyMembers.dispose();
    _socialActiveness.dispose();
    _declineParticipation.dispose();
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

  fetchData(patientID) async {
    toggleSpinner();
    messageVisible = true;
    if (authBloc.isSignedIn()) {
      if (authBloc.isSignedIn()) {
        await authBloc
            .getPatientData(patientID)
            .then((res) => setState(() => updateFormData(
                PersonDataModel.fromJson(res.data()), patientID)))
            .catchError((error) => showMessage(
                true, "error", "Patient has not updated his personal data."));
      }
    } else {
      showMessage(true, "error", "An un-known error has occured.");
    }
    toggleSpinner();
  }

  // getData(AuthBloc authBloc) async {
  //   toggleSpinner();
  //   messageVisible = true;
  //   if (authBloc.isSignedIn()) {
  //     if (authBloc.isSignedIn()) {
  //       await authBloc
  //           .getUserData("person")
  //           .then((res) => setState(
  //               () => updateFormData(PersonDataModel.fromJson(res.data()))))
  //           .catchError((error) => showMessage(
  //               true, "error", "User information is not available."));
  //     }
  //   } else {
  //     showMessage(true, "error", "An un-known error has occured.");
  //   }
  //   toggleSpinner();
  // }

  updateFormData(PersonDataModel data, patientID) {
    // print(data.name);
    // print(data.author);
    // formData.appointmentDate = "";
    // formData.newAppointmentDate = "";
    if (data.name == null)
      setState(() {
        showMessage(
            true, "error", "Patient has not updated his personal data.");
      });
    formData.name = data.name;
    formData.idType = data.idType;
    formData.id = data.id;
    formData.sir = data.sir;
    formData.occupation = data.occupation;
    formData.warrior = data
        .warrior; // na, military, healthcareworker, police, firefighter, frontline worker, senior, educator
    formData.dob = data.dob;
    formData.gender = data.gender; // m, f, o
    formData.medicalHistory = data.medicalHistory;
    formData.race = data.race; // n, s, e , w, decline
    formData.address = data.address;
    formData.zipcode = data.zipcode;
    formData.citiesTravelled = data.citiesTravelled;
    formData.siblings = data.siblings;
    formData.familyMembers = data.familyMembers;
    formData.socialActiveness = data.socialActiveness;
    formData.declineParticipation = data.declineParticipation;
    formData.author = patientID;
    // y, n

    // if (formData.appointmentDate != null)
    //   _appointmentDate.text = formData.appointmentDate;
    // if (formData.newAppointmentDate != null)
    //   _newAppointmentDate.text = formData.newAppointmentDate;
    _nameController.text = formData.name;
    if (formData.idType != null) idTypeValue = formData.idType;
    _id.text = formData.id;
    if (formData.sir != null) sirTypeValue = formData.sir;
    _occupation.text = formData.occupation;
    // _warrior.text = formData.warrior;
    if (formData.warrior != null) warriorTypeValue = formData.warrior;
    _dob.text = formData.dob;
    // _gender.text = formData.gender;
    if (formData.gender != null) genderTypeValue = formData.gender;
    _medicalHistory.text = formData.medicalHistory;
    _race.text = formData.race;
    _address.text = formData.address;
    _zipcode.text = formData.zipcode;
    _citiesTravelled.text = formData.citiesTravelled;
    _siblings.text = formData.siblings;
    _familyMembers.text = formData.familyMembers;
    _socialActiveness.text = formData.socialActiveness;
    _declineParticipation.text = formData.declineParticipation;
  }

  Future setData(AuthBloc authBloc) async {
    toggleSpinner();
    messageVisible = true;
    await authBloc
        .setUserData('vaccine', formData)
        .then((res) => {
              showMessage(true, "success",
                  "Data is saved. Patient is given a new Appointment Date after 30 days. Patient will receive a reminder for next appointment. Please click on appointments to see other patient now.")
            })
        .catchError((error) => {showMessage(true, "error", error.toString())});
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    AuthBloc authBloc = AuthBloc();
    return Material(
        child: Container(
            margin: EdgeInsets.all(20.0),
            child: authBloc.isSignedIn()
                ? settings(authBloc, args.patientID)
                : loginPage(authBloc)));
  }

  Widget loginPage(AuthBloc authBloc) {
    return Column(
      children: [
        SizedBox(width: 10, height: 50),
        RaisedButton(
          child: Text('Click here to go to Login page'),
          color: Colors.blue,
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

  Widget settings(AuthBloc authBloc, String patientID) {
    return ListView(
      children: [
        Form(
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
                    margin: EdgeInsets.all(20.0), child: CustomAdminNav()),
                // : guestNav(context, authBloc)),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                ),
                Text("Update Vaccine Data", style: cHeaderDarkText),
                SizedBox(width: 10, height: 50),
                RaisedButton(
                  child: Text('get Patient Data'),
                  color: Colors.blue,
                  onPressed: () {
                    fetchData(patientID);
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.healing_sharp, color: Colors.pink),
                        onPressed: null),
                    Text(
                      "Vaccination",
                      style: cBodyText,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                CustomSpinner(toggleSpinner: spinnerVisible),
                CustomMessage(
                    toggleMessage: messageVisible,
                    toggleMessageType: messageType,
                    toggleMessageTxt: messageTxt),
                signinSubmitBtn(context, authBloc),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: Text('Scan ID'),
                      color: Colors.grey,
                      onPressed: null,
                    ),
                    SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    RaisedButton(
                      child: Text('Scan Picture'),
                      color: Colors.grey,
                      onPressed: null,
                    )
                  ],
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: _appointmentDate,
                    decoration: InputDecoration(
                      labelText: "Vaccination Date",
                      hintText: "Ex. Vaccination datetime",
                    ),
                    validator: evalName,
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      _appointmentDate.text = date.toIso8601String();
                      formData.appointmentDate = date.toIso8601String();
                    },
                  ),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: _newAppointmentDate,
                    decoration: InputDecoration(
                      labelText: "Next Appointment Date",
                      hintText: "Next Vaccination datetime",
                    ),
                    validator: evalName,
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().add(new Duration(days: 30)),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      _newAppointmentDate.text = date.toIso8601String();
                      formData.newAppointmentDate = date.toIso8601String();
                    },
                  ),
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
                DropdownButton<String>(
                  value: idTypeValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  hint: Text("ID Type"),
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    formData.idType = newValue;
                    setState(() {
                      idTypeValue = newValue;
                    });
                  },
                  items: <String>[
                    'DrivingLicense',
                    'AadharCard',
                    'PAN',
                    'SSN',
                    'StudentID',
                    'BirthCard'
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
                      controller: _id,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.id = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person_add_alt_1_sharp),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'SSN Card #',
                        labelText: 'ID # *',
                        // errorText: snapshot.error,
                      ),
                    )),
                DropdownButton<String>(
                  value: sirTypeValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  hint: Text("SIR Type"),
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    formData.sir = newValue;
                    setState(() {
                      sirTypeValue = newValue;
                    });
                  },
                  items: <String>[
                    'SIR_Type',
                    'S_uspected',
                    'I_nfected',
                    'R_ecovered',
                    'NONE'
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
                      controller: _occupation,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.occupation = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.desktop_windows),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Occupation',
                        labelText: 'occupation *',
                        // errorText: snapshot.error,
                      ),
                    )),
                DropdownButton<String>(
                  value: warriorTypeValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  hint: Text("Warrior Type"),
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    formData.warrior = newValue;
                    setState(() {
                      warriorTypeValue = newValue;
                    });
                  },
                  items: <String>[
                    'CORONA_Warrior',
                    'Healthcare worker',
                    'FrontLine worker',
                    'Law Enforcement',
                    'Senior'
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
                      controller: _dob,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.dob = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'DOB',
                        labelText: 'date of birth *',
                        // errorText: snapshot.error,
                      ),
                    )),
                DropdownButton<String>(
                  value: genderTypeValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  hint: Text("Gender Type"),
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    formData.gender = newValue;
                    setState(() {
                      genderTypeValue = newValue;
                    });
                  },
                  items: <String>[
                    'Others',
                    'Male',
                    'Female',
                    'Decline to answer'
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
                      controller: _medicalHistory,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.medicalHistory = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.healing),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Past Medical History',
                        labelText: 'past medical history *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _race,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.race = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.recent_actors),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Ethnicity',
                        labelText: 'ethnicity *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _address,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.address = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.home),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Address',
                        labelText: 'address *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _zipcode,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.zipcode = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.gps_off),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Zip Code',
                        labelText: 'zipcode *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _citiesTravelled,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.citiesTravelled = value,
                      validator: evalName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Cities Traveled',
                        labelText: '4 week travel history *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _siblings,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.siblings = value,
                      validator: evalChar,
                      decoration: InputDecoration(
                        icon: Icon(Icons.family_restroom_rounded),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Siblings',
                        labelText: 'Siblings *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _familyMembers,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.familyMembers = value,
                      validator: evalChar,
                      decoration: InputDecoration(
                        icon: Icon(Icons.family_restroom_rounded),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Family members',
                        labelText: 'family members in house *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _socialActiveness,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) => formData.socialActiveness = value,
                      validator: evalChar,
                      decoration: InputDecoration(
                        icon: Icon(Icons.gps_fixed),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Social Activities',
                        labelText: 'past social gatherings *',
                        // errorText: snapshot.error,
                      ),
                    )),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: _declineParticipation,
                      cursorColor: Colors.blueAccent,
                      maxLength: 50,
                      onChanged: (value) =>
                          formData.declineParticipation = value,
                      validator: evalChar,
                      decoration: InputDecoration(
                        icon: Icon(Icons.surround_sound),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        hintText: 'Do you want to participate in Research',
                        labelText: 'Do you want to participate in Research *',
                        // errorText: snapshot.error,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget signinSubmitBtn(context, authBloc) {
    return RaisedButton(
      child: Text('Save'),
      color: Colors.blue,
      onPressed: _btnEnabled == true ? () => setData(authBloc) : null,
    );
  }
}
