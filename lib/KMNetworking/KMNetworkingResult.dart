import 'KMNetworkingResultT.dart';

class KMNetworkingResult<T> {
  int code;
  String message;
  T data;

  KMNetworkingResult({this.code, this.message, this.data});

  factory KMNetworkingResult.fromjson(json) {
    return KMNetworkingResult(
      code: json["code"],
      message: json["message"],
      data: KMNetworkingResultT.generateObject(json["data"]),
    );
  }
}
