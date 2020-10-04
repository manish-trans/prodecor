import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prodecor/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lead.dart';
import 'callbacklead.dart';

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Dashboard',
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String url =
      "https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/leads_status.php?";

//  var users = new List<Cateogary>();
  List<dynamic> data = new List();

  _getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String uservalue = prefs.getString('userid');
    String password=prefs.getString('password');
    print("uservalue"+uservalue);

    Map map = new Map<String, dynamic>();

    map['_deviceid'] = 'TestDeviceId';
    map['_userid'] = uservalue;
    map['_password'] = password;

    http.Response response = await http.post(
      url,
      body: map,
    );
    setState(() {
      Map<String, dynamic> map1 = json.decode(response.body);
      data = map1["category"];
      print(data[0]["count"]);
    });

    //users = json.decode(response.body);
    //print("cat"+users.toList().toString());
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: Colors.orangeAccent,
          leading: Icon(Icons.menu),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.notifications, size: 26.0),
              ),
            ),
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.push(context,  MaterialPageRoute(builder: (context) => LogIn()));
              },
              child: Text("Logout"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
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

                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[

                      Card(
                        child: Row(

                          children: <Widget>[

                            Container(
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    data[index]["display_name"],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )),
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "(" + data[index]["count"] + ")",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )),
                            Container(
                              child: Icon(Icons.arrow_right),
                              margin: EdgeInsets.only(left: 5.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              onTap: () {
               // print("Tapped on container");
              /*  if( data[index]["display_name"].toString().compareTo("positive")==0)
                Navigator.push(context,  MaterialPageRoute(builder: (context) => Lead()));
                else*/
                String name=data[index]["name"].toString();
                print("name"+name);
                if(name.compareTo("Positive")==0)
                Navigator.push(context,  MaterialPageRoute(builder: (context) => Lead()));
                else
               Navigator.push(context,  MaterialPageRoute(builder: (context) => CallbackLeadPage(name:name)));

              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
