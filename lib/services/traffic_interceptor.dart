import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoibWFya21hcHMiLCJhIjoiY2wxYmZzdW0xMDJ2ZzNjcDF6eXg2d2hvYiJ9.R-48TQTd_eRa5iZpeTqdeg';

class TrafficInterceptor extends Interceptor {
  //
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      //
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': 'accessToken',
    });
    super.onRequest(options, handler);
  }
}
