import 'package:fashion_story/models/fashion.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:fashion_story/widget/circular_clipper.dart';
import 'package:flutter/material.dart';

class FashionDetail extends StatefulWidget {
  final Fashion fashion;
  FashionDetail({this.fashion});
  @override
  _FashionDetailState createState() => _FashionDetailState();
}

class _FashionDetailState extends State<FashionDetail> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform:
                    Matrix4.translationValues(0.0, -50.0, 0.0), // tai thỏ
                child: Hero(
                  tag: widget.fashion.imageUrl,
                  child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20.0),
                      child: Image.network(
                        widget.fashion.imageUrl,
                        height: 400.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 30.0,
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () async {
                        await FirestoreService().addCart(Fashion(
                          categories: widget.fashion.categories,
                          count: 0,
                          description: widget.fashion.description,
                          favorite: widget.fashion.favorite,
                          imageUrl: widget.fashion.imageUrl,
                          money: widget.fashion.money,
                          name: widget.fashion.name,
                          number: widget.fashion.number,
                          screenshots: widget.fashion.screenshots,
                          size: widget.fashion.size,
                        ));
                      
                      Navigator.pop(context);
                    },
                    iconSize: 30.0,
                    color: Colors.red,
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () async {
                      await FirestoreService().addFavorite(Fashion(
                        categories: widget.fashion.categories,
                        count: 1,
                        description: widget.fashion.description,
                        favorite: true,
                        imageUrl: widget.fashion.imageUrl,
                        money: widget.fashion.money,
                        name: widget.fashion.name,
                        number: widget.fashion.number,
                        screenshots: widget.fashion.screenshots,
                        size: widget.fashion.size,
                      ));
                      setState(() {
                        fav = true;
                      });
                      //Navigator.pop(context);
                    },
                    iconSize: 30.0,
                    color: fav == false ? Colors.black : Colors.red,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Giá : ' + widget.fashion.money.toString(),
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.fashion.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.fashion.categories,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      '⭐ ⭐ ⭐ ⭐',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Số lượng',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              widget.fashion.number.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Size',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              widget.fashion.size.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Container(
                      height: 120.0,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.fashion.description,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Hình mô tả ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => print('View '),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.fashion.screenshots.length == 3
                            ? _getScreenShot(widget.fashion)
                            : CircularProgressIndicator()
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _getScreenShot(Fashion fashion) {
    return Container(
        height: 250,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    fashion.screenshots[0],
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    fashion.screenshots[1],
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    fashion.screenshots[2],
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ));
  }
}
