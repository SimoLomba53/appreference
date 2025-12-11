import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/components/detail/detail_section.dart';
import 'package:growingapp/components/detail/terrarium_cure_section.dart';
import 'package:growingapp/components/detail/terrarium_plants_section.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/components/img/firebase/firebase_img.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_bloc.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_event.dart';
import 'package:growingapp/features/terrarium/presentation/pages/personalization/terrarium_personalization.dart';

class AddTerrariumDetail extends StatefulWidget {
  final TerrariumEntity terrarium;

  const AddTerrariumDetail({super.key, required this.terrarium});

  @override
  State<AddTerrariumDetail> createState() => _AddTerrariumDetailState();
}

class _AddTerrariumDetailState extends State<AddTerrariumDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: FirebaseImg(
            path: 'images/terrariums/background',
            image: widget.terrarium.imgUrl!,
          ),
        ),
        _backBtn(),
        Container(
          padding: const EdgeInsets.all(30),
          //height: MediaQuery.of(context).size.height * 0.5,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.terrarium.concept!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const DetailSection(
                  icon: "warning",
                  title: "Attenzione",
                  content: Text(
                    "Tutti i terrari seguono un concept, ma sono pezzi unici. L’artista si riserva il diritto di modificare la composizione a proprio piacimento a seconda dell’ispirazione.",
                    style: TextStyle(
                      color: Color(0xFF998F92),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DetailSection(
                  title: "Concept",
                  content: Text(
                    widget.terrarium.description!,
                    style: const TextStyle(
                      color: Color(0xFF998F92),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TerrariumPlantsSection(terrarium: widget.terrarium),
                const SizedBox(
                  height: 15,
                ),
                TerrariumCureSection(terrarium: widget.terrarium),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
        _addBtn(),
      ],
    );
  }

  _backBtn() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 30,
            height: 30,
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
      ),
    );
  }

  _addBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20),
        child: ElevatedButton(
          onPressed: () {
            _addTerrarium();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60))),
          child: Ink(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff0eae56), Color(0xff2b874b)],
                  stops: [0, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(60)),
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: const Text(
                "Aggiungi ai tuoi Terrari",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addTerrarium() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TerrariumPersonalization(
          originalTerrarium: widget.terrarium,
          callback: (TerrariumModel personalizedTerrarium) {
            var rng = Random();
            String generatedID =
                "${rng.nextInt(100)}${DateTime.now().toString()}"
                    .replaceAll(' ', '');
            TerrariumModel personalTerrarium =
                TerrariumModel.copyWithDifferentProps(
              id: generatedID,
              widget.terrarium,
              name: personalizedTerrarium.name,
              actualPlants: personalizedTerrarium.actualPlants,
              haveWood: personalizedTerrarium.haveWood,
              wateringNotificationsEnabled:
                  personalizedTerrarium.wateringNotificationsEnabled,
            );
            BlocProvider.of<LocalTerrariumsBloc>(context)
                .add(SaveTerrarium(personalTerrarium));
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
