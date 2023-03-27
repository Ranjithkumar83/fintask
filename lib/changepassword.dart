import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePwd extends StatefulWidget {
  @override
  ChangePwdState createState() => ChangePwdState();
}

class ChangePwdState extends State<ChangePwd> {
  var  newPassword ='';
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  void dispose(){
    passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
  changePassword()async{
    try{
await currentUser!.updatePassword(newPassword);

    }catch(error){

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
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
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo)),
                      hintText: 'Current Password',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: newPasswordController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo)),
                      hintText: 'New Password',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                var currentState;
                if(currentState.validate){
                  setState(() {
                   newPassword=newPasswordController.text;
                  });
                  changePassword();
                }
              }, child: const Text('Update')),
            )
          ],
        ),
      ),
    ));
  }
}
