import 'package:dio/dio.dart';
import 'KMNetworkingMethod.dart';
import 'KMNetworkingResultError.dart';
import 'KMNetworkingResultList.dart';
import 'KMNetworkingResultMap.dart';

final int CONNECT_TIMEOUT = 30 * 1000;
final int RECEIVE_TIMEOUT = 30 * 1000;

class KMNetworkingManager {
  /// KMNetWorking 单例类
  static final KMNetworkingManager _sharedManager =
      KMNetworkingManager._internal();
  factory KMNetworkingManager() => _sharedManager;

  Dio dio;

  KMNetworkingManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        baseUrl: "http://192.168.2.31:9200",
      );
      dio = Dio(options);
    }
  }

  // 请求，返回参数为 T
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future request<T>(KMNetworkingMethod method, String uri,
      {Map<String, dynamic> header,
      Map<String, dynamic> parameters,
      Function(T) success,
      Function(KMNetworkingResultError) error}) async {
    try {
      Response response = await dio.request(uri,
          queryParameters: parameters,
          options: Options(
            method: KMNetworkingMethodValues[method],
            headers: header != null ? header : null,
          ));
      if (response != null) {
        print(response);
        KMNetworkingResultMap resultMap =
            KMNetworkingResultMap.fromjson(response.data);
        if (resultMap.code == 200) {
          success(resultMap.data);
        } else {
          error(KMNetworkingResultError(
              code: resultMap.code, message: resultMap.message));
        }
      } else {
        print("未知错误");
        error(KMNetworkingResultError(code: -1, message: "未知错误"));
      }
    } catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 请求，返回参数为 List<T>
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future requestList<T>(KMNetworkingMethod method, String path,
      {Map<String, dynamic> header,
      Map<String, dynamic> parameters,
      Function(List<T>) success,
      Function(KMNetworkingResultError) error}) async {
    try {
      Response response = await dio.request(path,
          queryParameters: parameters,
          options: Options(
            method: KMNetworkingMethodValues[method],
            headers: header,
          ));
      if (response != null) {
        KMNetworkingResultList entity =
            KMNetworkingResultList<T>.fromJson(response.data);
        if (entity.code == 0) {
          success(entity.data);
        } else {
          error(KMNetworkingResultError(
              code: entity.code, message: entity.message));
        }
      } else {
        error(KMNetworkingResultError(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  KMNetworkingResultError createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return KMNetworkingResultError(code: -1, message: "请求取消");
        }
        break;
      case DioErrorType.connectTimeout:
        {
          return KMNetworkingResultError(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.sendTimeout:
        {
          return KMNetworkingResultError(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.receiveTimeout:
        {
          return KMNetworkingResultError(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.response:
        {
          try {
            int errCode = error.response.statusCode;
            String errMsg = error.response.statusMessage;
            return KMNetworkingResultError(code: errCode, message: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(code: errCode, message: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(code: errCode, message: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(code: errCode, message: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(code: errCode, message: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(code: errCode, message: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(code: errCode, message: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(code: errCode, message: "未知错误");
//            }
//          }
          } on Exception catch (_) {
            return KMNetworkingResultError(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return KMNetworkingResultError(code: -1, message: error.message);
        }
    }
  }
}
