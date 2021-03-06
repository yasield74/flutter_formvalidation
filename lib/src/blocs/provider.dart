import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/blocs/login_bloc.dart';
export 'package:flutter_formvalidation/src/blocs/login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //busca internanemte en el arbol de widgets del contexto y retorna la instancia del bloc dentro del provider
  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc);
  }
}
