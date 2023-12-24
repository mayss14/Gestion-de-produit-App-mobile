import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final id = auth.currentUser!.uid;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 146, 150, 129),
          title: const Text(
            'Informations du compte',
            style: TextStyle(
              color: Color.fromARGB(255, 244, 242, 242),
            ),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 250, 248, 248),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 249, 249, 248),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("uid", isEqualTo: id)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Text("");
                  } else {
                    final name = snapshot.data!.docs[0]['username'];
                    final email = snapshot.data!.docs[0]['email'];
                    return Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 150.0,
                          height: 20.0,
                          child: Divider(
                            color: Colors.teal.shade100,
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(Icons.email,
                                color: Color.fromARGB(255, 146, 150, 129)),
                            title: Text(
                              email,
                              //auth.currentUser!.email,
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 20.0,
                                  color: Colors.teal.shade900),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
