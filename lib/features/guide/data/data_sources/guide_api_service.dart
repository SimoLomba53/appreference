import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growingapp/core/constants/constants.dart';
import 'package:growingapp/features/guide/data/models/guide.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'guide_api_service.g.dart';

@RestApi(baseUrl: guidesAPIBaseUrl)
abstract class GuideApiService {
  factory GuideApiService(Dio dio) = _GuideApiService;

  @GET('/guides')
  Future<HttpResponse<List<GuideModel>>> getGuides({
    String? searchText,
    TerrariumEntity? terrarium,
  });
}
