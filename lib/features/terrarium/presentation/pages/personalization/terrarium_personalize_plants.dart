import 'package:flutter/material.dart';
import 'package:growingapp/components/btn/rounded_icon_btn.dart';
import 'package:growingapp/components/card/card.dart';
import 'package:growingapp/components/img/local/local_img_plant.dart';
import 'package:growingapp/components/personalization/personalization_section.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

class TerrariumPersonalizePlants extends StatefulWidget {
  final TerrariumEntity terrarium;
  final Function completeSelection;

  const TerrariumPersonalizePlants({
    super.key,
    required this.terrarium,
    required this.completeSelection,
  });

  @override
  State<TerrariumPersonalizePlants> createState() =>
      _TerrariumPersonalizePlantsState();
}

class _TerrariumPersonalizePlantsState
    extends State<TerrariumPersonalizePlants> {
  List<String> actualPlants = [];
  int selectedPlant = 0;

  @override
  Widget build(BuildContext context) {
    return PersonalizationSection(
      title: 'Il tuo ${widget.terrarium.concept} contiene ...',
      bottomSection: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RoundedIconBtn(
            icon: 'dislike',
            color: const Color(0xFFF27B6D),
            splashColor: Colors.red,
            callback: () {
              _selectPlant(present: false);
            },
          ),
          RoundedIconBtn(
            icon: 'like',
            color: const Color(0xFF0EAE56),
            splashColor: Colors.green,
            callback: () {
              _selectPlant(present: true);
            },
          ),
        ]),
      ),
      child: CardCustom(
        child: Column(
          children: [
            LocalImgPlant(
              plant: widget.terrarium.plants![selectedPlant],
              size: MediaQuery.of(context).size.width - 60,
            ),
            Text(
              widget.terrarium.plants![selectedPlant],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  _selectPlant({required bool present}) {
    if (present) {
      setState(() {
        actualPlants.add(widget.terrarium.plants![selectedPlant]);
      });
    }
    if (selectedPlant + 1 < widget.terrarium.plants!.length) {
      setState(() {
        selectedPlant++;
      });
    } else {
      widget.completeSelection(actualPlants);
    }
  }
}
