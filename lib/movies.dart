import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Vehical Entry List';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
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

class MyCustomFormState extends State<MyCustomForm> {
  List vehicalList = [];
  List<String> columnList = [
    "Sr No.",
    "Loading Time",
    "Vehical No",
    "Party Name",
    "Material",
    "QTY",
    "WBC No",
    "D C No",
    "L/T Entry No",
    "Un-Loading Time",
    "Roality",
    "Roality Qty",
    "Driver Name",
    "Site Name",
    "Remark"
  ];
  List<DataColumn> columnHeader = [];
  List<DataRow> rowList = [];

  @override
  void initState() {
    super.initState();

    http
        .post(Uri.parse(Constant.SERVER_URL + 'vehicalEntryList'))
        .then((response) {
      setState(() {
        vehicalList = json.decode(response.body);
        int count = 0;
        for (Map map in vehicalList) {
          count++;
          rowList.add(DataRow(
            cells: <DataCell>[
              DataCell(Text(count.toString())),
              DataCell(Text(map['loadingTime'])),
              DataCell(Text(map['vehicalNo'])),
              DataCell(Text(map['partyNo'])),
              DataCell(Text(map['material'])),
              DataCell(Text(map['qtyNo'])),
              DataCell(Text(map['wbcNo'])),
              DataCell(Text(map['dcNo'])),
              DataCell(Text(map['landtNo'])),
              DataCell(Text(map['unLoadingTime'])),
              DataCell(Text(map['roality'])),
              DataCell(Text(map['roalityQty'])),
              DataCell(Text(map['driverName'])),
              DataCell(Text(map['site'])),
              DataCell(Text(map['remark'])),
            ],
          ));
        }
      });
    });

    for (String column in columnList) {
      columnHeader.add(DataColumn(
        label: Text(
          column,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: 0,
                    columns: columnHeader,
                    rows: rowList,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
