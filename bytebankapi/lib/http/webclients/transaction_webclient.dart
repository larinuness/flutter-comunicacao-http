import 'dart:convert';

import '../webclient.dart';
import '../../models/transaction.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(
      Transaction transaction, String password, BuildContext context) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);
        
    if (response.statusCode == 400) {
      throw Exception('Ocorreu um erro durante a transação');
    }

    if (response.statusCode == 401) {
      throw Exception('Autenticação falhou');
    }
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
