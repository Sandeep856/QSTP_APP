import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstp_app/Constants/constants.dart';

import 'package:qstp_app/screens/OrderDetails.dart';
import 'package:qstp_app/screens/Product_page.dart';
import 'package:qstp_app/widgets/shopping_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CollectionReference _Users =
      FirebaseFirestore.instance.collection('Shop');
  final CollectionReference _Productlist =
      FirebaseFirestore.instance.collection('Products');
  User? _user = FirebaseAuth.instance.currentUser;
  late int index = 0;
  @override
  Widget build(BuildContext context) {
    @override
    int amount = 0;
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            body: FutureBuilder<QuerySnapshot>(
                future: _Users.doc(_user!.uid).collection('Cart').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error:${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scaffold(
                      backgroundColor: Colors.yellow[100],
                      appBar: AppBar(
                        title: Text(
                          'Cart',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: Colors.lightBlue[300],
                        centerTitle: true,
                        actions: [
                          Stack(
                            children: [
                              new IconButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  icon: Icon(Icons.shopping_cart)),
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Shopping_cart(),
                              ),
                            ],
                          )
                        ],
                      ),
                      body: ListView(
                        padding: EdgeInsets.only(
                          top: 30.0,
                          bottom: 24.0,
                        ),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return GestureDetector(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) =>
                                      ProductPage(productid: document.id));
                              Navigator.pushReplacement(context, route);
                            },
                            child: Card(
                              color: Colors.white,
                              borderOnForeground: true,
                              elevation: 2,
                              margin: EdgeInsets.only(
                                top: 1,
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: FutureBuilder(
                                future: _Productlist.doc(document.id).get(),
                                builder: (context, AsyncSnapshot productSnap) {
                                  if (productSnap.hasError) {
                                    return Text('${productSnap.error}');
                                  }
                                  if (productSnap.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> _productMap =
                                        productSnap.data!.data()
                                            as Map<String, dynamic>;

                                    if (_productMap['price'] != null) {
                                      amount =
                                          amount + _productMap['price'] as int;
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 24.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 90,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "${_productMap['images'][0]}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_productMap['name']}",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4.0,
                                                  ),
                                                  child: Text(
                                                    "\$${_productMap['price']}",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                  return Text('');
                }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Text(amount.toString()),
      ),
    );
  }
}


/*Container(
                        color: Colors.white60,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Total',
                                  style: Constants.regularDarkText,
                                ),
                                subtitle: Text(
                                  'Rs 2000',
                                  style: Constants.regularDarkText,
                                ),
                              ),
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  'Check Out',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      )*/

 /**/
                  
                  