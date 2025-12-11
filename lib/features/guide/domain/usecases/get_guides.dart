import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/guide/domain/entities/guide.dart';
import 'package:growingapp/features/guide/domain/repository/guides_repository.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

class GetGuidesUseCaseInputParam {
  String? searchText;
  TerrariumEntity? terrarium;

  GetGuidesUseCaseInputParam({this.searchText, this.terrarium});
}

class GetGuidesUseCase
    extends UseCase<DataState<List<GuideEntity>>, GetGuidesUseCaseInputParam?> {
  final GuideRepository _guideRepository;

  GetGuidesUseCase(this._guideRepository);

  @override
  Future<DataState<List<GuideEntity>>> call(
      {GetGuidesUseCaseInputParam? params}) {
    return _guideRepository.getGuides(
      searchText: params?.searchText,
      terrarium: params?.terrarium,
    );
  }
}
