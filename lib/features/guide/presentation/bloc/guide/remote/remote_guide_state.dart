import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:growingapp/features/guide/domain/entities/guide.dart';

abstract class RemoteGuidesState extends Equatable {
  final List<GuideEntity>? guides;
  final DioException? error;

  const RemoteGuidesState({this.guides, this.error});

  @override
  List<Object?> get props => [guides, error];
}

class RemoteGuidesLoading extends RemoteGuidesState {
  const RemoteGuidesLoading();
}

class RemoteGuidesDone extends RemoteGuidesState {
  const RemoteGuidesDone(List<GuideEntity> guides)
      : super(guides: guides);
}

class RemoteGuidesError extends RemoteGuidesState {
  const RemoteGuidesError(DioException error) : super(error: error);
}
