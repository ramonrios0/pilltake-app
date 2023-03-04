// ignore_for_file: must_be_immutable

/*
 * widgets/device_card.dart
 * 
 * Esta tarjeta se usa para informar al administrador si el paciente ha tomado 
 * o no algún medicamento. Esta se usa en el menú de detalles del paciente.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';

class BluetoothDeviceList extends ListTile {
  BluetoothDeviceList(
      {super.key,
      required BluetoothDevice device,
      required rssi,
      required GestureTapCallback onTap,
      bool enabled = true})
      : super(
            onTap: onTap,
            enabled: enabled,
            leading: const Icon(Icons.device_hub),
            title: Text(device.name ?? "Desconocido",
                style: GoogleFonts.mukta(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(device.address.toString(),
                style: GoogleFonts.mukta(
                  color: Colors.black,
                  fontSize: 10,
                  height: 1,
                )),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                rssi != null
                    ? Container(
                        margin: const EdgeInsets.all(8.0),
                        child: DefaultTextStyle(
                          style: _computeTextStyle(rssi),
                          child: const Text('dBm'),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                device.isConnected
                    ? const Icon(Icons.import_export)
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                device.isBonded
                    ? const Icon(Icons.link)
                    : const SizedBox(width: 0, height: 0)
              ],
            ));

  static TextStyle _computeTextStyle(int rssi) {
    /**/ if (rssi >= -35) {
      return TextStyle(color: Colors.greenAccent[700]);
    } else if (rssi >= -45) {
      return TextStyle(
          color: Color.lerp(
              Colors.greenAccent[700], Colors.lightGreen, -(rssi + 35) / 10));
    } else if (rssi >= -55) {
      return TextStyle(
          color: Color.lerp(
              Colors.lightGreen, Colors.lime[600], -(rssi + 45) / 10));
    } else if (rssi >= -65) {
      return TextStyle(
          color: Color.lerp(Colors.lime[600], Colors.amber, -(rssi + 55) / 10));
    } else if (rssi >= -75) {
      return TextStyle(
          color: Color.lerp(
              Colors.amber, Colors.deepOrangeAccent, -(rssi + 65) / 10));
    } else if (rssi >= -85) {
      return TextStyle(
          color: Color.lerp(
              Colors.deepOrangeAccent, Colors.redAccent, -(rssi + 75) / 10));
    } else {
      return const TextStyle(color: Colors.redAccent);
    }
  }
/*  final String text;
  double cardHeight = 80;

  DeviceCard(this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          color: AppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: cardHeight,
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed('devices/config'),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            text,
                            style: GoogleFonts.mukta(
                              color: AppColors.black,
                              height: 1,
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }*/
}
