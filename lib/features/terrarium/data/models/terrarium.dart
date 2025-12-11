import 'package:floor/floor.dart';
import 'package:growingapp/core/util/list_dynamic_converter.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

@Entity(tableName: 'terrarium', primaryKeys: ['id'])
class TerrariumModel extends TerrariumEntity {
  const TerrariumModel({
    super.id,
    super.concept,
    super.description,
    super.difficulty,
    super.imgUrl,
    super.imgNoBackgroundUrl,
    super.minLux,
    super.minPerfectLux,
    super.maxPerfectLux,
    super.maxLux,
    super.plants,
    super.guides,
    super.canVariate,
    super.canHaveWood,
    super.needWatering,
    super.name,
    super.actualPlants,
    super.haveWood,
    super.wateringNotificationsEnabled,
  });

  factory TerrariumModel.fromJson(Map<String, dynamic> map) {
    return TerrariumModel(
      id: map['id'] ?? "",
      concept: map['concept'] ?? "",
      description: map['description'] ?? "",
      imgUrl: map['imgUrl'] ?? "",
      imgNoBackgroundUrl: map['imgNoBackgroundUrl'] ?? "",
      difficulty: map['difficulty'] ?? "",
      minLux: double.parse(map['minLux'].toString()) ?? 0.0,
      minPerfectLux: double.parse(map['minPerfectLux'].toString()) ?? 1000.0,
      maxPerfectLux: double.parse(map['maxPerfectLux'].toString()) ?? 2000.0,
      maxLux: double.parse(map['maxLux'].toString()) ?? 3000.0,
      plants: listDynamicToType<String>(map['plants']),
      guides: const [],
      canVariate: map['canVariate'] ?? false,
      canHaveWood: map['canHaveWood'] ?? false,
      needWatering: map['needWatering'] ?? false,
      name: map['name'],
      actualPlants:
          listDynamicToType<String>(map['actualPlants'] ?? map['plants']),
      haveWood: map['havewood'],
      wateringNotificationsEnabled: map['wateringNotificationsEnabled'],
    );
  }

  factory TerrariumModel.fromEntity(TerrariumEntity entity) {
    return TerrariumModel(
      id: entity.id,
      concept: entity.concept,
      description: entity.description,
      imgUrl: entity.imgUrl,
      imgNoBackgroundUrl: entity.imgNoBackgroundUrl,
      difficulty: entity.difficulty,
      minLux: entity.minLux,
      minPerfectLux: entity.minPerfectLux,
      maxPerfectLux: entity.maxPerfectLux,
      maxLux: entity.maxLux,
      plants: entity.plants,
      guides: entity.guides,
      canVariate: entity.canVariate,
      canHaveWood: entity.canHaveWood,
      needWatering: entity.needWatering,
      name: entity.name,
      actualPlants: entity.actualPlants,
      haveWood: entity.haveWood,
      wateringNotificationsEnabled: entity.wateringNotificationsEnabled,
    );
  }

  factory TerrariumModel.copyWithDifferentProps(
    TerrariumEntity model, {
    String? id,
    String? concept,
    String? description,
    String? difficulty,
    String? imgUrl,
    String? imgNoBackgroundUrl,
    double? minLux,
    double? minPerfectLux,
    double? maxPerfectLux,
    double? maxLux,
    List<String>? plants,
    List<String>? guides,
    bool? canVariate,
    bool? canHaveWood,
    bool? needWatering,
    String? name,
    List<String>? actualPlants,
    bool? haveWood,
    bool? wateringNotificationsEnabled,
  }) {
    return TerrariumModel(
      id: id ?? model.id,
      concept: concept ?? model.concept,
      description: description ?? model.description,
      imgUrl: imgUrl ?? model.imgUrl,
      imgNoBackgroundUrl: imgNoBackgroundUrl ?? model.imgNoBackgroundUrl,
      difficulty: difficulty ?? model.difficulty,
      minLux: minLux ?? model.minLux,
      minPerfectLux: minPerfectLux ?? model.minPerfectLux,
      maxPerfectLux: maxPerfectLux ?? model.maxPerfectLux,
      maxLux: maxLux ?? model.maxLux,
      plants: plants ?? model.plants,
      guides: guides ?? model.guides,
      canVariate: canVariate ?? model.canVariate,
      canHaveWood: canHaveWood ?? model.canHaveWood,
      needWatering: needWatering ?? model.needWatering,
      name: name ?? model.name,
      actualPlants: actualPlants ?? model.actualPlants,
      haveWood: haveWood ?? model.haveWood,
      wateringNotificationsEnabled:
          wateringNotificationsEnabled ?? model.wateringNotificationsEnabled,
    );
  }
}
