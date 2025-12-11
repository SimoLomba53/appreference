abstract class RemoteTerrariumsEvent {
  const RemoteTerrariumsEvent();
}

class GetTerrariums extends RemoteTerrariumsEvent {
  final String? searchText;
  const GetTerrariums({this.searchText});
}
