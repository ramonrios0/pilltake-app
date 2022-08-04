import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int showHelp = routeArgs['type']!.toInt();

    List<String> helpInfo = setHelpInfo(showHelp);
    return Scaffold(
      appBar: AppBar(
        title: Text(helpInfo[0],
            style: GoogleFonts.mukta(color: Colors.white, fontSize: 20)),
        backgroundColor: const Color(0xFFFF3838),
        elevation: 0,
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: helpInfo.length,
            itemBuilder: (BuildContext context, int i) {
              if (i > 0) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Text(helpInfo[i],
                        style: GoogleFonts.mukta(fontSize: 17)));
              } else {
                return const Text('');
              }
            },
          ),
        ],
      ),
    );
  }

  List<String> setHelpInfo(int type) {
    final List<String> helpInfo;

    switch (type) {
      case 0:
        helpInfo = [
          'Ver datos de un paciente',
          'Para poder consultar los datos de un paciente, el cual tengas asignado a tu cuenta, necesitas ir a la página "Pacientes" a la cual puedes acceder en el menu de navegación lateral. Dentro de esta página presiona la tarjeta del paciente al cual quieres administrar para ir a la pagina "Detalles del paciente".',
          'Dentro de esta página se te mostraran los datos del paciente, el inició y fin de su receta, una gráfica con el total de ingestas, faltas e ingestas restantes y podrás ver un registro de las últimas 20 ingestas, faltas y las próximas 20 ingestas restantes.'
        ];
        break;
      case 1:
        helpInfo = [
          'No aparecen pacientes',
          'Puede haber ocasiones en la que un paciente que se haya registrado no aparezca en la página "Pacientes", esto puede ser debido a algunas cosas:',
          '1.- Si el paciente no tiene una receta asignada no será listado en la página "Pacientes".',
          '2.- Si al momento de asignar una receta a un paciente tienes la aplicación abierta en la pagina "Pacientes" debe cambiar de pagina y regresar o, en su defecto, reiniciar la aplicación para que se actualizen los datos.'
        ];
        break;
      case 2:
        helpInfo = [
          'Cerrar sesión',
          'La aplicación de PillTake cuenta con la función de inicio automático de sesión, como ya podrás haberte percatado, con la finalidad de ahorrar tiempos y permitir un acceso rápido a la información.',
          'En caso de que desees cerrar sesión simplemente presiona la opción "Cerrar sesión" en el menú de navegación lateral. Esto hará que los datos de tu sesión se eliminen y entrarás a la página de inicio de sesión.'
        ];
        break;
      case 3:
        helpInfo = [
          'Conectar a dispositivo',
          'Todavía falta data. Apúrese franklin'
        ];
        break;
      case 4:
        helpInfo = [
          'Configurar dispositivo',
          'Todavía falta data. Apúrese franklin'
        ];
        break;
      default:
        helpInfo = ['A ver, a ver ¿Qué pasó?'];
    }

    return helpInfo;
  }
}
