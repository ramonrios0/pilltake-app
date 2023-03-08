import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/utilities/app_colors.dart';
import 'package:movil/widgets/device_config_menu.dart';
import 'package:movil/widgets/patient_rfid.dart';
import 'package:movil/widgets/wifi_config_button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/drawer.dart';
import 'device_config.dart';
import 'device_select.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  void _getPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location
    ].request();
    if (await Permission.bluetooth.isDenied) {
      const SnackBar(content: Text('Bluetooth desactivado'));
    }
  }

  @override
  void initState() {
    _getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerMain(4),
        appBar: AppBar(
          title: Text(
            "Dispositivos",
            style: GoogleFonts.mukta(color: AppColors.white),
          ),
          backgroundColor: AppColors.mainRed,
          elevation: 0,
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              WiFiConfigButton(),
              PatientRFIDConfig(),
              DeviceConfigMenu()
            ],
          ),
        ));
  }
}
