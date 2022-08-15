import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movil/variables.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../utilities/app_colors.dart';
import '../forms/form_login.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: AppColors.mainRed,
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.05, 0),
                child: ClipPath(
                  clipper: LoginForm(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration:
                        const BoxDecoration(color: AppColors.secondaryRed),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Bienvenido \n\n Es hora de\niniciar sesión',
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: GoogleFonts.mukta(
                                color: AppColors.white,
                                fontSize: 40,
                                height: 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const LogInCard(),
            ],
          )),
    );
  }
}

class LogInCard extends StatefulWidget {
  const LogInCard({Key? key}) : super(key: key);

  @override
  State<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends State<LogInCard> {
  final _formKey = GlobalKey<FormState>();
  bool _ocultar = true;
  final userController = TextEditingController();
  final pdwController = TextEditingController();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 3))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Ingresa los siguientes datos',
                          style: GoogleFonts.mukta(
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1)),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, rellene el campo';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Correo Electrónico',
                          hintText: 'correo@ejemplo.com',
                          border: OutlineInputBorder(),
                        ),
                        controller: userController,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, rellene el campo';
                          }
                          return null;
                        },
                        obscureText: _ocultar,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          hintText: ' ',
                          suffix: InkWell(
                            onTap: _togglePassword,
                            child: const Icon(Icons.visibility),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        controller: pdwController,
                      ),

//Botón de inicio de sesión

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.mainRed),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        child: Text('Iniciar Sesión',
                            style: GoogleFonts.mukta(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ),

//Botón de contraseña olvidada

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/fogot-password');
                          },
                          child: Text('¿Olvidaste tu contraseña?',
                              style: GoogleFonts.mukta(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  height: 1))),
                    ],
                  )),
            ),
          ),
        ],
      );

//Manejador para ocultar la contraseña

  void _togglePassword() {
    setState(() {
      _ocultar = !_ocultar;
    });
  }

  Future _login() async {
    //API URL
    var url = Uri.parse('${globals.url}login.php');
    var response = await http.post(url, body: {
      'name': userController.text,
      'pass': pdwController.text,
    });

    if (response.statusCode == 200) {
      var msg = json.decode(response.body);

      String username = msg['name'];
      int userID = int.parse(msg['id']);

      globals.username = username;
      globals.userID = userID;

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('username', username);
      await prefs.setInt('userID', userID);
      String name = prefs.getString('name').toString();
      navigateHome(name);
    } else if (response.statusCode == 404) {
      showMessage('Correo y/o contraseña incorrectos');
    } else {
      showMessage('Ocurrió un error, intentelo de nuevo más tarde');
    }
  }

  void navigateHome(String name) {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false,
        arguments: {'name': name});
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
