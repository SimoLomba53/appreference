import 'package:growingapp/core/util/list_dynamic_converter.dart';
import 'package:growingapp/features/guide/domain/entities/guide.dart';

class GuideModel extends GuideEntity {
  const GuideModel({
    super.id,
    super.title,
    super.description,
    super.toolsDescription,
    super.tools,
    super.steps,
    super.imgUrl,
    super.videoUrl,
    super.plants,
    super.terrariums,
    super.forWood,
    super.generic,
  });

  factory GuideModel.fromJson(Map<String, dynamic> map) {
    return GuideModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      toolsDescription: map['toolsDescription'] ?? "",
      tools: listDynamicToType<String>(map['tools']),
      steps: listDynamicToType<String>(map['steps']),
      imgUrl: map['imgUrl'] ?? "",
      videoUrl: map['videoUrl'] ?? "",
      plants: listDynamicToType<String>(map['plants']),
      terrariums: listDynamicToType<String>(map['terrariums']),
      forWood: map['forWood'] ?? false,
      generic: map['generic'] ?? false,
    );
  }

  factory GuideModel.fromEntity(GuideEntity entity) {
    return GuideModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      toolsDescription: entity.toolsDescription,
      tools: entity.tools,
      steps: entity.steps,
      imgUrl: entity.imgUrl,
      videoUrl: entity.videoUrl,
      plants: entity.plants,
      terrariums: entity.terrariums,
      forWood: entity.forWood,
      generic: entity.generic,
    );
  }

  factory GuideModel.copyWithDifferentProps(
    GuideEntity model, {
    String? id,
    String? title,
    String? description,
    String? toolsDescription,
    List<String>? tools,
    List<String>? steps,
    String? imgUrl,
    String? videoUrl,
    List<String>? plants,
    List<String>? terrariums,
    bool? forWood,
    bool? generic,
  }) {
    return GuideModel(
      id: id?? model.id,
      title: title?? model.title,
      description: description?? model.description,
      toolsDescription: toolsDescription?? model.toolsDescription,
      tools: tools?? model.tools,
      steps: steps?? model.steps,
      imgUrl: imgUrl?? model.imgUrl,
      videoUrl: videoUrl?? model.videoUrl,
      plants: plants?? model.plants,
      terrariums: terrariums?? model.terrariums,
      forWood: forWood?? model.forWood,
      generic: generic ?? model.generic,
    );
  }
}
