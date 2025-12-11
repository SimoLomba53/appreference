import 'package:flutter/material.dart';
import 'package:growingapp/components/btn/rounded_icon_btn.dart';
import 'package:growingapp/components/card/card.dart';
import 'package:growingapp/components/img/local/local_img_wood.dart';
import 'package:growingapp/components/personalization/personalization_section.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

class TerrariumPersonalizeWood extends StatelessWidget {
  final TerrariumEntity terrarium;
  final Function completeSelection;

  const TerrariumPersonalizeWood({super.key, required this.terrarium, required this.completeSelection});

  @override
  Widget build(BuildContext context) {
    return PersonalizationSection(
      title: 'Il tuo ${terrarium.concept} contiene legno?',
      bottomSection: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RoundedIconBtn(
            icon: 'dislike',
            color: const Color(0xFFF27B6D),
            splashColor: Colors.red,
            callback: () {
              completeSelection(false);
            },
          ),
          RoundedIconBtn(
            icon: 'like',
            color: const Color(0xFF0EAE56),
            splashColor: Colors.green,
            callback: () {
              completeSelection(true);
            },
          ),
        ]),
      ),
      child: CardCustom(
        child: LocalImgWood(
          size: MediaQuery.of(context).size.width - 60,
        ),
      ),
    );
  }
}
