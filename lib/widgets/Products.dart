import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qstp_app/Constants/constants.dart';
import 'package:qstp_app/screens/Product_page.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final CollectionReference _Users =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _Productlist =
      FirebaseFirestore.instance.collection('Products');
  User? _user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('Products').snapshots();
  var productid;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return Container(
                  height: 320.0,
                  width: double.infinity,
                  child: ListTile(
                    title: Card(
                      child: Hero(
                        tag: data['name'],
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(productid: document.id)));
                            },
                            child: GridTile(
                              footer: Container(
                                color: Colors.white60,
                                child: ListTile(
                                  title: new Row(
                                    children: [
                                      Expanded(
                                        child: Text(data['name'],
                                            style: Constants.boldheading),
                                      ),
                                      Text(
                                        'Rs ${data['price']}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              child: Image.network(
                                data['images'][0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

/*class SingleProd extends StatelessWidget {
  final product_name;
  final product_picture;
  final product_price;
  SingleProd(
      {required this.product_name,
      required this.product_picture,
      required this.product_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product_name,
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
              footer: Container(
                color: Colors.white60,
                child: ListTile(
                  title: new Row(
                    children: [
                      Expanded(
                        child: Text(product_name, style: Constants.boldheading),
                      ),
                      Text(
                        'Rs ${product_price}',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              child: Image.network(
                product_picture,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/