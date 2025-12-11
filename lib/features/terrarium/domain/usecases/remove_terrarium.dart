import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/repository/terrariums_repository.dart';

class RemoveTerrariumUseCase
    extends UseCase<void, TerrariumEntity> {
  final TerrariumRepository _terrariumRepository;

  RemoveTerrariumUseCase(this._terrariumRepository);

  @override
  Future<void> call({TerrariumEntity? params}) {
    return _terrariumRepository.removeTerrarium(params!);
  }
}
