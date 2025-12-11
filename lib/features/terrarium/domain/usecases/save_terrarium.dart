import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/repository/terrariums_repository.dart';

class SaveTerrariumUseCase
    extends UseCase<void, TerrariumEntity> {
  final TerrariumRepository _terrariumRepository;

  SaveTerrariumUseCase(this._terrariumRepository);

  @override
  Future<void> call({TerrariumEntity? params}) {
    return _terrariumRepository.saveTerrarium(params!);
  }
}
