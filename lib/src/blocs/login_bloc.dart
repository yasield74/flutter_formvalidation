import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_formvalidation/src/blocs/validators.dart';

//esta clase es de utilidad y me simplifica el codigo usando los get para obtener directo las funciones
//que yo necesito para trabajar

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertarle los valores al Stream, es un get que retorna una funcion de la calse Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    // el ? evita el .close cuando _email es nulo, asi se evita un error
    _emailController?.close();
    _passwordController?.close();
  }
}
