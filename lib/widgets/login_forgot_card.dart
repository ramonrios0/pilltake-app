import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotCard extends StatefulWidget {
  const ForgotCard({Key? key}) : super(key: key);

  @override
  State<ForgotCard> createState() => _ForgotCardState();
}

class _ForgotCardState extends State<ForgotCard> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .3,
          decoration: BoxDecoration(
              color: Colors.white,
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
                          color: Colors.black,
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
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFFF3838)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Revisa la bandeja de tu correo para continuar')));
                        }
                      },
                      child: Text(
                        'Cambiar contraseña',
                        style: GoogleFonts.mukta(
                            color: Colors.white,
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
}
