/*
 * widgets/drawer.dart
 * 
 * Aquí se crear la barra de navegación lateral que se encuentra en las pantallas
 * de la aplicación.
 *
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/app_colors.dart';
import '../view/splash.dart';

class DrawerMain extends StatelessWidget {
  final int page;

  const DrawerMain(this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.secondaryRed),
              child: Image.asset('assets/images/PillTakeLogo.png')),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('Navegación',
                style: GoogleFonts.mukta(
                  color: Colors.black54,
                  fontSize: 19,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Inicio',
              style: GoogleFonts.mukta(
                color: AppColors.black,
                fontSize: 19,
              ),
            ),
            onTap: () {
              if (page == 1) {
                Navigator.pop(context);
              } else {
                String name = '';
                _getUserID().then((value) {
                  name = value;
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushReplacementNamed('/home', arguments: {'name': name});
                });
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: Text(
              'Pacientes',
              style: GoogleFonts.mukta(
                color: AppColors.black,
                fontSize: 19,
              ),
            ),
            onTap: () {
              if (page == 2) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacementNamed('/patients');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Perfil y Contacto',
              style: GoogleFonts.mukta(
                color: AppColors.black,
                fontSize: 19,
              ),
            ),
            onTap: () {
              if (page == 3) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacementNamed('/profile');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.device_hub),
            title: Text(
              'Dispositivos',
              style: GoogleFonts.mukta(color: Colors.black, fontSize: 19),
            ),
            onTap: () {
              if (page == 4) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacementNamed('/devices');
              }
            },
          ),
          const Divider(
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('Ayuda',
                style: GoogleFonts.mukta(
                  color: Colors.black54,
                  fontSize: 19,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(
              'Centro de ayuda',
              style: GoogleFonts.mukta(
                color: AppColors.black,
                fontSize: 19,
              ),
            ),
            onTap: () {
              if (page == 5) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacementNamed('/help');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'Acerca de',
              style: GoogleFonts.mukta(
                color: AppColors.black,
                fontSize: 19,
              ),
            ),
            onTap: () {
              if (page == 6) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacementNamed('/about');
              }
            },
          ),
          const Divider(
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('Sesión',
                style: GoogleFonts.mukta(
                  color: Colors.black54,
                  fontSize: 19,
                )),
          ),
          ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Cerrar Sesión',
                style: GoogleFonts.mukta(
                  color: AppColors.black,
                  fontSize: 19,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Splash(2)),
                    (route) => false);
              }),
        ],
      ),
    );
  }

  Future<String> _getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name').toString();
    return name;
  }
}
