import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/utilities/app_colors.dart';
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
  Radius radius = const Radius.circular(10);
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _address = "...";
  String _name = "...";

  void initState() {
    super.initState();
    _getPermission();
    //Obtiene el estado actual de la conexión
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      if (await FlutterBluetoothSerial.instance.isEnabled ?? false) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 221));
      return true;
    }).then((_) {
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    super.dispose();
  }

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
              Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.all(radius),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: AppColors.secondaryRed,
                            borderRadius: BorderRadius.only(
                                topLeft: radius, topRight: radius)),
                        child: Center(
                          child: Text(
                            "Configurar conexión WiFi",
                            style: GoogleFonts.mukta(
                                color: Colors.white, height: 1, fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400]),
                          child: Text("Seleccionar dispositivo",
                              style: GoogleFonts.mukta(
                                  color: Colors.white, fontSize: 16)),
                          onPressed: () async {
                            final BluetoothDevice selectedDevice =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SelectDevice();
                                },
                              ),
                            );

                            if (selectedDevice != null) {
                              print(
                                  'Discovery -> selected ${selectedDevice.address}');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DeviceConfig(
                                        title: "Bluetooth",
                                        deviceAdress: selectedDevice.address);
                                  },
                                ),
                              );
                            } else {
                              print('Discovery -> no device selected');
                            }
                          },
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
