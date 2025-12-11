import 'package:equatable/equatable.dart';

class TerrariumEntity extends Equatable {
  //basic
  final String? id;
  final String? concept;
  final String? description;
  final String? imgUrl;
  final String? imgNoBackgroundUrl;
  final String? difficulty;

  //cure
  final double? minLux;
  final double? minPerfectLux;
  final double? maxPerfectLux;
  final double? maxLux;
  final List<String>? plants;
  final List<String>? guides;

  //personalization and custom guides
  final bool? canVariate;
  final bool? canHaveWood;
  final bool? needWatering;

  //personal
  final String? name;
  final List<String>? actualPlants;
  final bool? haveWood;
  final bool? wateringNotificationsEnabled;

  const TerrariumEntity({
    this.id,
    this.concept,
    this.description,
    this.imgUrl,
    this.imgNoBackgroundUrl,
    this.difficulty,
    this.minLux,
    this.minPerfectLux,
    this.maxPerfectLux,
    this.maxLux,
    this.plants,
    this.guides,
    this.canVariate,
    this.canHaveWood,
    this.needWatering,
    this.name,
    this.actualPlants,
    this.haveWood,
    this.wateringNotificationsEnabled,
  });

  @override
  List<Object?> get props {
    return [
      id,
      concept,
      description,
      imgUrl,
      difficulty,
      imgNoBackgroundUrl,
      minLux,
      minPerfectLux,
      maxPerfectLux,
      maxLux,
      plants,
      guides,
      canVariate,
      canHaveWood,
      needWatering,
      name,
      actualPlants,
      haveWood,
      wateringNotificationsEnabled
    ];
  }
}
