import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/productpage.dart';

import 'API.dart';
import 'User.dart';

const baseUrl = "https://jsonplaceholder.typicode.com";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Home'),
      home: LogInPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();

  }

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(icon: new Icon(Icons.home)),
            new Tab(
              icon: new Icon(Icons.message),
            ),
            new Tab(
              icon: new Icon(Icons.people),
            )
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,

      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              // child: Text('Drawer header'),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/images/user.png"),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
            Divider(),
            ListTile(
              title: Text('Theatre'),
              leading: Icon(Icons.theaters),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondRoute()));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Restaurant'),
              leading: Icon(Icons.restaurant),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
        onTap: onTapped,
      ),
      /* body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/home.png',
                  scale: 3.0,
                ),
                Text("Welcome User"),
                ListTile(
                  title: Text('Theatre'),
                  leading: Icon(Icons.theaters),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Restaurant'),
                  leading: Icon(Icons.restaurant),
                  onTap: () {},
                ),
              ],
            ),

            */ /* RaisedButton(
              onPressed: () {},
              child: const Text('Enabled Button', style: TextStyle(fontSize: 10)),
            ),
            const SizedBox(height: 20),*/ /*
            TabBarView(
              children: [
                new Text("This is call Tab View"),
                new Text("This is chat Tab View"),
                new Text("This is notification Tab View"),
              ],
              controller: _tabController,
            )
          ],
        )

      ),
*/
      body: TabBarView(
        children: [
          new Container(
            child: ListView(
              children: <Widget>[
                Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      title: Text("Home Page"),
                      leading: Icon(Icons.home),
                      trailing: Icon(Icons.arrow_forward_ios),
                      subtitle: Text("description"),
                    )),
                Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      title: Text("Profile"),
                      leading: Icon(Icons.people),
                      trailing: Icon(Icons.arrow_forward_ios),
                      subtitle: Text("description"),
                    )),
                Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      title: Text("Message"),
                      leading: Icon(Icons.message),
                      trailing: Icon(Icons.arrow_forward_ios),
                      subtitle: Text("description"),
                    )),
              ],
            ),
          ),
          new Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    /* Text("This is chat Tab View"),
                   Icon(Icons.verified_user),
                   Text("This is chat Tab View"),
                   Icon(Icons.verified_user),*/
                    Row(
                      children: <Widget>[
                        Text("This is chat Tab View"),
                        Icon(Icons.verified_user),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("This is chat Tab View"),
                        Icon(Icons.verified_user),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          new Text("This is notification Tab View"),
        ],
        controller: _tabController,
      ),
    );
    /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecondRoute()));
      }
      if (_currentIndex == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));
      }
    });
  }

}

class Profile extends StatefulWidget {
  @override
  createState() => ProfileState();
}

class SecondRoute extends StatefulWidget {
  @override
  createState() => SecondRouteState();
}

class SecondRouteState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
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
    return Scaffold(
        appBar: AppBar(
          title: Text("User List"),
        ),
        body: ListView.separated(
          itemCount: users.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].name),
              leading: Image.network("https://via.placeholder.com/150/24f355"),
              /*leading: Icon(
                    Icons.person
                ),*/

              subtitle: Text("description will be added"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(user: users[index]),
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
  }
}

class DetailScreen extends StatelessWidget {
  final User user;

  DetailScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        margin:EdgeInsets.all(10.0) ,

          child:Column(
          children: <Widget>[
            Text("Hi" + user.name,style: new TextStyle(fontSize: 20,color:Colors.blueAccent)),

          ],

        )
      ),

    );
  }
}

class ProfileState extends State {
  TextEditingController etnamecontroller = TextEditingController();
  TextEditingController etphonecontroller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    etnamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: etnamecontroller,
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.call),
                  hintText: 'Enter your phone no',
                  labelText: 'Phone'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.calendar_today),
                hintText: 'Enter your dob',
                labelText: 'Dob',
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: RaisedButton(
                child: const Text('Submit'),
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Hello" + " " + etnamecontroller.text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        )),
      ),

      /* Container(
            decoration: new BoxDecoration(
                color: Colors.green,

                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),

            padding:EdgeInsets.all(10.0),
            child: Text("Name",style: TextStyle(fontSize: 15,color: Colors.white)),

          ),*/

      /*  Container(
            decoration: new BoxDecoration(
                color: Colors.green,

                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),

            padding:EdgeInsets.all(10.0),


            child: Text("Address",style: TextStyle(fontSize: 15,color: Colors.white)),
          ),*/
      /*  Card(
              elevation: 3,
              margin: EdgeInsets.all(10.0),
              color: Colors.blueAccent,
              borderOnForeground:true,
              child:Container(
                padding:EdgeInsets.all(10.0),

                child: Text("Delhi",style: TextStyle(fontSize: 15,color: Colors.white)),
              )
          ),*/
      /* Container(
            decoration: new BoxDecoration(
                color: Colors.green,

                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),
            padding:EdgeInsets.all(10.0),

            child: Text("Job",style: TextStyle(fontSize: 15,color: Colors.white)),
          ),*/

      /* Container(
            decoration: new BoxDecoration(
                color: Colors.green,

                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),
            padding:EdgeInsets.all(10.0),

            child: Text("Job Location",style: TextStyle(fontSize: 15,color: Colors.white)),
          ),*/
      /*  Card(
    elevation: 3,
    margin: EdgeInsets.all(10.0),
    color: Colors.blueAccent,
    borderOnForeground:true,
          child:Container(
            padding:EdgeInsets.all(10.0),

            child: Text("Noida",style: TextStyle(fontSize: 15,color: Colors.white)),
          )
    ),*/
    );
  }
}
class LogInPage extends StatelessWidget{
  final _pinCodeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  /*  final logo=CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 30,
      child: Image.asset(
        'assets/images/user.png',
        scale: 3.0,
      ),
    );*/
    const List<Color> orangeGradients = [
      Color(0xFFFF9844),
      Color(0xFFFE8853),
      Color(0xFFFC7267),
    ];
    const List<Color>blueGradients=[
     Color(0xFF82B1FF),
      Color(0xFF29B2FF),
      Color(0xFF2979FF),
    ];
    final pincode=TextFormField(
      controller: _pinCodeController,
      keyboardType: TextInputType.phone,
      maxLength: 4,
      maxLines: 1,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Enter Pin:",
        contentPadding:EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
       border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.grey
        )
      ),
      style: new TextStyle(
        fontFamily: "Poppins",
      ),

    );
    final loginbutton=Padding(
      padding: EdgeInsets.all(20.0),

        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (ProductHomePage(title: 'Home'))));
          },
          padding: EdgeInsets.all(12.0),
          color: Colors.blueAccent,
          child: Text("LogIn",style: TextStyle(color: Colors.white),),

        ),


    );
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(


            ),
          SizedBox(
            width: (MediaQuery.of(context).size.width)*0.25,

          ),
            Material(
              elevation: 10.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0)
                )
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 40.0,right: 20.0,top: 10.0,bottom: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "abc@example.com",
                    hintStyle: TextStyle(color: Color(0xFFE1E1E1),fontSize: 14)
                  ),
                ),

              ),
            ),

            SizedBox(
              height: 30,


            ),
            //loginbutton,
            GestureDetector(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => (ProductHomePage(title: 'Home'))));
              },

                child: Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    gradient: LinearGradient(
                      colors: blueGradients,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                  ),
                  child: Text(
                    "LogIn",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),
                  ),

                  padding: EdgeInsets.only(top: 16,bottom: 16),


                )

            ),

          ],

        ),
      ),
    );
  }

}
