import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:prodecor/login.dart';

void main() => runApp(Intro());

class Intro extends StatefulWidget {
  @override
  IntroState createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  final _imageUrls = [
    "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
    "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
    "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
  ];
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(new Slide(
      title: "Title1",
      description:
          "Allow miles wound place the leave had. To sitting subject no improve studied limited",
      pathImage: "assets/images/user.png",
      backgroundColor: Colors.transparent,
    ));
    slides.add(new Slide(
      title: "Title2",
      description:
          "Allow miles wound place the leave had. To sitting subject no improve studied limited",
      pathImage: "assets/images/logo.png",
      backgroundColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //return new IntroSlider(slides: this.slides,onDonePress: this.onDonePress);
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
              body:IntroSlider(
                slides: this.slides, onDonePress: this.onDonePress,colorActiveDot: Colors.white,),
            )));
  }

  void onDonePress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
  }
}
