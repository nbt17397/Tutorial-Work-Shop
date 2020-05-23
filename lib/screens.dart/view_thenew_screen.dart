import 'package:carousel_pro/carousel_pro.dart';
import 'package:fashion_story/models/theNew.dart';
import 'package:fashion_story/screens.dart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewTheNew extends StatefulWidget {
  final TheNew theNew;

  const ViewTheNew({Key key, this.theNew}) : super(key: key);

  @override
  _ViewTheNewState createState() => _ViewTheNewState();
}

class _ViewTheNewState extends State<ViewTheNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0.0,
        title: Container(
          child: Image(
            height: 140,
            image: AssetImage('assets/images/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen()));
            },
            icon: Icon(Icons.shopping_cart),
            iconSize: 30.0,
            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 340,
            child: Carousel(
              boxFit: BoxFit.cover,
              images: [
                Image.network(
                  widget.theNew.image,
                  fit: BoxFit.cover,
                ),
                Image.network(widget.theNew.image1, fit: BoxFit.cover),
                Image.network(widget.theNew.image2, fit: BoxFit.cover),
              ],
              autoplay: true,
              autoplayDuration: Duration(milliseconds: 8000),
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 4000),
              dotSize: 4.0,
              indicatorBgPadding: 5.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            widget.theNew.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
              child: Text(
            DateFormat.Hms()
                .add_yMMMd()
                .format(widget.theNew.createAt.toDate()),
            style: TextStyle(color: Colors.red),
          )),
          SizedBox(
            height: 20.0,
          ),
          Divider(),
          Text(widget.theNew.content)
        ],
      ),
    );
  }
}
