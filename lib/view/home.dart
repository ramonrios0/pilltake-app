import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/models/intakesnamed_model.dart';
import '../utilities/app_colors.dart';
import 'package:movil/widgets/card_shimmer.dart';
import 'package:movil/widgets/drawer.dart';
import 'package:movil/widgets/home_header.dart';
import 'package:movil/widgets/intake_card_named.dart';
import 'package:http/http.dart' as http;

import 'package:movil/variables.dart' as globals;
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _getIntakes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMain(1),
      appBar: AppBar(
        title: Text('Inicio', style: GoogleFonts.mukta(color: AppColors.white)),
        backgroundColor: AppColors.mainRed,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _getIntakes(),
                builder:
                    (context, AsyncSnapshot<IntakesNamedResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const _Shimmer();
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return _HomeBuilder(snapshot.data!.intakes,
                        snapshot.data!.remaining, globals.username);
                  } else {
                    return Center(
                        child: Text(
                            'Ocurrió un error, intentelo de nuevo más tarde',
                            style: GoogleFonts.mukta(
                                fontStyle: FontStyle.italic)));
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<IntakesNamedResponse> _getIntakes() async {
    final url =
        Uri.parse('${globals.url}intakes.php?type=2&id=${globals.userID}');
    final response = await http.get(url);
    return intakesNamedResponseFromJson(response.body);
  }
}

// Contiene el esqueleto de la página, el cual se muestra en el momento de
// consulta y carga de los datos a mostrar

class _Shimmer extends StatelessWidget {
  const _Shimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const HomeHeader(),
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
      SizedBox(
          child: Shimmer.fromColors(
              baseColor: AppColors.white,
              highlightColor: AppColors.loading,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Últimas Ingestas',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mukta(
                    height: 1,
                    fontSize: 25,
                  ),
                ),
              ))),
      const CardShimmer(),
      const CardShimmer(),
    ]);
  }
}

class _HomeBuilder extends StatelessWidget {
  final List<Intake> intakes;
  final List<Intake> remaining;
  final String userName;
  const _HomeBuilder(this.intakes, this.remaining, this.userName);

  @override
  Widget build(BuildContext context) {
    List<Widget> intakeCards = _getCards(intakes);
    List<Widget> remainingCards = _getCards(remaining);

    return FadeIn(
      duration: const Duration(milliseconds: 100),
      child: ListView(
        children: [
          const HomeHeader(),
          Align(
              alignment: const Alignment(-0.9, 0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Próximas Ingestas',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mukta(
                    color: AppColors.black,
                    height: 1,
                    fontSize: 25,
                  ),
                ),
              )),
          Column(children: remainingCards),
          Align(
              alignment: const Alignment(-0.9, 0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Últimas ingestas',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mukta(
                    color: AppColors.black,
                    height: 1,
                    fontSize: 25,
                  ),
                ),
              )),
          Column(children: intakeCards)
        ],
      ),
    );
  }

  List<Widget> _getCards(List<Intake> intakes) {
    List<Widget> cards = [];

    for (int i = 0; i < intakes.length; i++) {
      var intake = intakes[i];
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
      switch (intake.taken) {
        case -1:
          cards.add(IntakeNamed(
              2, intake.name, intake.medicine, finalTime, finalDate));
          break;
        case 0:
          cards.add(IntakeNamed(
              3, intake.name, intake.medicine, finalTime, finalDate));
          break;
        case 1:
          cards.add(IntakeNamed(
              1, intake.name, intake.medicine, finalTime, finalDate));
      }
    }
    cards.isEmpty
        ? cards.add(Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text('No hay ingestas registradas',
                style: GoogleFonts.mukta(
                    fontSize: 20, fontStyle: FontStyle.italic))))
        : null;
    return cards;
  }
}
