import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

abstract class RemoteGuidesEvent {
  const RemoteGuidesEvent();
}

class GetGuides extends RemoteGuidesEvent {
  final String? searchText;
  final TerrariumEntity? terrarium;
  const GetGuides({this.searchText, this.terrarium});
}
