import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';
import '../view/device_config.dart';
import '../view/device_select.dart';

class WiFiConfigButton extends StatefulWidget {
  const WiFiConfigButton({super.key});

  @override
  State<WiFiConfigButton> createState() => _WiFiConfigButtonState();
}

class _WiFiConfigButtonState extends State<WiFiConfigButton> {
  Radius radius = const Radius.circular(10);
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _address = "...";
  String _name = "...";

  @override
  void initState() {
    super.initState();
    //Obtiene el estado actual de la conexión
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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

    @override
    void dispose() {
      FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
      super.dispose();
    }

    return Container(
        margin: const EdgeInsets.all(10),
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
                  borderRadius:
                      BorderRadius.only(topLeft: radius, topRight: radius)),
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
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
                child: Text("Seleccionar dispositivo",
                    style:
                        GoogleFonts.mukta(color: Colors.white, fontSize: 16)),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DeviceConfig(
                              title: "Bluetooth",
                              deviceAdress: selectedDevice.address);
                        },
                      ),
                    );
                  } else {}
                },
              ),
            )
          ],
        ));
  }
}
