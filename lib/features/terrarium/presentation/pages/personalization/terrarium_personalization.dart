import 'package:flutter/material.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/presentation/pages/personalization/terrarium_personalize_name.dart';
import 'package:growingapp/features/terrarium/presentation/pages/personalization/terrarium_personalize_plants.dart';
import 'package:growingapp/features/terrarium/presentation/pages/personalization/terrarium_personalize_wood.dart';

class TerrariumPersonalization extends StatefulWidget {
  final Function callback;
  final TerrariumEntity originalTerrarium;

  const TerrariumPersonalization({
    super.key,
    required this.originalTerrarium,
    required this.callback,
  });

  @override
  State<TerrariumPersonalization> createState() =>
      _TerrariumPersonalizationState();
}

class _TerrariumPersonalizationState extends State<TerrariumPersonalization> {
  int selectedPageIndex = 0;
  late TerrariumEntity resultTerrarium;

  @override
  void initState() {
    super.initState();
    resultTerrarium =
        widget.originalTerrarium; // Initialize resultTerrarium in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: _buildBody(),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Personalizza il tuo terrario',
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgIcon(
            icon: "arrow-left",
            color: Theme.of(context).textTheme.headlineMedium!.color,
          ),
        ),
      ),
    );
  }

  _buildBody() {
    switch (selectedPageIndex) {
      case 0:
        return _chooseName();
      case 1:
        return _choosePlants();
      case 2:
        return _chooseWood();
    }
  }

  _goToNextSection() {
    if (selectedPageIndex == 0 && widget.originalTerrarium.canVariate!) {
      setState(() {
        selectedPageIndex = 1;
      });
    } else if (selectedPageIndex == 1 &&
        widget.originalTerrarium.canHaveWood!) {
      setState(() {
        selectedPageIndex = 2;
      });
    } else if (selectedPageIndex == 0 &&
        !widget.originalTerrarium.canVariate! &&
        widget.originalTerrarium.canHaveWood!) {
      setState(() {
        selectedPageIndex = 2;
      });
    } else {
      widget.callback(resultTerrarium);
    }
  }

  _chooseName() {
    return TerrariumPersonalizeName(
      terrarium: widget.originalTerrarium,
      completeSelection: (String? name) {
        if (name != null && name != '') {
          setState(() {
            resultTerrarium = TerrariumModel.copyWithDifferentProps(
              resultTerrarium,
              name: name,
            );
          });
        }
        _goToNextSection();
      },
    );
  }

  _choosePlants() {
    return TerrariumPersonalizePlants(
      terrarium: widget.originalTerrarium,
      completeSelection: (List<dynamic> actualPlants) {
        if (actualPlants.isEmpty) {
          actualPlants = resultTerrarium.plants!;
        }
        List<String> actualPlantsString = [];
        for (var plant in actualPlants) {
          actualPlantsString.add(plant.toString());
        }
        setState(() {
          resultTerrarium = TerrariumModel.copyWithDifferentProps(
            resultTerrarium,
            actualPlants: actualPlantsString,
          );
        });
        _goToNextSection();
      },
    );
  }

  _chooseWood() {
    return TerrariumPersonalizeWood(
      terrarium: widget.originalTerrarium,
      completeSelection: (bool result) {
        setState(() {
          resultTerrarium = TerrariumModel.copyWithDifferentProps(
            resultTerrarium,
            haveWood: result,
          );
        });
        _goToNextSection();
      },
    );
  }
}
