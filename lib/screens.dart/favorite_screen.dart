import 'package:fashion_story/models/fashion.dart';
import 'package:fashion_story/screens.dart/detail_fashion.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: StreamBuilder(
          stream: FirestoreService().getFavorite(),
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
                    trailing: IconButton(
                        icon: Icon(Icons.delete_forever),
                        color: Colors.red,
                        onPressed: () async {
                          await FirestoreService().deleteFavorite(fashion.id);
                        }),
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
