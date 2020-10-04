import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prodecor/dashboard.dart';
import 'userleaddetails.dart';
import 'leadfrom.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(CallbackLead());
}

class CallbackLead extends StatelessWidget {
  final String text;

  CallbackLead({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leadeeee',
      home: CallbackLeadPage(),
    );
  }
}

class CallbackLeadPage extends StatefulWidget {
  CallbackLeadPage({this.name});

  final String name;

  @override
  _CallbackLeadPageState createState() => _CallbackLeadPageState(name: name);
}

class _CallbackLeadPageState extends State<CallbackLeadPage>
    with WidgetsBindingObserver {
  final String name;
  bool viewVisible = true;
  String lead_id = "";
  String url =
      "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_new.php?";
  String otherurl =
      "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_read.php?";

  List<dynamic> data = new List();
  List<dynamic> detail = new List();
  List<dynamic> detail1 = new List();
  String yestxt = "",
      notext = "",
      popuptxt = "",
      mobilenotxt = "",
      call_done = "0",
      call_back_alert_show_txt = "";

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

  _CallbackLeadPageState({this.name});

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
    map['_status'] = name;

    /* if(name.compareTo("positive")==0)
      showWidget();
    else if(name.compareTo("Pending")==0)
      showWidget();
    else if(name.compareTo("Callback")==0)
      showWidget();
    else if(name.compareTo("Unable to contact")==0)
      showWidget();
    else if(name.compareTo("Ringing")==0)
      showWidget();
      else
        hideWidget();*/

    http.Response response = await http.post(
      url,
      body: map,
    );
    setState(() {
      Map<String, dynamic> map1 = json.decode(response.body);
      data = map1["leads"];

      yestxt = map1["leads_popup_yes"].toString();
      notext = map1["leads_popup_no"].toString();
      popuptxt = map1["leads_popup_text"].toString();

      print("yestxt" + yestxt);

      if (((data[0]["lead_read_flag"].toString()).compareTo("1") == 0) &&
          ((data[0]["lead_read_can_submit"].toString())).compareTo("1") == 0)
        showWidget();
      else if (((data[0]["lead_read_flag"].toString()).compareTo("0") == 0) &&
          ((data[0]["lead_read_can_submit"].toString())).compareTo("0") == 0)
        showWidget();
      else
        hideWidget();

      /* LeadDetails leadDetails1= LeadDetails.fromJson(data[0].);
detail1.add(leadDetails1);*/
      //  print("detailll"+json.decode(detail[0])["lead_label"].toString());
      //print("detttt"+data[0]["lead_details"][0]["lead_label"].toString());
    });
  }

  _leadread(String leadid, String mobilenotxt) async {
    Map map = new Map<String, dynamic>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String uservalue = prefs.getString('userid');
    String password = prefs.getString('password');
    map['_deviceid'] = 'TestDeviceId';
    map['_userid'] = uservalue;
    map['_password'] = password;
    map['_leadid'] = leadid;
    print("leaddd" + leadid);

    http.Response response = await http.post(
      otherurl,
      body: map,
    );
    setState(() {
      Map<String, dynamic> map1 = json.decode(response.body);
      String s = map1["success"];
      print("detailllll" + s);
      if (s.compareTo("1") == 0) {
        UrlLauncher.launch("tel:" + mobilenotxt);
        call_done = "1";
      } else {
        showDialog(
            context: context,
            child: new AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(map1["response_msg"]),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                            textColor: Colors.white,
                            color: Colors.orange,
                            child: Text('ok'),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              //  Navigator.push(context, MaterialPageRoute(builder: (context) => LeadFromPage(lead_id: lead_id,)));
                            }),
                      ])
                ],
              ),
            ));
      }
    });
    /* await showDialog(
      //Your Dialog Code
    ).then((val){
      Navigator.pop(context);
    });*/
  }

  initState() {
    //  WidgetsBinding.instance.addObserver(this);

    super.initState();
    _getLead();

    // _leadread("","");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //  setState(() { _notification = state; });
    if (state == AppLifecycleState.resumed) {
      print("stateresummed" + state.toString());

      // Navigator.push(context, MaterialPageRoute(builder: (context) => LeadFromPage(lead_id: lead_id,)));

    }
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
            ),
          ),
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    data[index]["lead_title"],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              Column(
                                children: List.generate(
                                    data[index]["lead_details"].length,
                                    (index1) {
                                  return Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        new Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  width: (MediaQuery.of(context)
                                                          .size
                                                          .width) *
                                                      0.5,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      data[index]
                                                              ["lead_details"][
                                                          index1]["lead_label"],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    data[index]["lead_details"]
                                                        [index1]["lead_value"],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              ),
                              Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: viewVisible,
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width) *
                                        0.8,
                                    child: RaisedButton(
                                      textColor: Colors.white,
                                      color: Colors.orange,
                                      child: Text(
                                        data[index]["callback_btn"],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onPressed: () {
                                        if (((data[index]["lead_read_can_submit"]
                                                        .toString())
                                                    .compareTo("0") ==
                                                0) &&
                                            ((data[index]["lead_read_can_submit"]
                                                        .toString()))
                                                    .compareTo("0") ==
                                                0)
                                          showLeadDialog(
                                              yestxt,
                                              notext,
                                              popuptxt,
                                              data[index]["lead_mobile"],
                                              data[index]["lead_id"]);
                                        if (((data[index]["lead_read_can_submit"]
                                                        .toString())
                                                    .compareTo("1") ==
                                                0) &&
                                            ((data[index]["lead_read_can_submit"]
                                                        .toString()))
                                                    .compareTo("1") ==
                                                0)
                                        //showLeadDialog(yestxt,notext,popuptxt,data[index]["lead_mobile"],data[index]["lead_id"]);
                                        {
                                          String lead_idd =
                                              data[index]["lead_id"].toString();
                                          print("lead_id" + lead_idd);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LeadFromPage(
                                                          // data[index]["lead_id"]
                                                          lead_id: lead_idd)));
                                        } else
                                        // openNewpage();
                                        {
                                          /* String lead_idd=data[index]["lead_id"].toString();
                                      print("nameeee"+lead_id);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LeadFromPage(lead_id:lead_idd)));*/

                                        }
                                      },
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    )),
                onTap: () {
                  // print("Tapped on container");
                  //   Navigator.push(context,  MaterialPageRoute(builder: (context) => Lead()));
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ));
  }

  void showLeadDialog(String yes, String no, String popuptxt,
      String mobilenotxt, String leadid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  /* mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,*/
                  children: [
                    Container(
                        margin: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Businesss Lead T &amp; C",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Text(
                      popuptxt,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        color: Colors.orange,
                        //onPressed: () => UrlLauncher.launch("tel:"+mobilenotxt),
                        onPressed: () => callno(leadid, mobilenotxt),

                        child: Text(
                          (yes),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text(
                          (no),
                          style: TextStyle(color: Colors.white),
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

  callno(leadid, String mobilenotxt) {
    Navigator.of(context, rootNavigator: true).pop();

    _leadread(leadid, mobilenotxt);
//Navigator.of(context).pop();
  }

  Future<bool> _onBackPressed() {
    return new Future.value(true);
  }
}
