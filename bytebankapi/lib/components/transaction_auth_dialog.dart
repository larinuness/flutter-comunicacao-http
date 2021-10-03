import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({@required this.onConfirm});

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticar'),
      //deixand
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: TextField(
        controller: _passwordController,
        //texto só com numero
        keyboardType: TextInputType.number,
        //deixa o texto no centro
        textAlign: TextAlign.center,
        //não mostrar o texto
        obscureText: true,
        //deixa aceitar no maximo 4 caracteres
        maxLength: 4,
        style: TextStyle(fontSize: 60, letterSpacing: 23),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green))),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar', style: TextStyle(color: Colors.green[900])),
        ),
        TextButton(
          onPressed: () {
            //pega a senha que foi digitada
            widget.onConfirm(_passwordController.text);
            Navigator.of(context).pop();
          },
          child: Text('Confirmar', style: TextStyle(color: Colors.green[900])),
        ),
      ],
    );
  }
}
