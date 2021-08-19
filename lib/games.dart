import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

class Games extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Registration';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US')], //, Locale('pt', 'BR')],
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  List materialList = [], partyList = [], siteList = [];

  String materialNoController = "", partyNoController = "", siteController = "";
  late TextEditingController loadingController,
      unloadingController,
      vehicalNoController,
      QuantityController,
      wbcNoController,
      dcNoController,
      landtController,
      roalityController,
      roalityQtyController,
      driverNameController,
      remarkController;

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';
    loadingController = TextEditingController(text: "");
    unloadingController = TextEditingController(text: "");
    vehicalNoController = TextEditingController(text: "");
    QuantityController = TextEditingController(text: "");
    wbcNoController = TextEditingController(text: "");
    dcNoController = TextEditingController(text: "");
    landtController = TextEditingController(text: "");
    roalityController = TextEditingController(text: "");
    roalityQtyController = TextEditingController(text: "");
    driverNameController = TextEditingController(text: "");
    remarkController = TextEditingController(text: "");

    http.post(Uri.parse(Constant.SERVER_URL + 'materialList')).then((response) {
      setState(() {
        materialList = json.decode(response.body);
      });
    });

    http.post(Uri.parse(Constant.SERVER_URL + 'partyList')).then((response) {
      setState(() {
        partyList = json.decode(response.body);
      });
    });

    http.post(Uri.parse(Constant.SERVER_URL + 'siteList')).then((response) {
      setState(() {
        siteList = json.decode(response.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        DateTimePicker(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter your Loading Date and Time',
            labelText: 'Loading Date and Time',
          ),
          type: DateTimePickerType.dateTime,
          dateMask: Constant.DATE_TIME_FORMAT,
          controller: loadingController,
          //initialValue: _initialValue,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          //icon: Icon(Icons.event),
          dateLabelText: 'Date Time',
          use24HourFormat: false,
          locale: Locale('en', 'US'),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.car_rental),
            hintText: 'Enter Vehical Number',
            labelText: 'Vehical Number',
          ),
          controller: vehicalNoController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Vehical Number';
            }
            return null;
          },
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person_add),
            hintText: 'Select Party',
            labelText: 'Party',
          ),
          items: partyList.map((obj) {
            return new DropdownMenuItem<String>(
              value: obj,
              child: new Text(obj, style: new TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              partyNoController = newValue!;
            });
          },
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person_add),
            hintText: 'Select Material',
            labelText: 'Material',
          ),
          items: materialList.map((obj) {
            return new DropdownMenuItem<String>(
              value: obj,
              child: new Text(obj, style: new TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              materialNoController = newValue!;
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter Quantity',
            labelText: 'Quantity',
          ),
          controller: QuantityController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Quantity';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter WBC No',
            labelText: 'WBC No',
          ),
          controller: wbcNoController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter WBC No';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter D C No',
            labelText: 'D C No',
          ),
          controller: dcNoController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter D C No';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter L&T Entry No',
            labelText: 'L&T Entry No',
          ),
          controller: landtController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter L&T Entry No';
            }
            return null;
          },
        ),
        DateTimePicker(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter your Un-Loading Date and Time',
            labelText: 'Un-Loading Date and Time',
          ),
          type: DateTimePickerType.dateTime,
          dateMask: Constant.DATE_TIME_FORMAT,
          controller: unloadingController,
          //initialValue: _initialValue,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          //icon: Icon(Icons.event),
          dateLabelText: 'Un-Loading Date Time',
          use24HourFormat: false,
          locale: Locale('en', 'US'),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter Royalty',
            labelText: 'Royalty',
          ),
          controller: roalityController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Royalty';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter Royalty Quantity',
            labelText: 'Royalty Quantity',
          ),
          controller: roalityQtyController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Royalty Quantity';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter Driver Name',
            labelText: 'Driver Name',
          ),
          controller: driverNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Driver Name';
            }
            return null;
          },
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person_add),
            hintText: 'Select Site',
            labelText: 'Site',
          ),
          items: siteList.map((obj) {
            return new DropdownMenuItem<String>(
              value: obj,
              child: new Text(obj, style: new TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              siteController = newValue!;
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter Remarks',
            labelText: 'remarks',
          ),
          controller: remarkController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Remarks';
            }
            return null;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('Submit'),
        )
      ],
    );
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> productMap = {
        "loadingTime": loadingController.text,
        "unLoadingTime": unloadingController.text,
        "vehicalNo": vehicalNoController.text,
        "partyNo": partyNoController,
        "qtyNo": QuantityController.text,
        "wbcNo": wbcNoController.text,
        "dcNo": dcNoController.text,
        "landtNo": landtController.text,
        "roality": roalityController.text,
        "roalityQty": roalityQtyController.text,
        "driverName": driverNameController.text,
        "site": siteController,
        "remark": remarkController.text,
        "material": materialNoController
      };

      http
          .post(Uri.parse(Constant.SERVER_URL + 'vehicalEntry'),
              body: jsonEncode(productMap))
          .then((response) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text(response.body),
              );
            });
      });
    }
  }
}
