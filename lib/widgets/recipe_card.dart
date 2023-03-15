import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PillTake/utilities/app_colors.dart';
import 'package:PillTake/variables.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../models/recipes_model.dart';

class RecipeCard extends StatelessWidget {
  final String id;
  const RecipeCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: _recipes(),
              builder: (BuildContext context,
                  AsyncSnapshot<RecipeResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _Shimmer();
                } else if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return _RecipeBuilder(snapshot.data!.recipe);
                } else {
                  return Center(
                    child: Text(
                      'Ocurrio un error al cargar la receta.',
                      style: GoogleFonts.mukta(fontStyle: FontStyle.italic),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<RecipeResponse> _recipes() async {
    var url = Uri.parse('${globals.url}recipes.php?id=$id');
    var response = await http.get(url);
    return recipeResponseFromJson(response.body);
  }
}

class _RecipeBuilder extends StatelessWidget {
  final List<Recipe> recipe;
  const _RecipeBuilder(this.recipe);

  @override
  Widget build(BuildContext context) {
    List<Widget> recipeText = _getRecipe(recipe);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recipeText.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(child: FadeInLeft(child: recipeText[index]));
      },
    );
  }

  List<Widget> _getRecipe(List<Recipe> recipe) {
    List<Widget> recipeFormatted = [];

    recipeFormatted.add(Text(
      '${recipe[0].medicine1}, ${recipe[0].quant1} cada ${recipe[0].time1} hora(s)',
      style: GoogleFonts.mukta(fontSize: 17, fontWeight: FontWeight.w600),
    ));
    if (recipe[0].medicine2 != null) {
      recipeFormatted.add(Text(
        '${recipe[0].medicine2}, ${recipe[0].quant2} cada ${recipe[0].time2} hora(s)',
        style: GoogleFonts.mukta(fontSize: 17, fontWeight: FontWeight.w600),
      ));
    }
    if (recipe[0].medicine3 != null) {
      recipeFormatted.add(Text(
        '${recipe[0].medicine3}, ${recipe[0].quant3} cada ${recipe[0].time3} hora(s)',
        style: GoogleFonts.mukta(fontSize: 17, fontWeight: FontWeight.w600),
      ));
    }
    if (recipe[0].medicine4 != null) {
      recipeFormatted.add(Text(
        '${recipe[0].medicine4}, ${recipe[0].quant4} cada ${recipe[0].time4} hora(s)',
        style: GoogleFonts.mukta(fontSize: 17, fontWeight: FontWeight.w600),
      ));
    }

    return recipeFormatted;
  }
}

class _Shimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Shimmer.fromColors(
              baseColor: AppColors.white,
              highlightColor: AppColors.loading,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 20,
                ),
              )),
          Shimmer.fromColors(
              baseColor: AppColors.white,
              highlightColor: AppColors.loading,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 20,
                ),
              ))
        ]);
  }
}
