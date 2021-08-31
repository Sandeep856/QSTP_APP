//import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final CollectionReference Order =
      FirebaseFirestore.instance.collection('Shop');
  final CollectionReference _productlist =
      FirebaseFirestore.instance.collection('Products');
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: FutureBuilder<QuerySnapshot>(
            future: Order.doc(_user!.uid).collection('Cart').get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Error:${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Container(
                    child: FutureBuilder(
                      future: _productlist.doc(document.id).get(),
                      builder:
                          (BuildContext context, AsyncSnapshot productSnap) {
                        if (productSnap.hasError) {
                          return Text('${productSnap.error}');
                        }
                        if (productSnap.connectionState ==
                            ConnectionState.done) {
                          Map<String, dynamic> _productMap =
                              productSnap.data!.data();
                          int amount = 0;
                          List price = _productMap['prce'];
                          amount = _productMap.length;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text('${amount}'),
                                Scaffold(
                                  body: Text(_productMap['price']),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  );
                }));
              }
              return Text('');
            },
          ),
        ),
      ],
    );
  }
}
