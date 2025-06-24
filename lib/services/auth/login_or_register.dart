import 'package:flutter/material.dart';
import 'package:messe/pages/login_page.dart';
import 'package:messe/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool ShowLoginPage = true;  //by default we will be at login page

  void togglePages(){    //toggles between login/register page
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  @override
  Widget build(BuildContext context){

    if(ShowLoginPage){
      return LoginPage(
        onTap: togglePages
      );
    }
    else{
      return RegisterPage(
        onTap: togglePages
      );
    }
    
  }
}