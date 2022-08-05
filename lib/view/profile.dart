import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/models/user.dart';
import 'package:movil/utilities/app_colors.dart';
import 'package:movil/widgets/drawer.dart';
import 'package:movil/widgets/medic_card.dart';
import 'package:movil/widgets/profile_card.dart';
import 'package:movil/widgets/profile_header.dart';
import 'package:http/http.dart' as http;

import 'package:movil/variables.dart' as globals;
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMain(3),
      appBar: AppBar(
          title:
              Text('Perfil', style: GoogleFonts.mukta(color: AppColors.white)),
          backgroundColor: AppColors.mainRed,
          elevation: 0),
      body: FutureBuilder(
        future: _getUserData(),
        builder: (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _Shimmer();
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return _ProfileBuilder(
                snapshot.data!.manager, snapshot.data!.medic);
          } else {
            return Center(
                child: Text('Ocurrió un error, inténtelo de nuevo más tarde',
                    style: GoogleFonts.mukta(fontStyle: FontStyle.italic)));
          }
        },
      ),
    );
  }

  Future<UserResponse> _getUserData() async {
    final url =
        Uri.parse('${globals.url}managers.php?type=4&id=${globals.userID}');
    final response = await http.get(url);
    return userResponseFromJson(response.body);
  }
}

class _ProfileBuilder extends StatelessWidget {
  final List<Manager> manager;
  final List<Manager> medic;

  const _ProfileBuilder(this.manager, this.medic);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ProfileHeader(globals.username),
        Align(
            alignment: const Alignment(-0.9, 0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Datos personales',
                textAlign: TextAlign.left,
                style: GoogleFonts.mukta(
                  color: Colors.black,
                  height: 1,
                  fontSize: 25,
                ),
              ),
            )),
        ProfileCard(manager[0].email, manager[0].contact),
        Align(
            alignment: const Alignment(-0.9, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Text(
                'Contacto de tu médico',
                textAlign: TextAlign.left,
                style: GoogleFonts.mukta(
                  color: Colors.black,
                  height: 1,
                  fontSize: 25,
                ),
              ),
            )),
        MedicCard(medic[0].name, medic[0].email, medic[0].contact)
      ],
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ProfileHeader(globals.username),
      Shimmer.fromColors(
          baseColor: AppColors.white,
          highlightColor: AppColors.loading,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Datos personales',
              textAlign: TextAlign.left,
              style: GoogleFonts.mukta(
                height: 1,
                fontSize: 25,
              ),
            ),
          )),
      Shimmer.fromColors(
        baseColor: AppColors.white,
        highlightColor: AppColors.loading,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, height: 80),
        ),
      ),
      Shimmer.fromColors(
          baseColor: AppColors.white,
          highlightColor: AppColors.loading,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Contacto de tu médico',
              textAlign: TextAlign.left,
              style: GoogleFonts.mukta(
                height: 1,
                fontSize: 25,
              ),
            ),
          )),
      Shimmer.fromColors(
        baseColor: AppColors.white,
        highlightColor: AppColors.loading,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, height: 100),
        ),
      )
    ]);
  }
}
