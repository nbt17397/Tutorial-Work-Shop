import 'package:fashion_story/models/theNew.dart';
import 'package:fashion_story/screens.dart/view_thenew_screen.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TheNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: Image(
              height: 140,
              image: AssetImage('assets/images/logo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Tư vấn mặc đẹp',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Thời trang sao',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Hàng hiệu',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [_getThoiTrangSao(), _getTuVanMacDep(), _getHangHieu()],
        ),
      ),
    );
  }

  _getTuVanMacDep() {
    return StreamBuilder(
        stream: FirestoreService().getTuVanMacDep(),
        builder: (BuildContext context, AsyncSnapshot<List<TheNew>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                TheNew theNew = snapshot.data[index];
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
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5.0),
                        height: 100,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            theNew.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              theNew.title,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.ms()
                                  .add_yMd()
                                  .format(theNew.createAt.toDate()),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[],
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewTheNew(
                                          theNew: theNew,
                                        )));
                          },
                          child: Text(
                            'Read',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                );
              });
        });
  }

  _getThoiTrangSao() {
    return StreamBuilder(
        stream: FirestoreService().getThoiTrangSao(),
        builder: (BuildContext context, AsyncSnapshot<List<TheNew>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                TheNew theNew = snapshot.data[index];
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
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5.0),
                        height: 100,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            theNew.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              theNew.title,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.ms()
                                  .add_yMd()
                                  .format(theNew.createAt.toDate()),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[],
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewTheNew(
                                          theNew: theNew,
                                        )));
                          },
                          child: Text(
                            'Read',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                );
              });
        });
  }

  _getHangHieu() {
    return StreamBuilder(
        stream: FirestoreService().getHangHieu(),
        builder: (BuildContext context, AsyncSnapshot<List<TheNew>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                TheNew theNew = snapshot.data[index];
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
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5.0),
                        height: 100,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            theNew.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              theNew.title,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.ms()
                                  .add_yMd()
                                  .format(theNew.createAt.toDate()),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[],
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewTheNew(
                                          theNew: theNew,
                                        )));
                          },
                          child: Text(
                            'Read',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                );
              });
        });
  }
}
