import 'package:api_services/modal/usermodal.dart';
import 'package:api_services/providers/usermodalprovider.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final userdata = UserModalProvider();
  List<Usermodal> users = [];
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FutureBuilder<List<Usermodal>>(
      future: userdata.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Usermodal> users = snapshot.data!;

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Text(users[index].name.toString());
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    )));
  }
}
