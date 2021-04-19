import 'dart:async';

class Validators {
  // especifico que en el Stream es un String y la salida un string
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      //primer campo es el string y el segundo el sink que es el que dice que info sigue fluyendo o hay que notificar q hay error
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('El password debe tener mas de 6 caracteres');
    }
  });

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
      //primer campo es el string y el segundo el sink que es el que dice que info sigue fluyendo o hay que notificar q hay error
      handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email incorrecto');
    }
  });
}
