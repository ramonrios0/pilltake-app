import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/licenses_model.dart';
import '../utilities/app_colors.dart';

class Licenses extends StatelessWidget {
  const Licenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainRed,
        elevation: 0,
        title: Text('Licencias', style: GoogleFonts.mukta()),
      ),
      body: FutureBuilder<List<License>>(
        future: loadLicenses(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return _LicensesWidget(snapshot.data);
          } else {
            return Center(
                child: Text('Ocurrió un error, intentelo de nuevo más tarde',
                    style: GoogleFonts.mukta(fontStyle: FontStyle.italic)));
          }
        },
      ),
    );
  }

  Future<List<License>> loadLicenses(BuildContext context) async {
    final bundle = DefaultAssetBundle.of(context);
    final licenses = await bundle.loadString('assets/licenses.json');
    return json
        .decode(licenses)
        .map<License>((license) => License.fromJson(license))
        .toList();
  }
}

class _LicensesWidget extends StatelessWidget {
  final List<License> licenses;
  const _LicensesWidget(
    this.licenses, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 10,
      radius: const Radius.circular(10),
      child: ListView.builder(
        itemCount: licenses.length,
        itemBuilder: (BuildContext context, int index) {
          final license = licenses[index];
          return ListTile(
            title: Text(
              license.title,
              style:
                  GoogleFonts.mukta(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(license.text,
                style: GoogleFonts.mukta(
                  fontSize: 15,
                  height: 1,
                )),
          );
        },
      ),
    );
  }
}
