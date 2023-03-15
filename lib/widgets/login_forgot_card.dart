import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:PillTake/variables.dart' as globals;

import '../utilities/app_colors.dart';

class ForgotCard extends StatefulWidget {
  const ForgotCard({Key? key}) : super(key: key);

  @override
  State<ForgotCard> createState() => _ForgotCardState();
}

class _ForgotCardState extends State<ForgotCard> {
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .3,
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
                  Text('Ingresa el correo de la cuenta',
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
                        border: OutlineInputBorder()),
                    controller: mailController,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainRed),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _reset();
                        }
                      },
                      child: Text(
                        'Cambiar contraseña',
                        style: GoogleFonts.mukta(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future _reset() async {
    var url = Uri.parse('${globals.url}login.php');
    var response = await http.post(url, body: {
      'type': '2',
      'mail': mailController.text,
    });

    switch (response.statusCode) {
      case 200:
        showMessage('Correo enviado, no olvides revisar en spam');
        break;
      case 408:
        showMessage('Ocurrió un error, intentalo de nuevo más tarde');
        break;
      case 404:
        showMessage('El correo no tiene una cuenta asociada');
    }
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
