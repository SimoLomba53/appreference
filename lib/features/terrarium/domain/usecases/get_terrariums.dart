import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/repository/terrariums_repository.dart';

class GetTerrariumsUseCase
    extends UseCase<DataState<List<TerrariumEntity>>, String> {
  final TerrariumRepository _terrariumRepository;

  GetTerrariumsUseCase(this._terrariumRepository);

  @override
  Future<DataState<List<TerrariumEntity>>> call({dynamic params}) {
    return _terrariumRepository.getTerrariums(searchText: params);
  }
}
