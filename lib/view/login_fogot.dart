import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/widgets/login_forgot_card.dart';

import '../forms/form_login.dart';

class LoginForgot extends StatelessWidget {
  const LoginForgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF3838),
      appBar: AppBar(backgroundColor: const Color(0xFFB31515), elevation: 0),
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(color: Color(0xFFB31515)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Recuperemos\ntu cuenta',
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: GoogleFonts.mukta(
                                color: Colors.white,
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
              const ForgotCard()
            ],
          )),
    );
  }
}
