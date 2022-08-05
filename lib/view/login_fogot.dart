import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';
import '../widgets/login_forgot_card.dart';
import '../forms/form_login.dart';

class LoginForgot extends StatelessWidget {
  const LoginForgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainRed,
      appBar: AppBar(backgroundColor: AppColors.secondaryRed, elevation: 0),
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
                              'Recuperemos\ntu cuenta',
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
              const ForgotCard()
            ],
          )),
    );
  }
}
