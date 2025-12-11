import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

abstract class TerrariumRepository {
  //API methods
  Future<DataState<List<TerrariumEntity>>> getTerrariums({String? searchText});

  //Database methods
  Future<List<TerrariumEntity>> getSavedTerrariums();

  Future<void> saveTerrarium(TerrariumEntity terrarium);
  
  Future<void> removeTerrarium(TerrariumEntity terrarium);

  Future<void> updateTerrarium(TerrariumEntity terrarium);
}
