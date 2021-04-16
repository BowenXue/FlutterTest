import 'KMNetworkingResultT.dart';

class KMNetworkingResultMap<T> {
  int code;
  String message;
  T data;

  KMNetworkingResultMap({this.code, this.message, this.data});

  factory KMNetworkingResultMap.fromjson(json) {
    return KMNetworkingResultMap(
      code: json["code"],
      message: json["message"],
      data: KMNetworkingResultT.generateObject(json["data"]),
    );
  }
}
