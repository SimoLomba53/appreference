import 'package:floor/floor.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';

@dao
abstract class TerrariumDao {
  
  @Insert()
  Future<void> insertTerrarium(TerrariumModel terrarium);

  @delete
  Future<void> deleteTerrarium(TerrariumModel terrarium);

  @Query('SELECT * FROM terrarium')
  Future<List<TerrariumModel>> getTerrariums();
  
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTerrarium(TerrariumModel terrarium);
}
