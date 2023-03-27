// import 'package:email_validator/email_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // String pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  void clearText(){
    emailController.clear();
    passwordController.clear();
  //
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Login',
        ),
      ),
      body: Form(key: formKey,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
                child: TextFormField(
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'enter email'
                          : null,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.indigo)),
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
              // SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.indigo)),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey)),
                  validator: (value) => value != null && value.length < 8
                      ? 'password must be 8 characters'
                      : null,
                ),
              ),

              // const SizedBox(height: 10),
              Container(
                  height: 50,
                  width: 360,
                  child: ElevatedButton(
                      onPressed: () {
                        signIn();clearText();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.indigo,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
