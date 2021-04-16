import 'KMNetworkingResultT.dart';

class KMNetworkingResultList<T> {
  int code;
  String message;
  List<T> data;

  KMNetworkingResultList({this.code, this.message, this.data});

  factory KMNetworkingResultList.fromJson(json) {
    var listData = <T>[];
    if (json["data"] != null) {
      (json["data"] as List).forEach((element) {
        listData.add(KMNetworkingResultT.generateObject(element));
      });
    }
    return KMNetworkingResultList(
      code: json["code"],
      message: json["msg"],
      data: listData,
    );
  }
}
