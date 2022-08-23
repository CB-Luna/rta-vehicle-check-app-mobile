import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class RegistroController extends ChangeNotifier {

  List<ProductosEmp> productosEmp= [];

  GlobalKey<FormState> productoEmpFormKey = GlobalKey<FormState>();
 
  //ProductoEmp
  String imagen = '';
  String nombre = '';
  String descripcion = '';
  String costo = '';
  int precioVenta = 0;
  String cantidad = '';
  String proveedor = '';

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> productoEmpKey) {
    return productoEmpKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    descripcion = '';
    costo = '';
    precioVenta = 0;
    cantidad = '';
    proveedor = '';
    notifyListeners();
  }

  void add(int idEmprendimiento, int idFamilia) {
    final nuevoProductoEmp = ProductosEmp(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagen,
      costo: double.parse(costo),
      precioVenta: precioVenta,
      cantidad: int.parse(cantidad),
      proveedor: proveedor,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final familia = dataBase.familiaInversionBox.get(idFamilia);
      if (emprendimiento != null && familia != null) {
        // final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        // final nuevaInstruccion = Bitacora(instrucciones: 'syncAddCotizacion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        // nuevoProductoEmp.statusSync.target = nuevoSync;
        // nuevoProductoEmp.emprendimientos.target = emprendimiento;
        // nuevoProductoEmp.familiaInversion.target = familia;
        // nuevoProductoEmp.bitacora.add(nuevaInstruccion);
        // emprendimiento.productosEmp.add(nuevoProductoEmp);
        // dataBase.emprendimientosBox.put(emprendimiento);
        productosEmp.add(nuevoProductoEmp);
        print('Registro agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  void remove(ProductosEmp productosEmp) {
    dataBase.productosEmpBox.remove(productosEmp.id); //Se elimina de bitacora la instruccion creada anteriormente
    notifyListeners(); 
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}