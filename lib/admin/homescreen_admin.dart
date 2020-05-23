import 'package:fashion_story/admin/add_fashion.dart';
import 'package:fashion_story/screens.dart/menu_fashion.dart';
import 'package:fashion_story/screens.dart/thenew_screen.dart';
import 'package:fashion_story/services/database_service.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int numberSomi = 0;
  int numberAoThun = 0;
  int numberAoKhoac = 0;
  int numberQuanShot = 0;
  int numberGiayNam = 0;
  int numberBalo = 0;
  int numberSao = 0;
  int numberHangHieu = 0;
  int numberTuVan = 0;
  int countAllSanPham = 0;
  int countAllTinTuc = 0;
  bool hideTongQuan = true;
  bool hideTinTuc = true;

  @override
  void initState() {
    super.initState();
    _setupNumberAll();
  }

  _setupNumberAll() async {
    int _numberSoMi = await FirestoreService().numberSoMi();
    int _numberAoKhoac = await FirestoreService().numberAoKhoac();
    int _numberAoThun = await FirestoreService().numberAoThun();
    int _numberQuanShot = await FirestoreService().numberQuanShot();
    int _numberBalo = await FirestoreService().numberBalo();
    int _numberGiayNam = await FirestoreService().numberGiayNam();
    int _numberSao = await FirestoreService().numberSao();
    int _numberHangHieu = await FirestoreService().numberHangHieu();
    int _numberTuVan = await FirestoreService().numberTuVanLamDep();
    setState(() {
      numberSomi = _numberSoMi;
      numberAoKhoac = _numberAoKhoac;
      numberAoThun = _numberAoThun;
      numberQuanShot = _numberQuanShot;
      numberGiayNam = _numberGiayNam;
      numberBalo = _numberBalo;
      numberTuVan = _numberTuVan;
      numberHangHieu = _numberHangHieu;
      numberSao = _numberSao;
      int _countAllSp = numberAoKhoac +
          numberAoKhoac +
          numberSomi +
          numberBalo +
          numberGiayNam +
          numberQuanShot;
      int _countAllTt = numberSao + numberTuVan + numberHangHieu;
      countAllSanPham = _countAllSp;
      countAllTinTuc = _countAllTt;
    });
  }

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
                  'Tổng quan',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Đơn hàng',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Doanh thu',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [_getTongQuan(), _getDonHang(), _getUser()],
        ),
      ),
    );
  }

  _getTongQuan() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Card(
          margin: EdgeInsets.all(8),
          elevation: 10,
          borderOnForeground: true,
          color: Colors.blueGrey,
          child: ListTile(
            leading: IconButton(
              icon: hideTongQuan == true
                  ? Icon(Icons.arrow_right)
                  : Icon(Icons.arrow_drop_down),
              onPressed: () {
                if (hideTongQuan == false) {
                  setState(() {
                    hideTongQuan = true;
                  });
                } else if (hideTongQuan == true) {
                  setState(() {
                    hideTongQuan = false;
                  });
                }
              },
              iconSize: 40,
            ),
            title: Text(
              'Tổng sản phẩm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('số lượng : ' + countAllSanPham.toString()),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddFashion()));
              },
              color: Colors.red,
            ),
          ),
        ),
        _getHideTongQuan(),
        Card(
          margin: EdgeInsets.all(8),
          elevation: 10,
          borderOnForeground: true,
          color: Colors.blueGrey,
          child: ListTile(
            leading: IconButton(
              icon: hideTinTuc == true
                  ? Icon(Icons.arrow_right)
                  : Icon(Icons.arrow_drop_down),
              onPressed: () {
                if (hideTinTuc == false) {
                  setState(() {
                    hideTinTuc = true;
                  });
                } else if (hideTinTuc == true) {
                  setState(() {
                    hideTinTuc = false;
                  });
                }
              },
              iconSize: 40,
            ),
            title: Text(
              'Thống kê tin tức',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('số lượng : ' + countAllTinTuc.toString()),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
              color: Colors.red,
            ),
          ),
        ),
        _getHideTinTuc(),
        Card(
          margin: EdgeInsets.all(8),
          elevation: 10,
          borderOnForeground: true,
          color: Colors.blueGrey,
          child: ListTile(
            leading: IconButton(
              icon: hideTinTuc == true
                  ? Icon(Icons.arrow_right)
                  : Icon(Icons.arrow_drop_down),
              onPressed: () {
                if (hideTinTuc == false) {
                  setState(() {
                    hideTinTuc = true;
                  });
                } else if (hideTinTuc == true) {
                  setState(() {
                    hideTinTuc = false;
                  });
                }
              },
              iconSize: 40,
            ),
            title: Text(
              'Thống kê khách hàng',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('số lượng : '),
          ),
        ),
      ],
    );
  }

  _getHideTongQuan() {
    return hideTongQuan == true
        ? SizedBox(
            height: 0.0,
          )
        : Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text(
                    'Áo sơ mi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('số lượng : ' + numberSomi.toString()),
                  trailing: Column(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MenuFashion(
                                          categories: 'Áo Khoác',
                                        )));
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Áo thun',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberAoThun.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MenuFashion(
                                      categories: 'Áo thun',
                                    )));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Áo khoác',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberAoKhoac.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MenuFashion(
                                      categories: 'Sơ mi',
                                    )));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Quần short',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberQuanShot.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MenuFashion(
                                      categories: 'Áo thun',
                                    )));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Giày nam',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberGiayNam.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MenuFashion(
                                      categories: 'Áo thun',
                                    )));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Balo',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberBalo.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MenuFashion(
                                      categories: 'Áo thun',
                                    )));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
            ],
          );
  }

  _getHideTinTuc() {
    return hideTinTuc == true
        ? SizedBox(
            height: 0.0,
          )
        : Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Tin hàng hiệu',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberHangHieu.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => TheNewScreen()));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Tư vấn mặc đẹp',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberTuVan.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => TheNewScreen()));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 10,
                borderOnForeground: true,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Tin thời trang sao',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('số lượng : ' + numberSao.toString()),
                  trailing: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => TheNewScreen()));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ),
            ],
          );
  }

  _getDonHang() {
    return Text('asds');
  }

  _getUser() {
    return Text('asds');
  }
}
