// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forms/form_login.dart';
import 'package:movil/variables.dart' as globals;

class Splash extends StatefulWidget {
  final int type;
  const Splash(this.type, {Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 1), () => _validate(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF3838),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: const AlignmentDirectional(0.05, 0),
            child: ClipPath(
              clipper: LoginForm(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(color: Color(0xFFB31515)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/images/PillTakeLogo.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                        )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          const Center(
              child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Color(0xFFB31515),
            ),
          ))
        ],
      ),
    );
  }

  Future<bool> _setName() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    bool auto = false;
    if (username != null) auto = true;
    return auto;
  }

  Future<bool> _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('userID');
    bool success = false;
    String? username = prefs.getString('username');
    if (username == null) success = true;
    return success;
  }

  Future _validate(BuildContext context) async {
    switch (widget.type) {
      case 1:
        bool loged = await _setName();
        if (loged) {
          final prefs = await SharedPreferences.getInstance();
          globals.username = prefs.getString('username').toString();
          String id = prefs.getInt('userID').toString();
          globals.userID = int.parse(id);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
        break;
      case 2:
        bool logout = await _logOut();
        if (logout) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
    }
  }
}
