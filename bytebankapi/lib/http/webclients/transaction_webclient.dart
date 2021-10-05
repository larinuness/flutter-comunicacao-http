import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    //encode vai devolver uma String que vai representar o json
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 2));

    final Response response = await client.post(
      Uri.parse(baseUrl),
      headers: {
        //esse password faz parte da integração entre formulário e dialog
        'Content-type': 'application/json',
        'password': password,
      },
      //convertemos o objeto em json
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    //quando não preenchemos valor de transferência
    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submiting transaction',
    401: 'authentication failed',
    409: 'transaction always exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
