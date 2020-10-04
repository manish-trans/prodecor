import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';
import 'dashboard.dart';

void main() {
  runApp(LogIn());
}

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: LogInPage(),

    );


  }



}
class LogInPage extends StatefulWidget
{
  @override
  _LogInPageState createState()=>_LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  bool _isLoading=false;

  @override
  void initState() {
    super.initState();
    _isLoading=true;
  }

  /* @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }*/
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.orangeAccent,
    ));

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/decor.webp'),
                    colorFilter: new ColorFilter.mode(
                        Colors.grey.withOpacity(0.2), BlendMode.dstATop),
                    fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomPadding: false,
                key: _scaffoldKey,
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              ),
                              Card(
                                elevation: 3.0,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text("welcome",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 15.0)),
                                    ),
                                    Container(
                                      child: Text(
                                          "Login to your account & access your profile",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0)),
                                      margin: EdgeInsets.all(10.0),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Email Id/Mobile No',
                                            contentPadding:
                                            const EdgeInsets.all(5.0)),
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        controller: _emailController,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0,top: 10.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          contentPadding:
                                          const EdgeInsets.all(5.0),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),),

                                        ),
                                        obscureText: true,
                                        controller: _passwordController,

                                      ),
                                    ),
                                    RaisedButton(
                                      onPressed:  _callApi,
                                      textColor: Colors.white,
                                      color: Colors.orange,
                                      child: const Text('LogIn'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding:
                                EdgeInsets.only(top: 10.0, bottom: 10.0),
                                margin: EdgeInsets.only(top: 15.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orange, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Forgot Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white70),
                                  maxLines: 3,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding:
                                EdgeInsets.only(top: 10.0, bottom: 10.0),
                                margin: EdgeInsets.only(top: 10.0),
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.orange, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "New User",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white70),
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ))
                    ]))));  }
 void _callApi() {
    String username = _emailController.text;
    String password =_passwordController.text;


    _makePostRequest(username,password);


  }
  _makePostRequest(String uname,String pass) async
 {
    print('login attemptrrr: $uname with $pass');

    String url="https://dsapi.mfadirect.com/_mfa_mem_srv_dapi_secure_24917/login.php?";
    Map map=new Map<String, dynamic>();

    map['_deviceid'] = 'TestDeviceId';
    map['_loginid'] = '$uname';
    map['_password'] = '$pass';

    http.Response response = await http.post(
      url,
      body: map,
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    var user=User.fromJson(responseJson);
    String success='${user.success}';
    print('${user.success}');
    if(success.compareTo("1")==0)
     {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setString('userid', '$uname');
       prefs.setString('password', '$pass');

       Navigator.push(context,  MaterialPageRoute(builder: (context) => Dashboard()));
     }
    else
      _showScaffold('${user.responseMsg}');

   // Scaffold.of(context).showSnackBar(SnackBar(content: Text('${user.responseMsg}',textAlign: TextAlign.center,),));

 }


}

