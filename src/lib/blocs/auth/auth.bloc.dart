import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/blocs/validators.dart';
import 'package:src/models/datamodel.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends Object with Validators {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference person = FirebaseFirestore.instance.collection('person');
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');
  CollectionReference vaccine =
      FirebaseFirestore.instance.collection('vaccine');

  isSignedIn() {
    return auth.currentUser != null;
  }

  signInWithEmail(LoginDataModel formData) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: formData.email, password: formData.password);
      return "";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  signUpWithEmail(LoginDataModel formData) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: formData.email, password: formData.password);
      return "";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  logout() {
    try {
      return FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future getData() async {
    if (auth.currentUser != null) {
      return users.doc(auth.currentUser.uid).get();
    }
    return false;
  }

  Future getUserData(String filter) async {
    if (auth.currentUser != null) {
      if (filter == "person") return person.doc(auth.currentUser.uid).get();
      if (filter == "appointments")
        return appointments.doc(auth.currentUser.uid).get();
    }
    return false;
  }

  Future getPatientData(String id) async {
    if (auth.currentUser != null) {
      return person.doc(id).get();
    }
    return false;
  }

  getAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('appointmentDate', isGreaterThan: DateTime.now())
        .where('appointmentDate',
            isLessThan: DateTime.now().add(new Duration(days: 2)))
        .snapshots();
  }

  Future<void> setUserData(String filter, formData) async {
    // print(PersonDataModel.toJson(formData));
    if (filter == "person")
      return person.doc(auth.currentUser.uid).set({
        'name': formData.name,
        'idType': formData.idType,
        'id': formData.id,
        'sir': formData.sir,
        'occupation': formData.occupation,
        'warrior': formData.warrior,
        'dob': formData.name,
        'gender': formData.gender,
        'medicalHistory': formData.medicalHistory,
        'race': formData.race,
        'address': formData.address,
        'zipcode': formData.zipcode,
        'citiesTravelled': formData.citiesTravelled,
        'siblings': formData.siblings,
        'familyMembers': formData.familyMembers,
        'socialActiveness': formData.socialActiveness,
        'declineParticipation': formData.declineParticipation,
        'author': auth.currentUser.uid // uid
      });
    if (filter == "appointments")
      return appointments.doc(auth.currentUser.uid).set({
        'appointmentDate': formData.appointmentDate,
        'name': formData.name,
        'phone': formData.phone,
        'comments': formData.comments,
        'author': auth.currentUser.uid // uid
      });
    if (filter == "vaccine")
      return vaccine.doc(formData.author).set({
        'appointmentDate': formData.appointmentDate,
        'newAppointmentDate': formData.newAppointmentDate,
        'name': formData.name,
        'idType': formData.idType,
        'id': formData.id,
        'sir': formData.sir,
        'occupation': formData.occupation,
        'warrior': formData.warrior,
        'dob': formData.name,
        'gender': formData.gender,
        'medicalHistory': formData.medicalHistory,
        'race': formData.race,
        'address': formData.address,
        'zipcode': formData.zipcode,
        'citiesTravelled': formData.citiesTravelled,
        'siblings': formData.siblings,
        'familyMembers': formData.familyMembers,
        'socialActiveness': formData.socialActiveness,
        'declineParticipation': formData.declineParticipation,
        'author': formData.author // uid
      });
  }

  Future<void> setData(SettingsDataModel formData) async {
    // Call the user's CollectionReference to add a new user
    return users.doc(auth.currentUser.uid).set({
      'name': formData.name, // John Doe
      'phone': formData.phone, // Phone
      'email': formData.email,
      'role': formData.role,
      'author': auth.currentUser.uid // uid
    });
  }

  // API: dispose/cancel observables/subscriptions
  dispose() {}
}

final authBloc = AuthBloc();
