import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintask/Screens/profilescreen.dart';
import 'package:fintask/model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: Padding(
            padding: const EdgeInsets.only(left: 50, top: 100.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
              child: const Text(
                'Profile',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            )),
      ),
      body: StreamBuilder(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('No data found');
            }

            if (snapshot.hasData) {
              return ListView(children: snapshot.data!.map(buildUser).toList());
            }
            return Text ('Loading....');
          }),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

Widget buildUser(User user) => ListTile(
      title: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.name),
          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.role),
          )
        ],
      ),
    );
