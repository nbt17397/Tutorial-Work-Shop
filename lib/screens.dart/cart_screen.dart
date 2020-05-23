import 'package:fashion_story/models/fashion.dart';
import 'package:fashion_story/screens.dart/detail_fashion.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int total = 0;
  final List<Fashion> fs =  List<Fashion>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Container(
          child: Image(
            height: 140,
            image: AssetImage('assets/images/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.black,
              onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(end: Alignment.bottomCenter, colors: [
                Color.fromRGBO(250, 0, 0, .3),
                Color.fromRGBO(250, 0, 0, 1),
              ]),
              color: Colors.red,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                    offset: Offset(5, 5))
              ],
            ),
            child: StreamBuilder(
                stream: FirestoreService().getCart(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Fashion>> snapshot) {
                  if (snapshot.hasError || !snapshot.hasData)
                    return CircularProgressIndicator();
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text(
                        'Giỏ hàng rỗng',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Fashion fashion = snapshot.data[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 10.0,
                                  offset: Offset(5, 5))
                            ],
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                  margin: EdgeInsets.all(5.0),
                                  height: 100,
                                  width: 80,
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => FashionDetail(
                                                  fashion: fashion,
                                                ))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        fashion.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        fashion.name,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Giá : ' + fashion.money.toString(),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.arrow_back_ios),
                                          iconSize: 14,
                                          onPressed: () async {
                                            Fashion faShion = Fashion(
                                              id: fashion.id,
                                              imageUrl: fashion.imageUrl,
                                              name: fashion.name,
                                              money: fashion.money,
                                              count: fashion.count - 1,
                                              categories: fashion.categories,
                                              description: fashion.description,
                                              favorite: fashion.favorite,
                                              number: fashion.number,
                                              screenshots: fashion.screenshots,
                                              size: fashion.size,
                                            );
                                            await FirestoreService()
                                                .editFashion(faShion);
                                            setState(() {
                                              int _total =
                                                  faShion.count * faShion.money;
                                              total = _total;
                                            });
                                          }),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(250, 0, 0, .3),
                                            Color.fromRGBO(250, 0, 0, 1),
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'Số lượng : ' +
                                              fashion.count.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.arrow_forward_ios),
                                          iconSize: 14,
                                          onPressed: () async {
                                            Fashion faShion = Fashion(
                                              id: fashion.id,
                                              imageUrl: fashion.imageUrl,
                                              name: fashion.name,
                                              money: fashion.money,
                                              count: fashion.count + 1,
                                              categories: fashion.categories,
                                              description: fashion.description,
                                              favorite: fashion.favorite,
                                              number: fashion.number,
                                              screenshots: fashion.screenshots,
                                              size: fashion.size,
                                            );
                                            await FirestoreService()
                                                .editFashion(faShion);
                                            setState(() {
                                              int _total =
                                                  faShion.count * faShion.money;
                                              total = _total;
                                            });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () async {
                                    await FirestoreService()
                                        .deleteFashion(fashion.id);
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(0, 0, 251, 1),
          Color.fromRGBO(0, 148, 251, .4),
        ])),
        height: 45,
        child: Center(
            child: FlatButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Tổng ' + total.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
              onPressed: ()async{
                //await FirestoreService().addDonHang(Fashion());
                print(fs.length);
              },
                              child: Text(
                  'Mua ngay',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )),
      )),
    );
  }
}
