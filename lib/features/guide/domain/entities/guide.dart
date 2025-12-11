import 'package:equatable/equatable.dart';

class GuideEntity extends Equatable {
  //basic
  final String? id;
  final String? title;
  final String? description;
  final String? toolsDescription;
  final List<String>? tools;
  final List<String>? steps;
  final String? imgUrl;
  final String? videoUrl;

  //match
  final List<String>? plants;
  final List<String>? terrariums;
  final bool? forWood;
  final bool? generic;

  const GuideEntity({
    this.id,
    this.title,
    this.description,
    this.toolsDescription,
    this.tools,
    this.steps,
    this.imgUrl,
    this.videoUrl,
    this.plants,
    this.terrariums,
    this.forWood,
    this.generic,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      toolsDescription,
      tools,
      steps,
      imgUrl,
      videoUrl,
      plants,
      terrariums,
      forWood,
      generic
    ];
  }
}
