import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Nguyễn Tú'),
            accountEmail: Text('Nbt@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('HomePage'),
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Accout'),
              leading: Icon(Icons.account_circle, color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My order'),
              leading: Icon(Icons.shopping_basket, color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Shopping cart'),
              leading: Icon(Icons.shopping_cart, color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Favorite'),
              leading: Icon(Icons.favorite, color: Colors.blue),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About'),
              leading: Icon(Icons.help),
            ),
          ),
          
        ],
      ),
    );
  }
}
