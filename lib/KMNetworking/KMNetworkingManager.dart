import 'package:dio/dio.dart';
import 'KMNetworkingMethod.dart';
import 'KMNetworkingResultError.dart';
import 'KMNetworkingResult.dart';

final int CONNECT_TIMEOUT = 30 * 1000;
final int RECEIVE_TIMEOUT = 30 * 1000;

// 目前提供get/post/put/delete方法及取消请求方法,
// 缺少上传/下载文件方法

class KMNetworkingManager {
  /// KMNetWorking 单例类
  static final KMNetworkingManager _sharedManager =
      KMNetworkingManager._internal();
  factory KMNetworkingManager() => _sharedManager;

  Dio _dio;

  KMNetworkingManager._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        baseUrl: "http://192.168.2.31:9200",
      );
      _dio = Dio(options);
    }
  }

  Future request<T>(
    KMNetworkingMethod method,
    String url, {
    Map<String, dynamic> header,
    Map<String, dynamic> parameters,
    Function(KMNetworkingResult) success,
    Function(KMNetworkingResultError) error,
    CancelToken cancelToken,
  }) async {
    try {
      Response response = await _dio.request(
        url,
        queryParameters: parameters,
        options: Options(
          method: KMNetworkingMethodValues[method],
          headers: header != null ? header : null,
        ),
        cancelToken: cancelToken,
      );
      if (response != null) {
        KMNetworkingResult result = KMNetworkingResult.fromjson(response.data);
        if (result.code == 200) {
          success(result);
        } else {
          error(KMNetworkingResultError(
              code: result.code, message: result.message));
        }
      } else {
        print("未知错误");
        error(KMNetworkingResultError(code: -1, message: "未知错误"));
      }
    } catch (error) {
      error(createErrorEntity(error));
    }
  }

  cancel(CancelToken cancelToken) {
    cancelToken.cancel("cancelled");
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

class DioErro {}
