import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/widgets/device_card.dart';

import '../utilities/app_colors.dart';
import '../widgets/drawer.dart';

class SelectDevice extends StatefulWidget {
  final bool start;
  const SelectDevice({super.key, this.start = true});

  @override
  State<SelectDevice> createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {
  late StreamSubscription<BluetoothDiscoveryResult> _subscription;
  List<BluetoothDiscoveryResult> results = [];
  late bool isDiscovering;

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _restartDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });
    _startDiscovery();
  }

  void _startDiscovery() {
    _subscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        if (r.device.isBonded) {
          results.add(r);
        }
      });
    });
    _subscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? Text('Buscando dispositivos',
                style: GoogleFonts.mukta(color: AppColors.white))
            : Text('Dispositivos encontrados',
                style: GoogleFonts.mukta(color: AppColors.white)),
        backgroundColor: AppColors.mainRed,
        elevation: 0,
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          return BluetoothDeviceList(
            device: result.device,
            rssi: result.rssi,
            onTap: () {
              Navigator.of(context).pop(result.device);
            },
          );
        },
      ),
    );
  }
}
