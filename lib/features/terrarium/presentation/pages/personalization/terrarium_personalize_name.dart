import 'package:flutter/material.dart';
import 'package:growingapp/components/btn/rounded_icon_btn.dart';
import 'package:growingapp/components/personalization/personalization_section.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

class TerrariumPersonalizeName extends StatefulWidget {
  final TerrariumEntity terrarium;
  final Function completeSelection;

  const TerrariumPersonalizeName(
      {super.key, required this.terrarium, required this.completeSelection});

  @override
  State<TerrariumPersonalizeName> createState() =>
      _TerrariumPersonalizeNameState();
}

class _TerrariumPersonalizeNameState extends State<TerrariumPersonalizeName> {
  final terrariumNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PersonalizationSection(
      title: 'Scegli un nome?',
      bottomSection: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RoundedIconBtn(
            icon: 'dislike',
            color: const Color(0xFFF27B6D),
            splashColor: Colors.red,
            callback: () {
              widget.completeSelection(null);
            },
          ),
          RoundedIconBtn(
            icon: 'like',
            color: const Color(0xFF0EAE56),
            splashColor: Colors.green,
            callback: () {
              widget.completeSelection(terrariumNameController.text);
            },
          ),
        ]),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Inserisci il nome',
          hintText: widget.terrarium.concept!,
          floatingLabelAlignment: FloatingLabelAlignment.center,
        ),
        textAlign: TextAlign.center,
        controller: terrariumNameController,
      ),
    );
  }
}
