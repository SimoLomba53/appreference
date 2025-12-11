import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/repository/terrariums_repository.dart';

class GetSavedTerrariumsUseCase
    extends UseCase<List<TerrariumEntity>, void> {
  final TerrariumRepository _terrariumRepository;

  GetSavedTerrariumsUseCase(this._terrariumRepository);

  @override
  Future<List<TerrariumEntity>> call({void params}) {
    return _terrariumRepository.getSavedTerrariums();
  }
}
