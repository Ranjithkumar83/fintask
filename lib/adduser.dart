import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  AddUserState createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  final formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // File? file;
  var options = [
    'Admin',
    'Viewer',
  ];
  var _currentItemSelected = "Admin";
  var role = "Viewer";

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userController.dispose();
    super.dispose();
  }
  void clearText(){
    userController.clear();
    emailController.clear();
    passwordController.clear();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: userController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.indigo)),
                        hintText: 'User name',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (email) => email != null && !EmailValidator.validate(email) ? 'enter email':  null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.indigo)),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.indigo)),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey)),
                    validator:  (value) => value != null && value.length < 8 ? 'password must be 8 characters':  null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Role:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: false,
                        items: options.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            _currentItemSelected = newValueSelected!;
                            role = newValueSelected;
                          });
                        },
                        value: _currentItemSelected,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      addUser();
                      addUserDetails(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        userController.text.trim(),
                        _currentItemSelected.toString(),
                      );clearText();
                    },
                    child: const Text('Submit')),
              )
            ],
          ),
      ),
    ),
        ));
  }
  Future addUser() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    // try{
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      userController.toString();
      _currentItemSelected.toString();
    // }on FirebaseAuthException catch(e){
    //   print(e);
    // }
  }
}

Future addUserDetails(
    String email, String password, String name, String role) async {
  await FirebaseFirestore.instance
      .collection('users')
      .add({'email': email, 'password': password, 'role': role, 'name': name});
}
