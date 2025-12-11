// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _GuideApiService implements GuideApiService {
  _GuideApiService(
    this._dio) {
    baseUrl ??= 'https://server.it/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<GuideModel>>> getGuides({
    String? searchText,
    TerrariumEntity? terrarium,
  }) async {
    //var result = guidesJSONMock;
    //var value = result
    //    .map((dynamic i) => GuideModel.fromJson(i as Map<String, dynamic>))
    //    .toList();
    CollectionReference terrariums =
        FirebaseFirestore.instance.collection('guides');
    QuerySnapshot querySnapshot = await terrariums.get();
    var value = querySnapshot.docs
        .map((doc) => GuideModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    if (terrarium != null) {
      value = value
          .where(
            (guide) =>
                guide.generic! ||
                (guide.forWood! ? (terrarium.haveWood ?? false) : false) ||
                guide.terrariums!.contains(terrarium.concept!.toLowerCase()) ||
                terrarium.plants!.any(
                    (plant) => guide.plants!.contains(plant.toLowerCase())),
          )
          .toList();
    }
    if (searchText != null && searchText.isNotEmpty) {
      value = value
          .where(
            (element) =>
                searchText.split(' ').any((word) => element.title!
                    .toLowerCase()
                    .contains(word.toLowerCase())) ||
                searchText.split(' ').any((word) => element.description!
                    .toLowerCase()
                    .contains(word.toLowerCase())),
          )
          .toList();
    }
    final httpResponse = HttpResponse(
      value,
      Response(
        data: value,
        requestOptions: RequestOptions(),
        statusCode: HttpStatus.ok,
      ),
    );
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
