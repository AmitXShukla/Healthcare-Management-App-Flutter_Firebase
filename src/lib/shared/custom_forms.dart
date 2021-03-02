import 'package:flutter/material.dart';

class CustomFormRoundedTxt extends StatelessWidget {
  final Stream streamBloc;
  final controllerName;
  final bool obscureTxt;
  final onChangeTxt;
  final iconTxt;
  final hintTxt;
  final labelTxt;
  const CustomFormRoundedTxt(
      {Key key,
      this.streamBloc,
      this.controllerName,
      this.obscureTxt,
      this.onChangeTxt,
      this.iconTxt,
      this.hintTxt,
      this.labelTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamBloc,
        builder: (context, snapshot) {
          return Container(
              width: 300.0,
              margin: EdgeInsets.only(top: 25.0),
              child: TextField(
                controller: controllerName,
                cursorColor: Colors.blueAccent,
                maxLength: 50,
                obscureText: obscureTxt,
                onChanged: onChangeTxt,
                decoration: InputDecoration(
                  icon: iconTxt,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  hintText: hintTxt,
                  labelText: labelTxt,
                  errorText: snapshot.error,
                ),
              ));
        });
  }
}

class CustomFormTxt extends StatelessWidget {
  final Stream streamBloc;
  final int boxLength;
  final obscureTxt;
  final onChangeTxt;
  final iconTxt;
  final hintTxt;
  final labelTxt;
  const CustomFormTxt(
      {Key key,
      this.streamBloc,
      this.boxLength,
      this.obscureTxt,
      this.onChangeTxt,
      this.iconTxt,
      this.hintTxt,
      this.labelTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamBloc,
        builder: (context, snapshot) {
          return Container(
              width: 300.0,
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                cursorColor: Colors.blueAccent,
                maxLength: boxLength,
                obscureText: obscureTxt,
                onChanged: onChangeTxt,
                decoration: InputDecoration(
                  icon: iconTxt,
                  hintText: hintTxt,
                  labelText: labelTxt,
                  errorText: snapshot.error,
                ),
              ));
        });
  }
}

class CustomFormDataTxt extends StatelessWidget {
  final String dbData;
  final bool isEnabled;
  final Stream streamBloc;
  final int boxLength;
  final obscureTxt;
  final onChangeTxt;
  final iconTxt;
  final hintTxt;
  final labelTxt;
  const CustomFormDataTxt(
      {Key key,
      this.dbData,
      this.isEnabled,
      this.streamBloc,
      this.boxLength,
      this.obscureTxt,
      this.onChangeTxt,
      this.iconTxt,
      this.hintTxt,
      this.labelTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtData = TextEditingController();
    txtData.text = dbData;
    return StreamBuilder(
        stream: streamBloc,
        builder: (context, snapshot) {
          return Container(
              width: 300.0,
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                controller: txtData,
                cursorColor: Colors.blueAccent,
                enabled: isEnabled,
                maxLength: boxLength,
                obscureText: obscureTxt,
                onChanged: onChangeTxt,
                decoration: InputDecoration(
                  icon: iconTxt,
                  hintText: hintTxt,
                  labelText: labelTxt,
                  errorText: snapshot.error,
                ),
              ));
        });
  }
}

class CustomFormData1Txt extends StatelessWidget {
  final bool isEnabled;
  final Stream streamBloc;
  final int boxLength;
  final obscureTxt;
  final onChangeTxt;
  final iconTxt;
  final hintTxt;
  final labelTxt;
  const CustomFormData1Txt(
      {Key key,
      this.isEnabled,
      this.streamBloc,
      this.boxLength,
      this.obscureTxt,
      this.onChangeTxt,
      this.iconTxt,
      this.hintTxt,
      this.labelTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamBloc,
        builder: (context, snapshot) {
          return Container(
              width: 300.0,
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                cursorColor: Colors.blueAccent,
                enabled: isEnabled,
                maxLength: boxLength,
                obscureText: obscureTxt,
                onChanged: onChangeTxt,
                decoration: InputDecoration(
                  icon: iconTxt,
                  hintText: hintTxt,
                  labelText: labelTxt,
                  errorText: snapshot.error,
                ),
              ));
        });
  }
}

class CustomInput extends StatelessWidget {
  final String dbData;
  final int boxLength;
  final bool isEnabled;
  final obscureTxt;
  final iconTxt;
  final hintTxt;
  final labelTxt;
  const CustomInput(
      {Key key,
      this.dbData,
      this.boxLength,
      this.isEnabled,
      this.obscureTxt,
      this.iconTxt,
      this.hintTxt,
      this.labelTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txt = TextEditingController();
    txt.text = dbData;
    return Container(
      width: 300.0,
      margin: EdgeInsets.only(top: 5.0),
      child: TextFormField(
        controller: txt,
        enabled: isEnabled,
        cursorColor: Colors.blueAccent,
        maxLength: boxLength,
        obscureText: obscureTxt,
        decoration: InputDecoration(
          icon: iconTxt,
          hintText: hintTxt,
          labelText: labelTxt,
        ),
      ),
    );
  }
}
