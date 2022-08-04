import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/widgets/generic_header.dart';
import 'package:http/http.dart' as http;

import '../models/intakes_model.dart';
import '../widgets/card_shimmer.dart';
import '../widgets/intake_card_unamed.dart';
import 'package:movil/variables.dart' as globals;

class PatientTaken extends StatelessWidget {
  const PatientTaken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final patientID = routeArgs['patientID'].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ingestas',
          style: GoogleFonts.mukta(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFFFF3838),
        elevation: 0,
      ),
      body: Column(children: <Widget>[
        const GenericHeader('Últimas 20 Ingestas'),
        Expanded(
            child: FutureBuilder(
          future: _getRemaining(patientID),
          builder:
              (BuildContext context, AsyncSnapshot<IntakesResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _Shimmer();
            } else if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return _ListBuilder(snapshot.data!.intakes);
            } else {
              return Center(
                  child: Text('Ocurrió un error, intentelo de nuevo más tarde',
                      style: GoogleFonts.mukta(fontStyle: FontStyle.italic)));
            }
          },
        ))
      ]),
    );
  }

  Future<IntakesResponse> _getRemaining(String patientID) async {
    final url = Uri.parse('${globals.url}intakes.php?type=1&id=$patientID');
    final response = await http.get(url);
    return intakesResponseFromJson(response.body);
  }
}

class _ListBuilder extends StatelessWidget {
  final List<Intake> intakes;
  const _ListBuilder(this.intakes);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = _getCards(intakes);

    return ListView.builder(
      cacheExtent: 20,
      itemCount: cards.length,
      itemBuilder: (context, i) => FadeInLeft(
          duration: const Duration(milliseconds: 250), child: cards[i]),
    );
  }

  List<Widget> _getCards(List<Intake> intakes) {
    List<Widget> cards = [];

    int success = 0;
    int i = 0;
    do {
      var intake = intakes[i];
      if (intake.taken == 1) {
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
        cards.add(IntakeUnamed(1, intake.medicine, finalTime, finalDate));
        success++;
      }
      i++;
      if (i == intakes.length) {
        if (success == 0) {
          cards.add(Center(
              child: Text('No hay ingestas',
                  style: GoogleFonts.mukta(
                      fontSize: 20, fontStyle: FontStyle.italic))));
        }
        return cards;
      }
    } while (success < 20);

    return cards;
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      CardShimmer(),
      CardShimmer(),
      CardShimmer(),
      CardShimmer(),
    ]);
  }
}
