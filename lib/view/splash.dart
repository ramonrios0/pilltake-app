// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movil/variables.dart' as globals;
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

import '../models/intakesnamed_model.dart';
import '../utilities/app_colors.dart';
import '../forms/form_login.dart';
import '../notifications.dart';

NotificationApi notifications = NotificationApi();

@pragma('vm:entry-point')
void callbackDispatcher() {
  /*
   * Aquí se maneja el script que se ejecuta en segundo plano.
   * Este se ejecuta en un intervalo de 15 minutos y sirve para verificar si existen
   * medicinas que se deban de dispensar y, en el caso de ser correcto, enviar una
   * notificación local al télefono.
   * Hay tres revisiones, cada una con una notificación en caso de que sus condiciones
   * sean verdaderas:
   * 
   *  1.- La primera verifica si el tiempo actual es menor al tiempo de ingesta del
   *      medicamento, en caso de ser verdadero procede a verificar si el tiempo
   *      entre la hora de ingesta y ahora es menor a 30 minutos. De ser correcto
   *      manda una notificación mostrando que el medicamento ya se puede dispensar.
   *  2.- La segunda verifica si el tiempo actual es mayor al tiempo de ingesta del
   *      medicamento, en caso de ser verdadero procede a verificar si la diferencia
   *      entre el tiempo de ingesta y el tiempo actual no es mayor de una hora. En
   *      caso de ser correcto se manda una notificación al télefono recordando al
   *      usuario de dispensar el medicamento.
   *  3.- La tercera verifica si la diferencia entre el tiempo actual y la hora de
   *      ingesta es mayor de una hora. En caso de ser correcto se envia una petición
   *      http a la api para cambiar el estado de la ingesta a -1 (No ingerido) y 
   *      manda una notificación al telefono avisando al usuario que la ingesta no
   *      se hizo.
   * 
   * En caso de que ninguna de las verificaciones anteriores sea verdadera, se
   * supondra que el tiempo de ingesta aún no es lo suficientemente próximo como
   * para recordar al usuario de la toma.
   */
  Workmanager().executeTask((taskName, inputData) async {
    final url =
        Uri.parse('${globals.url}intakes.php?type=2&id=${inputData!['id']}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      IntakesNamedResponse intakeResponse =
          intakesNamedResponseFromJson(response.body);
      List<Intake> remaining = intakeResponse.remaining;
      if (remaining.isNotEmpty) {
        for (int i = 0; i < remaining.length; i++) {
          var intake = remaining[i];
          DateTime now = DateTime.now();
          DateTime intakeTime = DateTime.parse(intake.time.toString());
          const Duration firstVerification = Duration(minutes: 30);
          const Duration secondVerificacion = Duration(minutes: 30);
          // Primera verificación
          if ((now.isBefore(intakeTime)) &&
              (intakeTime.difference(now) <= firstVerification)) {
            notifications.sendNotification('Ya se puede dispensar',
                '${intake.medicine} para ${intake.name}');
          }
          // Segunda verificación
          else if ((now.isAfter(intakeTime)) &&
              (now.difference(intakeTime) <= secondVerificacion)) {
            notifications.sendNotification('No se ha dispensado',
                '${intake.medicine} para ${intake.name}');
          }
          // Tercera verificación
          else if ((now.isAfter(intakeTime.add(const Duration(minutes: 30))))) {
            final url = Uri.parse(
                '${globals.url}intakes.php?type=3&id=${intake.idIngesta}');
            final response = await http.get(url);
            if (response.statusCode == 200) {
              notifications.sendNotification(
                  'No se dispensó', '${intake.medicine} para ${intake.name}');
            }
          }
        }
      }
    } else {
      return Future.value(true);
    }
    return Future.value(true);
  });
}

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
    notifications.initNotifications();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 1), () => _validate(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainRed,
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
                decoration: const BoxDecoration(color: AppColors.secondaryRed),
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
              color: AppColors.secondaryRed,
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
          Workmanager().registerPeriodicTask(
              "pilltake.notifications", "IntakesChecking",
              inputData: <String, String>{"id": id});
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
