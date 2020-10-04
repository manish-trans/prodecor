import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'Dish.dart';
import 'cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: ProductHomePage(title:'Place Order'),
    );
  }

}

class ProductHomePage extends StatefulWidget  {
  ProductHomePage({Key key,this.title}):super(key:key);
  final String title;

  @override
  _ProductPageState createState()=>_ProductPageState();
}

class _ProductPageState extends State<ProductHomePage> {
  List<Dish> _dishes = List<Dish>();

  List<Dish> _cartList = List<Dish>();

  @override
  void initState() {
    super.initState();
    _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if(_cartList.length > 0)
                    Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0
                          ),
                        ),
                      ),
                    )
                ],

              ),
              onTap: () {
                if (_cartList.isNotEmpty)
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Cart(_cartList)
                  ));
              },
            ),
          )
        ],
      ),
      body: _buildGridView(),
    );
  }

  void _populateDishes() {
    var list = <Dish>[
      Dish(
          name: 'Chicen',
          icon: Icons.fastfood,
          color: Colors.amber
      ),
      Dish(
          name: 'Rice',
          icon: Icons.child_care,
          color: Colors.brown
      ),
      Dish(
        name: 'Chicken Zinger without chicken',
        icon: Icons.print,
        color: Colors.deepOrange,
      ),
      Dish(
        name: 'Laptop without OS',
        icon: Icons.laptop,
        color: Colors.purple,
      ),
      Dish(
        name: 'Mac wihout macOS',
        icon: Icons.laptop_mac,
        color: Colors.blueGrey,
      ),
    ];
    setState(() {
      _dishes = list;
    });
  }


  ListView _buildListView() {
    return ListView.builder(itemCount: _dishes.length,itemBuilder: (context,index){
      var item=_dishes[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
        child: Card(
          elevation: 4.0,
          child: ListTile(
            leading: Icon(
              item.icon,
              color: item.color,
            ),
            title: Text(item.name),
            trailing: GestureDetector(
              child: (!_cartList.contains(item))?Icon(Icons.add_circle,color: Colors.green,):Icon(Icons.remove_circle,color: Colors.red,),
              onTap: ()
              {
                setState(() {
                  if(!_cartList.contains(item))
                    _cartList.add(item);
                      else
                        _cartList.remove(item);
                });
              },
            ),
          ),
        ),
      );

    },);
  }
  GridView _buildGridView()
  {
    return GridView.builder(
        padding:EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: _dishes.length, itemBuilder: (context,index)
    {
      var item=_dishes[index];
      return Card(
        elevation: 4.0,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.icon,
                  color: (_cartList.contains(item))?Colors.grey:item.color,
                  size: 100.0,
                ),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,right:8.0),
                child:Align(
                alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child:(!_cartList.contains(item))?Icon(Icons.add_circle,color: Colors.green,):Icon(Icons.remove_circle,color: Colors.red,),
                    onTap: ()
                    {
                      setState(() {
                        if(!_cartList.contains(item))
                          {
                            _cartList.add(item);
                          }
                        else
                          _cartList.remove(item);
                      });
                    },
                  ),
                )
            ),

          ],
        ));
    });

  }
}
