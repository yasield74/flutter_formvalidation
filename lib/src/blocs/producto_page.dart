import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:flutter_formvalidation/src/provider/productos_provider.dart';
import 'package:flutter_formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  //se crea una key con la especificacion que sea para controlar
  // un form state
  //siempre se hace de esta manera

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductoModel producto = new ProductoModel();
  final productoProvider = new ProductosProvider();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (val) => producto.titulo = val,
      validator: (val) {
        //si se retorna un string ese es el error en la validacion
        //si se retorna null entonces es que todo esta bien
        if (val.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),

      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Precio'),
      //la funcion onSaved se ejecuta unicamente despues de validado el formulario
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (val) {
        if (utils.isNumeric(val)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.save), Text('Guardar')],
        ),
        onPressed: (_guardando) ? null : _submit);
  }

  void _submit() {
    //si el formulario no es valido hago un return vacio
    if (!formKey.currentState.validate()) return;

    //si la linea de arriba no se ejecuto entonces sigue para estas de abajo
    //esta instruccion dispara el metodo onsave de cada textfiel del formulario
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    if (producto.id == null) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }

    mostrarSnackBar('Registro Guardado ');
    Navigator.pop(context);
  }

  Widget _crearDisponible() {
    return SwitchListTile(
        value: producto.disponible,
        title: Text('Disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (val) {
          setState(() {
            producto.disponible = val;
          });
        });
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
