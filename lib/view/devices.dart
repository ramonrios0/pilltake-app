import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PillTake/utilities/app_colors.dart';
import 'package:PillTake/widgets/device_config_menu.dart';
import 'package:PillTake/widgets/patient_rfid.dart';
import 'package:PillTake/widgets/wifi_config_button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/drawer.dart';

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
        body: ListView(
          children: const <Widget>[
            WiFiConfigButton(),
            PatientRFIDConfig(),
            DeviceConfigMenu()
          ],
        ));
  }
}
