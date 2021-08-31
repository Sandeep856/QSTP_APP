import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Shopping_cart extends StatefulWidget {
  const Shopping_cart({Key? key}) : super(key: key);

  @override
  _Shopping_cartState createState() => _Shopping_cartState();
}

class _Shopping_cartState extends State<Shopping_cart> {
  final CollectionReference Users =
      FirebaseFirestore.instance.collection('Shop');
  User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Users.doc(_user!.uid).collection('Cart').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            int _totalItems = 0;
            if (snapshot.connectionState == ConnectionState.active) {
              List _documents = snapshot.data!.docs;
              _totalItems = _documents.length;
            }
            return Container(
              padding: EdgeInsets.all(8),
              child: Text(
                '${_totalItems}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            );
          }),
    );
  }
}
