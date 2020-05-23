import 'package:fashion_story/models/fashion.dart';
import 'package:fashion_story/screens.dart/detail_fashion.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';

class MenuFashion extends StatefulWidget {
  final String categories;
  MenuFashion({this.categories});
  @override
  _MenuFashionState createState() => _MenuFashionState();
}

class _MenuFashionState extends State<MenuFashion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categories == 'Áo Khoác'
            ? 'Áo Khoác'
            : widget.categories == 'Áo thun'
                ? 'Áo thun'
                : widget.categories == 'Sơ mi'
                    ? 'Sơ Mi'
                    : widget.categories == 'Balo'
                        ? 'Ba lô'
                        : widget.categories == 'Giày nam'
                            ? 'Giày nam'
                            : widget.categories == 'Quần shot'
                                ? 'Quần shot'
                                : 'null'),
      ),
      body: StreamBuilder(
          stream: widget.categories == 'Áo Khoác'
              ? FirestoreService().getAoKhoac()
              : widget.categories == 'Áo thun'
                  ? FirestoreService().getThun()
                  : widget.categories == 'Sơ mi'
                      ? FirestoreService().getSoMi()
                      : FirestoreService().getSoMi(),  // will update
          builder:
              (BuildContext context, AsyncSnapshot<List<Fashion>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return CircularProgressIndicator();

            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  Fashion fashion = snapshot.data[index];
                  return Single_Product(
                    fashion: fashion,
                  );
                });
          }),
    );
  }
}

class Single_Product extends StatelessWidget {
  final Fashion fashion;
  Single_Product({this.fashion});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black, blurRadius: 20, offset: Offset(3, 5))
      ]),
      margin: EdgeInsets.all(10),
      child: Hero(
          tag: fashion.imageUrl,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => FashionDetail(
                            fashion: fashion,
                          ))),
              child: GridTile(
                footer: Container(
                  color: Colors.white24,
                  child: ListTile(
                    title: Text(
                      fashion.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ),
                ),
                child: Image.network(
                  fashion.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
