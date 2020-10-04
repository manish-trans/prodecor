import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prodecor/dashboard.dart';
import 'userleaddetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Lead());
}

class Lead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lead',
      home: LeadPage(),
    );
  }
}

class LeadPage extends StatefulWidget {
  @override
  _LeadPageState createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> with WidgetsBindingObserver {
  String url =
      "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_positive.php?";
  bool viewVisible = false;

  List<dynamic> data = new List();
  List<dynamic> data_join=new List();
  List<dynamic> detail1 = new List();
  Map<String, dynamic> map1;
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
  _getLead() async {
    Map map = new Map<String, dynamic>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String uservalue = prefs.getString('userid');
    String password = prefs.getString('password');
    map['_deviceid'] = 'TestDeviceId';
    map['_userid'] = uservalue;
    map['_password'] = password;
    map['_offset'] = '10';

    http.Response response = await http.post(
      url,
      body: map,
    );
    setState(() {
      map1 = json.decode(response.body);
      String s=map1["success"];
      if(s.compareTo("1")==0) {
        data = map1["leads"];
        data_join = map1["joining_status"];
      }

      /* LeadDetails leadDetails1= LeadDetails.fromJson(data[0].);
detail1.add(leadDetails1);*/
      //  print("detailll"+json.decode(detail[0])["lead_label"].toString());
      //print("detttt"+data[0]["lead_details"][0]["lead_label"].toString());
    });
  }

  initState() {
    super.initState();
    _getLead();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
              title: Text('Business Leads'),
              backgroundColor: Colors.orangeAccent,
              leading: new IconButton(
                icon: new Icon(Icons.keyboard_backspace),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashboardPage()));
                },
              )),
          body: ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              /*return ListTile(
               title: new Center(child:new Text(data[index]["display_name"] ,)),
              );*/
              return InkWell(
                child: Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      /*mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,*/

                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    data[index]["lead_title"],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              Column(
                                children: List.generate(
                                    data[index]["lead_details"].length,
                                    (index1) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(top: 2.0, left: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisSize:
                                              MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width:200,
                                                child: Text(
                                                  data[index]["lead_details"]
                                                      [index1]["lead_label"],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),

                                            ),
                                            Expanded(

                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  data[index]["lead_details"]
                                                      [index1]["lead_value"],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width) * 0.8,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.orange,
                                  child: Text(
                                    data[index]["callback_btn"],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  onPressed: () {
                                    customDialog(
                                        map1["joining_status_label"],
                                        data_join,
                                        map1["joining_remarks_label"],"",map1["joining_id_label"]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                onTap: () {
                  // print("Tapped on container");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Lead()));
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ));
  }

  void customDialog(String joining_label, List<dynamic> joinin_arr, String joining_remark, String _valdisp,String joining_id_label) {
    String _status_id="";

    TextEditingController remarksController = new TextEditingController();
    TextEditingController distController=new TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 350,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  /* mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,*/
                  children: [
                    InkWell(
                      child: Container(
                          alignment: Alignment.topRight,
                          child:Image.asset(
                            'assets/images/cross.webp',
                            width: 20.0,
                            height: 20.0,
                          )
                      ),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    ),

                    Container(
                        margin: EdgeInsets.only(
                            left: 10.0),

                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            joining_label,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )),

                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child:DropdownButtonFormField(
                        value: data_join[0],
                        items: data_join.map((accountType) {
                          return DropdownMenuItem(
                            value: accountType,
                            child: Text(accountType['status_text'],style: TextStyle(fontSize: 12),),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            var _currentAccountType = val;
                            _status_id=_currentAccountType['status_id'].toString();
                            if(_status_id.compareTo("2")==0)
                              {
                               showWidget();
                              }
                            else
                              hideWidget();
                            print("statusval"+_currentAccountType['status_id'].toString());
                          });
                        },
                      ),
                     ),
              Visibility(
                visible: viewVisible,
                    child:Container(
                      margin: EdgeInsets.only(top: 10,bottom: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          joining_id_label,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
              ),
                  Visibility(
                    visible: viewVisible,
                    child:   Container(
                      height:30,
                      child: TextField(
                        controller: distController,
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            // filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            fillColor: Colors.white70),
                      ),
                    ),

                  ),



                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          joining_remark,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                  TextField(
                      controller: remarksController,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                         // filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70),
                    ),

                        RaisedButton(
                          onPressed: () {
                          /*  print("statusiddd"+_status_id);
                            print("remarsss"+remarksController.text);
                            print("leadid"+data[0]['lead_id']);
                            print("distid"+distController.text);*/
                            callSubmitdisp(_status_id,remarksController.text,data[0]['lead_id'],distController.text);
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          child: Container(
                            decoration: const BoxDecoration(
                                /*gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF0D47A1),
                                    Color(0xFF1976D2),
                                    Color(0xFF42A5F5),
                                  ],
                                ),*/
                                color: Colors.orange,
                               // borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: const Text(
                                'Submit',
                                style: TextStyle(fontSize: 14)
                            ),
                          ),
                        )

                  ],
                ),
              ),
            ),
          );
        });
  }

  void callSubmitdisp(String status_id, String remarkstxt, String leadid, String distidtxt)async {
    String url =
        "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_positive_disposition.php?";

      Map map = new Map<String, dynamic>();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String uservalue = prefs.getString('userid');
      String password = prefs.getString('password');
      map['_deviceid'] = 'TestDeviceId';
      map['_userid'] = uservalue;
      map['_password'] = password;
      map['_leadid'] = leadid;
      map['_status']=status_id;
      map['_remarks']=remarkstxt;
      map['_joinid']=distidtxt;

      http.Response response = await http.post(
        url,
        body: map,
      );
      setState(() {
        map1 = json.decode(response.body);
        String s=map1["success"];
        print("succcccess"+s);
        if(s.compareTo("1")==0) {
          Navigator.of(context).pop();
        }

        /* LeadDetails leadDetails1= LeadDetails.fromJson(data[0].);
detail1.add(leadDetails1);*/
        //  print("detailll"+json.decode(detail[0])["lead_label"].toString());
        //print("detttt"+data[0]["lead_details"][0]["lead_label"].toString());
      });

  }
}

Future<bool> _onBackPressed() {
  return new Future.value(true);
}
