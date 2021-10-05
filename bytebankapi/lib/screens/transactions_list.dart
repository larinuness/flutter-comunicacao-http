import 'package:intl/intl.dart';

import '../components/centered_message.dart';
import '../components/progress.dart';
import '../http/webclients/transaction_webclient.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();
  final formatacaoReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Transações'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on,
                              color: Colors.yellow[700]),
                          title: Text(
                            formatacaoReal.format(transaction.value),
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          subtitle: Text(
                            '${transaction.contact.name} | Conta: ${transaction.contact.accountNumber.toString()}',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage(
                'Transações não encontradas',
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage('Erro desconhecido');
        },
      ),
    );
  }
}
