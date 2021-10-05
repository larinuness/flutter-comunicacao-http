import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
    //colocando o timeout aqui, ele vira um padrão pra tudo, então não precisa por em outros lugares
    requestTimeout: Duration(seconds: 5));

const String baseUrl = 'http://localhost:8080/transactions';
