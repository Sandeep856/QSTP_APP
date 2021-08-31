import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_images/carousel_images.dart';

import 'package:qstp_app/screens/OrderDetails.dart';

import 'package:qstp_app/screens/cart1.dart';
import 'package:qstp_app/screens/save.dart';
import 'package:qstp_app/widgets/Products.dart';

import 'package:qstp_app/widgets/shopping_cart.dart';

//import 'package:shopping_app2/Counters/cartitemcounter.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

// ignore: camel_case_types

class _homePageState extends State<homePage> {
  User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    final List<String> listImages = [
      'assets/bag1.png',
      'assets/bag2.png',
      'assets/bag3.png',
      'assets/bag4.png',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          'Shopping App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          Stack(
            children: [
              new IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  color: Colors.white,
                  icon: Icon(Icons.shopping_cart)),
              Icon(
                Icons.brightness_1,
                size: 20.0,
                color: Colors.green,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Shopping_cart(),
              ),
            ],
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
              accountName: Text('User'),
              accountEmail: Text(_user!.email.toString()),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blue),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderDetails()));
              },
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SavedTab()));
              },
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: ListTile(
                  title: Text('Sign Out'),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.green,
                  )),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Arrival Soon',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CarouselImages(
            scaleFactor: 0.7,
            listImages: listImages,
            height: 200.0,
            borderRadius: 30.0,
            cachedNetworkImage: true,
            verticalAlignment: Alignment.bottomCenter,
            onTap: (index) {
              print('hii');
            },
          ),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
              'Products',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 320.0,
            child: Products(),
          ),
        ],
      ),
    );
  }
}
