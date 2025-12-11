import 'package:equatable/equatable.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

abstract class LocalTerrariumsEvent extends Equatable {
  final TerrariumEntity? terrarium;

  const LocalTerrariumsEvent({this.terrarium});

  @override
  List<Object?> get props => [terrarium];
}

class GetSavedTerrariums extends LocalTerrariumsEvent {
  const GetSavedTerrariums();
}

class RemoveTerrarium extends LocalTerrariumsEvent {
  const RemoveTerrarium(TerrariumEntity terrarium) : super(terrarium: terrarium);
}

class SaveTerrarium extends LocalTerrariumsEvent {
  const SaveTerrarium(TerrariumEntity terrarium)
      : super(terrarium: terrarium);
}

class UpdateTerrarium extends LocalTerrariumsEvent {
  const UpdateTerrarium(TerrariumEntity terrarium) : super(terrarium: terrarium);
}
