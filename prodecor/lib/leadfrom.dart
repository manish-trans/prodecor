import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:prodecor/dashboard.dart';
import 'leadsdetailmodel.dart';
import 'callbacklead.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(LeadFrom());
}

class LeadFrom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(title: "Lead Detail", home: LeadFromPage());
  }
}

class LeadFromPage extends StatefulWidget {
  LeadFromPage({this.lead_id});

  final String lead_id;

  @override
  _LeadFromPageState createState() => _LeadFromPageState(lead_id: lead_id);
}

class _LeadFromPageState extends State<LeadFromPage>
    with SingleTickerProviderStateMixin {
  final String lead_id;
  bool isLoading = true;

  String url =
      "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_detail.php?";
  bool viewVisible = false;

  List<dynamic> data = new List();
  List<leaddetailsmodel> list = new List();
  List<LeadData> list_data = new List();
  leaddetailsmodel leads;

  _LeadFromPageState({this.lead_id});

  String _valdisp, call_back_alert_show_txt = "";
  int call_back_alert_show, count = 0;
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController sumCtl = TextEditingController();

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  Future _getUsers() async {
    Map map = new Map<String, dynamic>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String uservalue = prefs.getString('userid');
    String password = prefs.getString('password');
    map['_deviceid'] = 'TestDeviceId';
    map['_userid'] = uservalue;
    map['_password'] = password;

    map['_leadid'] = lead_id;

    http.Response response = await http.post(
      url,
      body: map,
    );
    setState(() {
      Map<String, dynamic> map1 = json.decode(response.body);

      String s = map1["success"];
      if (s.compareTo("1") == 0) {
        data = map1["lead_status"];
        call_back_alert_show_txt = map1["call_back_alert_text"];
        call_back_alert_show = map1['call_back_alert_show'];
        //List<dynamic> data = map1["lead_data"];
        leaddetailsmodel leadss = new leaddetailsmodel.fromJson(map1);
        list.add(leadss);
      }
    });

    //users = json.decode(response.body);
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2020),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MaterialApp(
            home: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text('Business Leads'),
            backgroundColor: Colors.orangeAccent,
            leading: new IconButton(
              icon: new Icon(Icons.keyboard_backspace),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CallbackLeadPage()));
              },
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.notifications, size: 26.0),
                ),
              )
            ],
          ),
          body: list.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: Container(
                          child: ListView.separated(
                            itemCount: list[0].leadData.leadDetails.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 200,
                                          child: Container(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              list[0]
                                                  .leadData
                                                  .leadDetails[index]
                                                  .leadLabel,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            list[0]
                                                .leadData
                                                .leadDetails[index]
                                                .leadValue,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          alignment: Alignment.topLeft,
                          child: Text("Submit Disposition:")),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton(
                            isExpanded: true,
                            isDense: true,
                            value: _valdisp,
                            hint: Text("Select Disposition:"),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.brown,
                            ),
                            iconSize: 40,
                            underline: Container(
                              height: 1,
                              color: Colors.transparent,
                            ),
                            items: data.map((item) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                value: item['name'],
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valdisp = value;
                                if (_valdisp.compareTo("Callback") == 0) {
                                  // ll_time_date.setVisibility(View.VISIBLE);
                                   showWidget();
                                  if (call_back_alert_show == 1) {
                                    AlertDailogForError(
                                        call_back_alert_show_txt);
                                  } else {}
                                } else if (_valdisp.compareTo("Ringing") == 0) {
                                  AlertDailogForError(
                                      "Do you want to callback?");
                                } else if (_valdisp
                                        .compareTo("Unable to contact") ==
                                    0) {
                                   showWidget();
                                  AlertDailogForError(
                                      "Do you want to callback?");
                                } else {
                                  hideWidget();
                                }
                              });
                            },
                            // hint:Text(data[0]["name"]) ,
                          )),
                      Visibility(
                          /*maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,*/
                          visible: viewVisible,
                          child: Row(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: TextFormField(
                                    controller: dateCtl,
                                    decoration: InputDecoration(
                                        labelText: "Callback Date",
                                        suffixIcon: Icon(Icons.calendar_today)),
                                    onTap: () async {
                                      DateTime date = DateTime(1900);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());

                                      date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(date);

                                      dateCtl.text = formattedDate;
                                    },
                                  )),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.only(left: 20.0),
                                child: TextFormField(
                                  controller: timeCtl,
                                  decoration: InputDecoration(
                                      labelText: "Callback Time",
                                      suffixIcon: Icon(Icons.access_time)),
                                  onTap: () async {
                                    TimeOfDay selectedTime24Hour =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          TimeOfDay(hour: 10, minute: 47),
                                      builder:
                                          (BuildContext context, Widget child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child,
                                        );
                                      },
                                    );
                                    String formatTimeOfDay(TimeOfDay tod) {
                                      final now = new DateTime.now();
                                      final dt = DateTime(now.year, now.month,
                                          now.day, tod.hour, tod.minute);
                                      final format =
                                          DateFormat.jm(); //"6:00 AM"
                                      return format.format(dt);
                                    }

                                    String formattedDate =
                                        formatTimeOfDay(selectedTime24Hour);

                                    timeCtl.text = formattedDate;
                                  },
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextField(
                          controller: sumCtl,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Summary",
                          ),
                          enabled: true,
                        ),
                      ),
                      RaisedButton(
                          color: Colors.orangeAccent,
                          child: Text(
                            'Submit Disposition',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => callSubmitApi(timeCtl, dateCtl,
                              lead_id, sumCtl, _valdisp, count.toString()))
                    ],
                  ),
                )
              : Center(child: const Text('No items')),
        )));
  }

  void AlertDailogForError(String call_back_alert_show_txt) {
    showDialog(
        context: context,
        builder: (_) {
          return Container(
            child: AlertDialog(
              title: Text(call_back_alert_show_txt,
                  style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
              actions: [
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    setState(() {
                      count = 0;
                    });

                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
                FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      setState(() {
                        count = 1;
                      });
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    })
              ],
            ),
          );
        }).then((exit) {
      if (exit == null) return;
      if (exit) {
        //user press yes
      } else {
        //user press no
      }
    });
  }

  callSubmitApi(
      TextEditingController timeCtl,
      TextEditingController dateCtl,
      String lead_id,
      TextEditingController sumCtl,
      String lead_status_value,
      String count) async {
    String url =
        "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_disposition.php?";
    /* final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    void _showScaffold(String message) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.orangeAccent,
      ));

    }*/
    Map map = new Map<String, dynamic>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String uservalue = prefs.getString('userid');
    String password = prefs.getString('password');

    map['_deviceid'] = 'TestDeviceId';
    map['_userid'] = uservalue;
    map['_password'] = password;
    map['_leadid'] = lead_id;
    map['_status'] = lead_status_value;
    map['_remarks'] = sumCtl.text;
    map['_callback_date'] = dateCtl.text.toString();
    map['_callback_time'] = timeCtl.text.toString();
    map['_callback_attempt'] = count;
    http.Response response = await http.post(
      url,
      body: map,
    );
    Map<String, dynamic> map1 = json.decode(response.body);
    print("dispooos" + map1.toString());
    if (map1["success"].toString().compareTo("1") == 0) {
      //_showScaffold(map1["response_msg"]);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
                child: AlertDialog(
              content: new Text(map1["response_msg"]),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                )
              ],
            ));
            // return
          });
    }
  }
}
