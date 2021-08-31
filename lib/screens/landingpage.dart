import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qstp_app/Constants/constants.dart';
import 'package:qstp_app/screens/homepage.dart';
import 'package:qstp_app/screens/login.dart';
import 'package:qstp_app/widgets/size.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error:${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('Error:${streamSnapshot.error}'),
                      ),
                    );
                  }
                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    Object? _user = streamSnapshot.data;
                    if (_user == null) {
                      return LoginPage();
                    } else {
                      return homePage();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SafeArea(
                            child: Text(
                              'Checking Authentication..',
                              style: Constants.regularHeadings,
                            ),
                          ),
                          SpinKitRotatingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return Scaffold(
            body: Column(
              children: [
                Text(
                  'Initializing App....',
                  style: Constants.regularHeadings,
                ),
                SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                )
              ],
            ),
          );
        });
  }
}
