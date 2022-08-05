/*
 * patient_details.dart
 * 
 * Aquí se muestran los detalles del paciente que se selecciono en la
 * pantalla de pacientes
 * 
 */
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movil/variables.dart' as globals;
import 'package:shimmer/shimmer.dart';

import '../models/intakes_model.dart';
import '../utilities/app_colors.dart';
import '../widgets/bar_chart.dart';
import '../widgets/intake_card_unamed.dart';
import '../widgets/patient_header.dart';
import '../widgets/card_shimmer.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({Key? key}) : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final patientName = routeArgs['name'].toString();
    final initDate = routeArgs['initDate'].toString();
    final finalDate = routeArgs['finalDate'].toString();
    final patientID = routeArgs['patientID'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del paciente',
            style: GoogleFonts.mukta(color: AppColors.white, fontSize: 20)),
        backgroundColor: AppColors.mainRed,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _getIntakes(patientID),
        builder:
            (BuildContext context, AsyncSnapshot<IntakesResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _Shimmer(patientName, initDate, finalDate, patientID);
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return _DetailsBuilder(snapshot.data!.intakes, patientName,
                initDate, finalDate, patientID);
          } else {
            return Center(
                child: Text('Ocurrió un error, intentelo de nuevo más tarde',
                    style: GoogleFonts.mukta(fontStyle: FontStyle.italic)));
          }
        },
      ),
    );
  }

  Future<IntakesResponse> _getIntakes(String patientID) async {
    final url = Uri.parse('${globals.url}intakes.php?type=1&id=$patientID');
    final response = await http.get(url);
    return intakesResponseFromJson(response.body);
  }
}

class _DetailsBuilder extends StatelessWidget {
  final List<Intake> intakes;
  final String patientName, initDate, finalDate, patientID;
  const _DetailsBuilder(this.intakes, this.patientName, this.initDate,
      this.finalDate, this.patientID);

  @override
  Widget build(BuildContext context) {
    List<double> intakeData = _getIntakeData(intakes);
    List<Widget> cards = _getCards(intakes);
    return ListView(
      children: <Widget>[
        PatientHeader(patientName, initDate, finalDate),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              'Estadísticas',
              style: GoogleFonts.mukta(
                  color: AppColors.black, fontSize: 25, height: 1),
            )),
// Gráfica de estadísticas
        FadeInLeft(
            duration: const Duration(milliseconds: 250),
            child: DetailsChart(intakeData[0], intakeData[1], intakeData[2])),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .45,
                    child: ElevatedButton(
                      child: const Text('Ver últimas ingestas'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            '/patients/details/taken',
                            arguments: {'patientID': patientID});
                      },
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .45,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.mainRed),
                      child: const Text('Ver últimas faltas'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            '/patients/details/untaken',
                            arguments: {'patientID': patientID});
                      },
                    )))
          ],
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Próximas ingestas',
              style: GoogleFonts.mukta(
                  color: AppColors.black, fontSize: 25, height: 1),
            )),
        // --- Tarjetas de ingestas ---
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int i) {
            return FadeInLeft(
                delay: const Duration(milliseconds: 50),
                duration: const Duration(milliseconds: 250),
                child: cards[i]);
          },
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        '/patients/details/all-intakes',
                        arguments: {'patientID': patientID});
                  },
                  style: ElevatedButton.styleFrom(primary: AppColors.gray),
                  child: const Text('Próximas ingestas'),
                )))
      ],
    );
  }

  List<double> _getIntakeData(List<Intake> intakes) {
    double taken = 0, untaken = 0, remain = 0;

    for (int i = 0; i < intakes.length; i++) {
      var intake = intakes[i];
      switch (intake.taken) {
        case -1:
          untaken++;
          break;
        case 0:
          remain++;
          break;
        case 1:
          taken++;
      }
    }
    return [taken, untaken, remain];
  }

  List<Widget> _getCards(List<Intake> intakes) {
    List<Widget> cards = [];

    int success = 0;
    int i = 0;
    do {
      var intake = intakes[i];
      if (intake.taken == 0) {
        var dateTime = intake.time.toString().split(' ');
        var time = dateTime[1].split(':');
        var date = dateTime[0].split('-');
        var finalTime = '';
        var finalDate = '${date[2]}/${date[1]}/${date[0]}';
        if (int.parse(time[0]) > 12) {
          var hour = int.parse(time[0]) - 12;
          finalTime = '$hour:${time[1]} PM';
        } else {
          finalTime = '${time[0]}:${time[1]} AM';
        }
        cards.add(IntakeUnamed(3, intake.medicine, finalTime, finalDate));
        success++;
      }
      i++;
      if (i == intakes.length) {
        if (cards.isEmpty) {
          cards.add(Center(
            child: Text('No hay próximas ingestas',
                style: GoogleFonts.mukta(
                    fontSize: 20, fontStyle: FontStyle.italic)),
          ));
        }
        return cards;
      }
    } while (success < 3);

    return cards;
  }
}

class _Shimmer extends StatelessWidget {
  final String patientName, initDate, finalDate, patientID;
  const _Shimmer(
    this.patientName,
    this.initDate,
    this.finalDate,
    this.patientID, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      PatientHeader(patientName, initDate, finalDate),
      SizedBox(
          child: Shimmer.fromColors(
              baseColor: AppColors.white,
              highlightColor: AppColors.loading,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Estadisticas',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mukta(
                    height: 1,
                    fontSize: 25,
                  ),
                ),
              ))),
      Shimmer.fromColors(
        baseColor: AppColors.white,
        highlightColor: AppColors.loading,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, height: 200),
        ),
      ),
      Row(
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.white,
            highlightColor: AppColors.loading,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.48, height: 40),
            ),
          ),
          Shimmer.fromColors(
            baseColor: AppColors.white,
            highlightColor: AppColors.gray,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.48, height: 40),
            ),
          )
        ],
      ),
      SizedBox(
          child: Shimmer.fromColors(
              baseColor: AppColors.white,
              highlightColor: AppColors.loading,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Próximas Ingestas',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mukta(
                    height: 1,
                    fontSize: 25,
                  ),
                ),
              ))),
      const CardShimmer(),
      const CardShimmer(),
      Shimmer.fromColors(
        baseColor: AppColors.white,
        highlightColor: AppColors.loading,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, height: 40),
        ),
      )
    ]);
  }
}
