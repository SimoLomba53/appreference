import 'package:flutter/material.dart';
import 'package:growingapp/components/detail/detail_section.dart';
import 'package:growingapp/components/detail/guide_tool_section.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/components/img/firebase/firebase_img.dart';
import 'package:growingapp/components/step/step_list.dart';
import 'package:growingapp/features/guide/domain/entities/guide.dart';

class GuideDetail extends StatefulWidget {
  final GuideEntity guide;

  const GuideDetail({super.key, required this.guide});

  @override
  State<GuideDetail> createState() => _GuideDetailState();
}

class _GuideDetailState extends State<GuideDetail> {
  int selectedIndex = 0;
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
          width: double.infinity,
          child: FirebaseImg(
            path: 'images/guides',
            image: widget.guide.imgUrl!,
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
                  widget.guide.title!,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DetailSection(
                  title: 'Descrizione',
                  content: Text(
                    widget.guide.description!,
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
                if (widget.guide.toolsDescription != null &&
                    widget.guide.toolsDescription!.isNotEmpty) ...[
                  GuideToolSection(guide: widget.guide),
                  const SizedBox(
                    height: 15,
                  ),
                ],
                if (widget.guide.steps != null &&
                    widget.guide.steps!.isNotEmpty) ...[
                  StepCustomList(
                    steps: widget.guide.steps!,
                  ),
                ],
              ],
            ),
          ),
        ),
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
}
