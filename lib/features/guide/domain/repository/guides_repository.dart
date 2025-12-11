import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/features/guide/domain/entities/guide.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

abstract class GuideRepository {
  //API methods
  Future<DataState<List<GuideEntity>>> getGuides({
    String? searchText,
    TerrariumEntity? terrarium,
  });
}
