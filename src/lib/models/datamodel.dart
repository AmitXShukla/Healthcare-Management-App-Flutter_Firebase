class LoginDataModel {
  String email;
  String password;
  LoginDataModel({this.email, this.password});
}

class SettingsDataModel {
  String name;
  String email;
  String phone;
  String role;
  String author;
  SettingsDataModel(
      {this.name, this.email, this.phone, this.role, this.author});
  factory SettingsDataModel.fromJson(Map<String, dynamic> json) {
    return SettingsDataModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      author: json['author'],
    );
  }
}

class AppointmentDataModel {
  String appointmentDate;
  String name;
  String phone;
  String comments;
  String author;
  String status;
  AppointmentDataModel(
      {this.appointmentDate,
      this.name,
      this.phone,
      this.comments,
      this.author,
      this.status});
  factory AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDataModel(
      appointmentDate: json['appointmentDate'],
      name: json['name'],
      phone: json['phone'],
      comments: json['comments'],
      author: json['author'],
      status: json['status'],
    );
  }
}

class VisitDataModel {
  String visitDate;
  String visitorName;
  String visitorID;
  String author;
  VisitDataModel(
      {this.visitDate, this.visitorID, this.visitorName, this.author});
  factory VisitDataModel.fromJson(Map<String, dynamic> json) {
    return VisitDataModel(
      visitDate: json['visitDate'],
      visitorName: json['visitorName'],
      visitorID: json['visitorID'],
      author: json['author'],
    );
  }
}

class MessagesDataModel {
  String patientId;
  String messagesDate;
  String from;
  String status;
  String message;
  bool readReceipt;
  String author;
  MessagesDataModel(
      {this.patientId,
      this.messagesDate,
      this.from,
      this.status,
      this.message,
      this.readReceipt,
      this.author});
  factory MessagesDataModel.fromJson(Map<String, dynamic> json) {
    return MessagesDataModel(
      patientId: json['patientId'],
      messagesDate: json['messagesDate'],
      from: json['from'],
      status: json['status'],
      message: json['message'],
      readReceipt: json['readReceipt'],
      author: json['author'],
    );
  }
}

class OPDDataModel {
  String patientId;
  String opdDate;
  String symptoms;
  String diagnosis;
  String treatment;
  String rx;
  String lab;
  String comments;
  String author;
  OPDDataModel(
      {this.patientId,
      this.opdDate,
      this.symptoms,
      this.diagnosis,
      this.treatment,
      this.rx,
      this.lab,
      this.comments,
      this.author});
  factory OPDDataModel.fromJson(Map<String, dynamic> json) {
    return OPDDataModel(
      patientId: json['patientId'],
      opdDate: json['opdDate'],
      symptoms: json['symptoms'],
      diagnosis: json['diagnosis'],
      treatment: json['treatment'],
      rx: json['rx'],
      lab: json['lab'],
      comments: json['comments'],
      author: json['author'],
    );
  }
}

class LabDataModel {
  String patientId;
  String labDate;
  String from;
  String status;
  String lab;
  String results;
  String descr;
  String comments;
  String author;
  LabDataModel(
      {this.patientId,
      this.labDate,
      this.from,
      this.status,
      this.lab,
      this.results,
      this.descr,
      this.comments,
      this.author});
  factory LabDataModel.fromJson(Map<String, dynamic> json) {
    return LabDataModel(
      patientId: json['patientId'],
      labDate: json['labDate'],
      from: json['from'],
      status: json['status'],
      lab: json['lab'],
      results: json['results'],
      descr: json['descr'],
      comments: json['comments'],
      author: json['author'],
    );
  }
}

class RxDataModel {
  String patientId;
  String rxDate;
  String from;
  String status;
  String rx;
  String results;
  String descr;
  String comments;
  String author;
  RxDataModel(
      {this.patientId,
      this.rxDate,
      this.from,
      this.status,
      this.rx,
      this.results,
      this.descr,
      this.comments,
      this.author});
  factory RxDataModel.fromJson(Map<String, dynamic> json) {
    return RxDataModel(
      patientId: json['patientId'],
      rxDate: json['rxDate'],
      from: json['from'],
      status: json['status'],
      rx: json['rx'],
      results: json['results'],
      descr: json['descr'],
      comments: json['comments'],
      author: json['author'],
    );
  }
}

class PersonDataModel {
  String name;
  String idType;
  String id;
  String sir;
  String occupation;
  String
      warrior; // na, military, healthcareworker, police, firefighter, frontline worker, senior, educator
  String dob;
  String gender; // m, f, o
  String medicalHistory;
  String race; // n, s, e , w, decline
  String address;
  String zipcode;
  String citiesTravelled;
  String siblings;
  String familyMembers;
  String socialActiveness;
  String declineParticipation; // y, n
  String author;
  PersonDataModel(
      {this.name,
      this.idType,
      this.id,
      this.sir,
      this.occupation,
      this.warrior,
      this.dob,
      this.gender,
      this.medicalHistory,
      this.race,
      this.address,
      this.zipcode,
      this.citiesTravelled,
      this.siblings,
      this.familyMembers,
      this.socialActiveness,
      this.declineParticipation,
      this.author});
  factory PersonDataModel.fromJson(Map<String, dynamic> json) {
    return PersonDataModel(
      name: json['name'],
      idType: json['idType'],
      id: json['id'],
      sir: json['sir'],
      occupation: json['occupation'],
      warrior: json['warrior'],
      dob: json['dob'],
      gender: json['gender'],
      medicalHistory: json['medicalHistory'],
      race: json['race'],
      address: json['address'],
      zipcode: json['zipcode'],
      citiesTravelled: json['citiesTravelled'],
      siblings: json['siblings'],
      familyMembers: json['familyMembers'],
      socialActiveness: json['socialActiveness'],
      declineParticipation: json['declineParticipation'],
      author: json['author'],
    );
  }
  factory PersonDataModel.toJson(Map<String, dynamic> json) {
    return PersonDataModel(name: json['name']);
  }
}

class VaccineDataModel {
  String patientId;
  String appointmentDate;
  String newAppointmentDate;
  String author;
  VaccineDataModel(
      {this.patientId,
      this.appointmentDate,
      this.newAppointmentDate,
      this.author});
  factory VaccineDataModel.fromJson(Map<String, dynamic> json) {
    return VaccineDataModel(
        patientId: json['patientId'],
        appointmentDate: json['appointmentDate'],
        newAppointmentDate: json['newAppointmentDate'],
        author: json['author']);
  }
  factory VaccineDataModel.toJson(Map<String, dynamic> json) {
    return VaccineDataModel(patientId: json['patientId']);
  }
}

class ScreenArguments {
  final String patientID;

  ScreenArguments(this.patientID);
}

class ScreenPatientArguments {
  final String reportType;
  final String patientID;

  ScreenPatientArguments(this.reportType, this.patientID);
}

class DBDataModel {
  final int numRows;
  final bool error;
  final String message;
  final List<dynamic> data;
  const DBDataModel({this.numRows, this.error, this.message, this.data});
  factory DBDataModel.fromJson(Map<String, dynamic> json) {
    return DBDataModel(
        numRows: json['numRows'],
        error: json['error'],
        message: json['message'],
        data: json['data']
            .map((value) => new UserModel.fromJson(value))
            .toList());
  }
}

class AddressDataModel {
  final int numRows;
  final bool error;
  final String message;
  final List<dynamic> data;
  const AddressDataModel({this.numRows, this.error, this.message, this.data});
  factory AddressDataModel.fromJson(Map<String, dynamic> json) {
    return AddressDataModel(
        numRows: json['numRows'],
        error: json['error'],
        message: json['message'],
        data: json['data']
            .map((value) => new AddressBookModel.fromJson(value))
            .toList());
  }
}

class UserModel {
  final String userid;
  final String name;
  final String jwttoken;
  final String createdAt;
  final String updatedAt;
  final String role;

  const UserModel(
      {this.userid,
      this.name,
      this.jwttoken,
      this.createdAt,
      this.updatedAt,
      this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userid: json['userid'],
        name: json['name'],
        jwttoken: json['jwttoken'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        role: json['role']);
  }
  factory UserModel.toJson(Map<String, dynamic> json) {
    return UserModel(
      userid: json['userid'],
      name: json['name'],
      jwttoken: json['jwttoken'],
    );
  }
}

class AddressBookModel {
  final int addressid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String address;
  final String city;
  final String country;
  final String zipCode;
  final String emailid1;
  final String emailid2;
  final String phone1;
  final String phone2;
  final String createdAt;
  final String updatedAt;

  const AddressBookModel(
      {this.addressid,
      this.firstName,
      this.middleName,
      this.lastName,
      this.address,
      this.city,
      this.country,
      this.zipCode,
      this.emailid1,
      this.emailid2,
      this.phone1,
      this.phone2,
      this.createdAt,
      this.updatedAt});

  factory AddressBookModel.fromJson(Map<String, dynamic> json) {
    return AddressBookModel(
        addressid: json['addressid'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        address: json['address'],
        city: json['city'],
        country: json['country'],
        zipCode: json['zipCode'],
        emailid1: json['emailid1'],
        emailid2: json['emailid2'],
        phone1: json['phone1'],
        phone2: json['phone2'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
  factory AddressBookModel.toJson(Map<String, dynamic> json) {
    return AddressBookModel(
        addressid: json['addressid'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        address: json['address'],
        city: json['city'],
        country: json['country'],
        zipCode: json['zipCode'],
        emailid1: json['emailid1'],
        emailid2: json['emailid2'],
        phone1: json['phone1'],
        phone2: json['phone2'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
