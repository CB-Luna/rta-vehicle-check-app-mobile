import 'dart:math';

import 'package:bizpro_app/modelsPocketbase/get_inversion.dart';
import 'package:bizpro_app/modelsPocketbase/get_inversion_x_prod_cotizados.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_cotizados.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';

class SyncProviderPocketbase extends ChangeNotifier {
  Random random = new Random();
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
  bool exitoso = true;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    // notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    // notifyListeners();
  }

  void procesoExitoso(bool boleano) {
    procesoexitoso = boleano;
    // notifyListeners();
  }


  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora) async {
    print("Tamaño de instrucciones en Bitacora: ${instruccionesBitacora.length}");
    for (var i = 0; i < instruccionesBitacora.length; i++) {
      print("La instrucción es: ${instruccionesBitacora[i].instrucciones}");
      switch (instruccionesBitacora[i].instrucciones) {
        case "syncAddEmprendedor":
          print("Entro al caso de syncAddEmprendedor Pocketbase");
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            if(emprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              final boolSyncAddEmprendedor = await syncAddEmprendedor(emprendedorToSync);
              if (boolSyncAddEmprendedor) {
                banderasExistoSync.add(boolSyncAddEmprendedor);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncAddEmprendedor);
                i = instruccionesBitacora.length;
                break;
              }
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncAddEmprendimiento":
          print("Entro al caso de syncAddEmprendimiento Pocketbase");
          continue;
        case "syncAddJornada1":
          print("Entro al caso de syncAddJornada1 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              final boolSyncAddJornada1 = await syncAddJornada12y4(jornadaToSync);
              if (boolSyncAddJornada1) {
                banderasExistoSync.add(boolSyncAddJornada1);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncAddJornada1);
                i = instruccionesBitacora.length;
                break;
              }
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncAddJornada2":
          print("Entro al caso de syncAddJornada2 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              final boolSyncAddJornada2 = await syncAddJornada12y4(jornadaToSync);
              if (boolSyncAddJornada2) {
                banderasExistoSync.add(boolSyncAddJornada2);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncAddJornada2);
                i = instruccionesBitacora.length;
                break;
              }
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncAddJornada3":
          print("Entro al caso de syncAddJornada3 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              final boolSyncAddJornada3 = await syncAddJornada12y4(jornadaToSync);
              if (boolSyncAddJornada3) {
                banderasExistoSync.add(boolSyncAddJornada3);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncAddJornada3);
                i = instruccionesBitacora.length;
                break;
              }
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncAddJornada4":
          print("Entro al caso de syncAddJornada4 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              final boolSyncAddJornada4 = await syncAddJornada12y4(jornadaToSync);
              if (boolSyncAddJornada4) {
                banderasExistoSync.add(boolSyncAddJornada4);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncAddJornada4);
                i = instruccionesBitacora.length;
                break;
              }
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncUpdateEmprendimiento":
          var bitacoraList = dataBase.bitacoraBox.getAll();
          for (var i = 0; i < bitacoraList.length; i++) {
            print("bitacora ID: ${bitacoraList[i].id}");  
            print("Instrucciones: ${bitacoraList[i].instrucciones}");
            }
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            if(emprendimientoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (emprendimientoToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateEmprendimiento(emprendimientoToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateNameEmprendimiento":
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            if(emprendimientoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (emprendimientoToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateNameEmprendimiento(emprendimientoToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateEmprendedor":
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            if(emprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (emprendedorToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateEmprendedor(emprendedorToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateJornada1":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada1(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateJornada2":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada2(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateJornada3":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada3(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateJornada4":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada4(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncAddConsultoria":
          print("Entro aqui");
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            if(consultoriaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddConsultoria(consultoriaToSync);
          } 
          }         
          continue;
        case "syncUpdateConsultoria":
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            if(consultoriaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (consultoriaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateConsultoria(consultoriaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncAddTareaConsultoria":
          print("Entro aqui");
          final tareaToSync = getFirstTarea(dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
          if(tareaToSync != null){
            if(tareaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddTareaConsultoria(tareaToSync);
          } 
          }         
          continue;
        case "syncUpdateTareaConsultoria":
        final tareaToSync = getFirstTarea(dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
          if(tareaToSync != null){
            if(tareaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
                syncUpdateTareaConsultoria(tareaToSync);
            }   
          }
          continue;
        case "syncUpdateUsuario":
          final usuarioToSync = getFirstUsuario(dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
          if(usuarioToSync != null){
            if(usuarioToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (usuarioToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateUsuario(usuarioToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            } 
          }
          continue;
        case "syncAddProductoEmprendedor":
          print("Entro aqui");
          final prodEmprendedorToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
          if(prodEmprendedorToSync != null){
            if(prodEmprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddProductoEmprendedor(prodEmprendedorToSync);
          } 
          }         
          continue;
        case "syncUpdateProductoEmprendedor":
          final prodEmprendedorToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(prodEmprendedorToSync != null){
            if(prodEmprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (prodEmprendedorToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                // syncUpdateProductoEmprendedor(prodEmprendedorToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncAddVenta":
          print("Entro aqui");
          final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if(ventaToSync != null){
            if(ventaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddVenta(ventaToSync);
          } 
          }         
          continue;
        case "syncAddProductoVendido":
          print("Entro aqui");
          final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
          if(prodVendidoToSync != null){
            if(prodVendidoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddProductoVendido(prodVendidoToSync);
          } 
          }         
          continue;
        case "syncAddInversion":
          print("Entro aqui");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            if(inversionToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddInversion(inversionToSync);
          } 
          }         
          continue;
        case "syncUpdateInversion":
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            if(inversionToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (inversionToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateInversion(inversionToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncDeleteProductoVendido":
          final idDBRProdVendido = instruccionesBitacora[i].idDBR;
          print("Entro aqui en el DeleteProductoVendido");
          if(idDBRProdVendido != null)
          {
            //TODO Hacer el método para eliminar en backend
          } else{
            print("No se había sincronizado");
          }
          continue;
        case "syncDeleteProductoSolicitado":
          final idDBRProdSolicitado = instruccionesBitacora[i].idDBR;
          print("Entro aqui en el DeleteProductoSolicitado");
          if(idDBRProdSolicitado != null)
          {
            //TODO Hacer el método para eliminar en backend
          } else{
            print("No se había sincronizado");
          }
          continue;
        case "syncAddPagoInversion":
          print("Entro aqui");
          final pagoToSync = getFirstPago(dataBase.pagosBox.getAll(), instruccionesBitacora[i].id);
          if(pagoToSync != null){
            if(pagoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            continue;
          } else {
            print("Entro aqui en el else");
            
            await syncAddPagoInversion(pagoToSync);
          } 
          }         
          continue;
        default:
         continue;
      }   
    }
    for (var element in banderasExistoSync) {
      //Aplicamos una operación and para validar que no haya habido una acción con False
      exitoso = exitoso && element;
    }
    //Verificamos que no haya habido errores al sincronizar con las banderas
    if (exitoso) {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      // notifyListeners();
      return exitoso;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
       // notifyListeners();
      return exitoso;
    }

  }

  Usuarios? getFirstUsuario(List<Usuarios> usuarios, int idInstruccionesBitacora)
  {
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < usuarios[i].bitacora.length; j++) {
          if (usuarios[i].bitacora[j].id == idInstruccionesBitacora) {
            return usuarios[i];
          } 
        }
      }
    }
    return null;
  }

  Emprendedores? getFirstEmprendedor(List<Emprendedores> emprendedores, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendedores.length; i++) {
      if (emprendedores[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendedores[i].bitacora.length; j++) {
          if (emprendedores[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendedores[i];
          } 
        }
      }
    }
    return null;
  }
  Emprendimientos? getFirstEmprendimiento(List<Emprendimientos> emprendimientos, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendimientos.length; i++) {
      if (emprendimientos[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendimientos[i].bitacora.length; j++) {
          if (emprendimientos[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendimientos[i];
          } 
        }
      }
    }
    return null;
  }
  Jornadas? getFirstJornada(List<Jornadas> jornadas, int idInstruccionesBitacora)
  {
    for (var i = 0; i < jornadas.length; i++) {
      if (jornadas[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < jornadas[i].bitacora.length; j++) {
          if (jornadas[i].bitacora[j].id == idInstruccionesBitacora) {
            return jornadas[i];
          } 
        }
      }
    }
    return null;
  }
  Inversiones? getFirstInversion(List<Inversiones> inversiones, int idInstruccionesBitacora)
  {
    for (var i = 0; i < inversiones.length; i++) {
      if (inversiones[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < inversiones[i].bitacora.length; j++) {
          if (inversiones[i].bitacora[j].id == idInstruccionesBitacora) {
            return inversiones[i];
          } 
        }
      }
    }
    return null;
  }
  Consultorias? getFirstConsultoria(List<Consultorias> consultorias, int idInstruccionesBitacora)
  {
    for (var i = 0; i < consultorias.length; i++) {
      if (consultorias[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < consultorias[i].bitacora.length; j++) {
          if (consultorias[i].bitacora[j].id == idInstruccionesBitacora) {
            return consultorias[i];
          } 
        }
      }
    }
    return null;
  }
  ProductosEmp? getFirstProductoEmprendedor(List<ProductosEmp> productosEmp, int idInstruccionesBitacora)
    {
      for (var i = 0; i < productosEmp.length; i++) {
        if (productosEmp[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < productosEmp[i].bitacora.length; j++) {
            if (productosEmp[i].bitacora[j].id == idInstruccionesBitacora) {
              return productosEmp[i];
            } 
          }
        }
      }
      return null;
    }
  Ventas? getFirstVenta(List<Ventas> ventas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < ventas.length; i++) {
        if (ventas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < ventas[i].bitacora.length; j++) {
            if (ventas[i].bitacora[j].id == idInstruccionesBitacora) {
              return ventas[i];
            } 
          }
        }
      }
      return null;
    }
  ProdVendidos? getFirstProductoVendido(List<ProdVendidos> prodVendidos, int idInstruccionesBitacora)
    {
      for (var i = 0; i < prodVendidos.length; i++) {
        if (prodVendidos[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < prodVendidos[i].bitacora.length; j++) {
            if (prodVendidos[i].bitacora[j].id == idInstruccionesBitacora) {
              return prodVendidos[i];
            } 
          }
        }
      }
      return null;
    }
  Tareas? getFirstTarea(List<Tareas> tareas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < tareas.length; i++) {
        if (tareas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < tareas[i].bitacora.length; j++) {
            if (tareas[i].bitacora[j].id == idInstruccionesBitacora) {
              return tareas[i];
            } 
          }
        }
      }
      return null;
    }

    Pagos? getFirstPago(List<Pagos> pagos, int idInstruccionesBitacora)
    {
      for (var i = 0; i < pagos.length; i++) {
        if (pagos[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < pagos[i].bitacora.length; j++) {
            if (pagos[i].bitacora[j].id == idInstruccionesBitacora) {
              return pagos[i];
            } 
          }
        }
      }
      return null;
    }

  Future<bool> syncAddEmprendedor(Emprendedores emprendedor) async {
    print("Estoy en El syncAddEmprendedor de Pocketbase");
    try {
      final emprendimientoToSync = dataBase.emprendimientosBox.query(Emprendimientos_.emprendedor.equals(emprendedor.id)).build().findUnique();
      if (emprendimientoToSync != null) {
        if (emprendedor.idDBR == null && emprendimientoToSync.idDBR == null) {
          print("Primero creamos al emprendedor asociado");
          //Primero creamos el emprendedor asociado al emprendimiento
          final recordEmprendedor = await client.records.create('emprendedores', body: {
              "nombre_emprendedor": emprendedor.nombre,
              "apellidos_emp": emprendedor.apellidos,
              "curp": emprendedor.curp,
              "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
              "id_comunidad_fk": emprendedor.comunidad.target!.idDBR,
              "telefono": emprendedor.telefono,
              "comentarios": emprendedor.comentarios,
              "id_emprendimiento_fk": "",
              "id_status_sync_fk": "HoI36PzYw1wtbO1"
          });

          if (recordEmprendedor.id.isNotEmpty) {
            String idDBR = recordEmprendedor.id;
            print("Emprendedor created succesfully");
            var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedor.id);
            if (updateEmprendedor != null) {
              print("Entro al if de syncAddEmprendedor");
              print("Previo estado del Emprendedor: ${updateEmprendedor.statusSync.target!.status}");
              final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
              //Se actualiza el estado del emprendedor
              if (statusSync != null) {
                statusSync.status = "HoI36PzYw1wtbO1";
                dataBase.statusSyncBox.put(statusSync);
                print("Se hace el conteo de la tabla statusSync");
                print(dataBase.statusSyncBox.count());
              }
              //Se recupera el idDBR del emprendedor
              updateEmprendedor.idDBR = idDBR;
              dataBase.emprendedoresBox.put(updateEmprendedor);
              print("Recuperacion de idDBR del Emprendedor");

              var emprendedoresPrueba = dataBase.emprendedoresBox.getAll();
              for (var i = 0; i < emprendedoresPrueba.length; i++) {
              print("Status Emprendedor Prueba: ${emprendedoresPrueba[i].statusSync.target!.status}");  
              print("IDBR Emprendedor Prueba: ${emprendedoresPrueba[i].idDBR}");
              }
              print("Se hace el conteo de la tabla Emprendedores");
              print(dataBase.emprendedoresBox.count());
            }
            //Segundo creamos el emprendimiento
            final recordEmprendimiento = await client.records.create('emprendimientos', body: {
              "nombre_emprendimiento": emprendimientoToSync.nombre,
              "descripcion": emprendimientoToSync.descripcion,
              "imagen": emprendimientoToSync.imagen,
              "activo": emprendimientoToSync.activo,
              "archivado": emprendimientoToSync.archivado,
              "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
              "id_prioridad_fk": "yuEVuBv9rxLM4cR",
              "id_proveedor_fk": "",
              "id_fase_emp_fk": emprendimientoToSync.faseEmp.firstWhere((element) => element.fase == emprendimientoToSync.faseActual).idDBR,
              "id_status_sync_fk": "HoI36PzYw1wtbO1",
              "id_emprendedor_fk": emprendimientoToSync.emprendedor.target!.idDBR,
            });
            if (recordEmprendimiento.id.isNotEmpty) {
              String idDBR = recordEmprendimiento.id;
              print("Emprendimiento created succesfully");
              var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientoToSync.id);
              if (updateEmprendimiento != null) {
                print("Previo estado del Emprendimiento: ${updateEmprendimiento.statusSync.target!.status}");
                final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
                //Se actualiza el estado del emprendimiento
                if (statusSync != null) {
                  statusSync.status = "HoI36PzYw1wtbO1";
                  dataBase.statusSyncBox.put(statusSync);
                  print("Se hace el conteo de la tabla statusSync");
                  print(dataBase.statusSyncBox.count());
                }
                //Se recupera el idDBR del emprendimiento
                updateEmprendimiento.idDBR = idDBR;
                dataBase.emprendimientosBox.put(updateEmprendimiento);
                print("Recuperacion de estado del Emprendimiento");

                var emprendimientosPrueba = dataBase.emprendimientosBox.getAll();
                for (var i = 0; i < emprendimientosPrueba.length; i++) {
                print("Status Emprendimiento Prueba: ${emprendimientosPrueba[i].statusSync.target!.status}");  
                print("IDBR Emprendimiento Prueba: ${emprendimientosPrueba[i].idDBR}");
                }
              }
            }
              return true;
          } else {
            return false;
          }
        } else {
          //Ya ha sido enviado a Pocketbase
          return true;
        }
      } else {
        return false;
      }
  } catch (e) {
    print('ERROR - function syncAddEmprendedor(): $e');
    return false;
  }
}

  Future<bool> syncAddJornada12y4(Jornadas jornada) async {
    print("Estoy en syncAddJornada12y4");
    try {
    final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
    if (tareaToSync != null) {  
      if (jornada.idDBR == null && tareaToSync.idDBR == null) {
        //Primero creamos la tarea asociada a la jornada
        final recordTarea = await client.records.create('tareas', body: {
        "tarea": tareaToSync.tarea,
        "descripcion": tareaToSync.descripcion,
        "comentarios": tareaToSync.comentarios,
        "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
        //Se actualiza el estado de la tarea
        String idDBRTarea = recordTarea.id;
        final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(tareaToSync.statusSync.target!.id)).build().findUnique();
        if (statusSyncTarea != null) {
          statusSyncTarea.status = "HoI36PzYw1wtbO1";
          dataBase.statusSyncBox.put(statusSyncTarea);
          print("Se hace el conteo de la tabla statusSync");
          print(dataBase.statusSyncBox.count());
          print("Actualizacion de estado de la Tarea");
        }
        //Se recupera el idDBR de la tarea
        final updateTarea = dataBase.tareasBox.query(Tareas_.id.equals(tareaToSync.id)).build().findUnique();
        if (updateTarea != null) {
          updateTarea.idDBR = idDBRTarea;
          dataBase.tareasBox.put(updateTarea);
          print("Se recupera el idDBR de la Tarea");
          //Segundo creamos la jornada  
          print("Datos");
          print(jornada.numJornada);
          print(jornada.fechaRevision.toUtc().toString());
          print("Nombre Emp ${jornada.emprendimiento.target?.nombre}");
          print("IdDBR Emprendimiento ${jornada.emprendimiento.target?.idDBR}");
          final recordJornada = await client.records.create('jornadas', body: {
            "num_jornada": jornada.numJornada,
            "id_tarea_fk": recordTarea.id,
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
          });

          if (recordJornada.id.isNotEmpty) {
            //Se actualiza el estado de la jornada
            String idDBRJornada = recordJornada.id;
            final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornada.statusSync.target!.id)).build().findUnique();
            if (statusSyncJornada != null) {
              statusSyncJornada.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSyncJornada);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
              print("Actualizacion de estado de la Jornada");
            }
            //Se recupera el idDBR de la jornada
            final updateJornada = dataBase.jornadasBox.query(Jornadas_.id.equals(jornada.id)).build().findUnique();
            if (updateJornada != null) {
              updateJornada.idDBR = idDBRJornada;
              dataBase.jornadasBox.put(updateJornada);
              print("Se recupera el idDBR de la jornada");
            }
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
        } else {
          return false;
        }
      } else {
        return true;
      }
      } else {
      return false;
    }
  } catch (e) {
    print('ERROR - function syncAddJornada12y4(): $e');
    return false;
  }
}

  Future<bool> syncAddJornada3(Jornadas jornada) async {
    print("Estoy en syncAddJornada3");
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        try {
        if (tareaToSync != null) {  
          if (jornada.idDBR == null && tareaToSync.idDBR == null) {
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1"
            });
            if (recordTarea.id.isNotEmpty) {
            //Se actualiza el estado de la tarea
            String idDBRTarea = recordTarea.id;
            final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(tareaToSync.statusSync.target!.id)).build().findUnique();
            if (statusSyncTarea != null) {
              statusSyncTarea.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSyncTarea);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
              print("Actualizacion de estado de la Tarea");
            }
            //Se recupera el idDBR de la tarea
            final updateTarea = dataBase.tareasBox.query(Tareas_.id.equals(tareaToSync.id)).build().findUnique();
            if (updateTarea != null) {
              updateTarea.idDBR = idDBRTarea;
              dataBase.tareasBox.put(updateTarea);
              print("Se recupera el idDBR de la Tarea");
              //Segundo actualizamos el catalogoProyecto del emprendimiento
              final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
              if (emprendimiento != null) {
                final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
                  "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
                  "id_status_sync_fk": "HoI36PzYw1wtbO1",
                }); 
                if (record.id.isNotEmpty) {
                print("Emprendimiento updated succesfully");
                var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
                if (updateEmprendimiento != null) {
                  final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
                  if (statusSync != null) {
                    statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
                    dataBase.statusSyncBox.put(statusSync);
                  }
                }
                //Tercero creamos la jornada
                print(jornada.numJornada);
                print(jornada.fechaRevision.toUtc().toString());
                print("Nombre Emp ${jornada.emprendimiento.target?.nombre}");
                print("IdDBR Emprendimiento ${jornada.emprendimiento.target?.idDBR}");
                final recordJornada = await client.records.create('jornadas', body: {
                  "num_jornada": jornada.numJornada,
                  "id_tarea_fk": recordTarea.id,
                  "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                  "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                  "id_status_sync_fk": "HoI36PzYw1wtbO1",
                });

                if (recordJornada.id.isNotEmpty) {
                  //Se actualiza el estado de la jornada
                  String idDBRJornada = recordJornada.id;
                  final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornada.statusSync.target!.id)).build().findUnique();
                  if (statusSyncJornada != null) {
                    statusSyncJornada.status = "HoI36PzYw1wtbO1";
                    dataBase.statusSyncBox.put(statusSyncJornada);
                    print("Se hace el conteo de la tabla statusSync");
                    print(dataBase.statusSyncBox.count());
                    print("Actualizacion de estado de la Jornada");
                  }
                  //Se recupera el idDBR de la jornada
                  final updateJornada = dataBase.jornadasBox.query(Jornadas_.id.equals(jornada.id)).build().findUnique();
                  if (updateJornada != null) {
                    updateJornada.idDBR = idDBRJornada;
                    dataBase.jornadasBox.put(updateJornada);
                    print("Se recupera el idDBR de la jornada");
                  }
                  return true;
                } else {
                  return false;
                }
              } else{
                return false;
              }
              } else {
                return false;
              }
            } else {
              return false;
            }
            } else {
              return false;
            }
          } else {
            return true;
          }
          } else {
          return false;
        }
      } catch (e) {
        print('ERROR - function syncAddJornada3(): $e');
        return false;
      }
}


  Future<bool?> syncAddConsultoria(Consultorias consultoria) async {
    print("Estoy en syncAddConsultoria");
    final tareasToSync = consultoria.tareas.toList();
    List<String> idsDBRTareas = [];
    try {
    //Primero creamos las tareas asociadas a la consultoria
    for (var i = 0; i < tareasToSync.length; i++) {
      print("Datos");
      final recordTarea = await client.records.create('tareas', body: {
        "tarea": tareasToSync[i].tarea,
        "descripcion": tareasToSync[i].descripcion,
        "comentarios": tareasToSync[i].comentarios,
        "id_porcentaje_fk": tareasToSync[i].porcentaje.target!.idDBR,
        "fecha_revision": tareasToSync[i].fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
      });
      if (recordTarea.id.isNotEmpty) {
      //Se actualiza el estado de la tarea
      idsDBRTareas.add(recordTarea.id);
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(tareasToSync[i].statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
        statusSyncTarea.status = "HoI36PzYw1wtbO1";
        dataBase.statusSyncBox.put(statusSyncTarea);
        print("Se hace el conteo de la tabla statusSync");
        print(dataBase.statusSyncBox.count());
        print("Actualizacion de estado de la Tarea");
      }
      //Se recupera el idDBR de la tarea
      final updateTarea = dataBase.tareasBox.query(Tareas_.id.equals(tareasToSync[i].id)).build().findUnique();
      if (updateTarea != null) {
        updateTarea.idDBR = recordTarea.id;
        dataBase.tareasBox.put(updateTarea);
        print("Se recupera el idDBR de la Tarea");
      }
      }
    }
    print("idsDBRSTareas: $idsDBRTareas");
    //Segundo creamos la consultoria
    final recordConsultoria = await client.records.create('consultorias', body: {
      "id_emprendimiento_fk": consultoria.emprendimiento.target!.idDBR,
      "id_tarea_fk": idsDBRTareas,
      "id_status_sync_fk": "HoI36PzYw1wtbO1",
      "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
      "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
    });

    if (recordConsultoria.id.isNotEmpty) {
      //Se actualiza el estado de la consultoria
      String idDBRConsultoria = recordConsultoria.id;
      final statusSyncConsultoria = dataBase.statusSyncBox.query(StatusSync_.id.equals(consultoria.statusSync.target!.id)).build().findUnique();
      if (statusSyncConsultoria != null) {
        statusSyncConsultoria.status = "HoI36PzYw1wtbO1";
        dataBase.statusSyncBox.put(statusSyncConsultoria);
        print("Se hace el conteo de la tabla statusSync");
        print(dataBase.statusSyncBox.count());
        print("Actualizacion de estado de la Consultoria");
      }
      //Se recupera el idDBR de la consultoria
      final updateConsultoria = dataBase.consultoriasBox.query(Consultorias_.id.equals(consultoria.id)).build().findUnique();
      if (updateConsultoria != null) {
        updateConsultoria.idDBR = idDBRConsultoria;
        dataBase.consultoriasBox.put(updateConsultoria);
        print("Se recupera el idDBR de la consultoria");
        return true;
      }
    }
    return null;
    } catch (e) {
      print('ERROR - function syncAddConsultoria(): $e');
      return false;
    }
}

 Future<bool?> syncAddTareaConsultoria(Tareas tarea) async {
    print("Estoy en syncAddTareaConsultoria");
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(tarea.id)).build().findUnique();
        List<String> updateListIdTareas = [];
        final updateTareasToSync = tarea.consultoria.target!.tareas.toList();
        try {
        //Primero creamos la tarea asociada a la jornada
        if (tareaToSync != null) {  
          print("Datos");
          print(tareaToSync.tarea);
          print(tareaToSync.descripcion);
          print(tareaToSync.fechaRevision.toUtc().toString());
          print(tareaToSync.comentarios);
          final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "id_porcentaje_fk": tareaToSync.porcentaje.target!.idDBR,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1"
          });
          if (recordTarea.id.isNotEmpty) {
            //Se actualiza el estado de la tarea
            String idDBRTarea = recordTarea.id;
            final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(tareaToSync.statusSync.target!.id)).build().findUnique();
            if (statusSyncTarea != null) {
              statusSyncTarea.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSyncTarea);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
              print("Actualizacion de estado de la Tarea");
            }
            //Se recupera el idDBR de la tarea
            final updateTarea = dataBase.tareasBox.query(Tareas_.id.equals(tareaToSync.id)).build().findUnique();
            if (updateTarea != null) {
              updateTarea.idDBR = idDBRTarea;
              dataBase.tareasBox.put(updateTarea);
              print("Se recupera el idDBR de la Tarea");
            }
            //Segundo actualizamos la consultoria  
            for (var i = 0; i < updateTareasToSync.length; i++) {
              if (updateTareasToSync[i].idDBR != null) {
                updateListIdTareas.add(updateTareasToSync[i].idDBR!);
              }
            }
            updateListIdTareas.add(idDBRTarea);
            final recordConsultoria = await client.records.update('consultorias', tareaToSync.consultoria.target!.idDBR.toString() , body: {
              "id_tarea_fk": jsonEncode(updateListIdTareas),
              "id_status_sync_fk": "HoI36PzYw1wtbO1",
            });
            if (recordConsultoria.id.isNotEmpty) {
              print("Se agrega éxitosamente la nueva Tarea en consultoría");
            }
          }

          return true;
      }
      } catch (e) {
        print('ERROR - function syncAddTareaConsultoria(): $e');
        return false;
      }
    
    return null;
}

  Future<bool?> syncUpdateEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncUpdateEmprendimiento");
    try {
      print("ID Promotor: ${emprendimiento.usuario.target!.idDBR}");

      print("ID Emprendedor: ${emprendimiento.emprendedor.target!.idDBR}");

      final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
          "nombre_emprendimiento": emprendimiento.nombre,
          "descripcion": emprendimiento.descripcion,
          "imagen": emprendimiento.imagen,
          "activo": emprendimiento.activo,
          "archivado": emprendimiento.archivado,
          "id_promotor_fk": emprendimiento.usuario.target!.idDBR,
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
          "id_emprendedor_fk": emprendimiento.emprendedor.target!.idDBR,
      }); 

      if (record.id.isNotEmpty) {
        print("Emprendimiento updated succesfully");
        var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
        if (updateEmprendimiento  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateEmprendimiento(): $e');
      return false;
    }

  } 


  Future<bool?> syncUpdateNameEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncUpdateNameEmprendimiento");
    try {

      final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
        "nombre_emprendimiento": emprendimiento.nombre,
        "id_status_sync_fk": "HoI36PzYw1wtbO1",
      }); 

      if (record.id.isNotEmpty) {
        print("Emprendimiento updated succesfully");
        var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
        if (updateEmprendimiento  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateNameEmprendimiento(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateEmprendedor(Emprendedores emprendedor) async {

    print("Estoy en El syncUpdateEmprendedor");
    try {
      print("ID Emprendedor: ${emprendedor.idDBR}");

      final record = await client.records.update('emprendedores', emprendedor.idDBR.toString(), body: {
          "nombre_emprendedor": emprendedor.nombre,
          "apellidos_emp": emprendedor.apellidos,
          "nacimiento": "1995-06-21", //TODO Validar Formato Nacimiento
          "curp": emprendedor.curp,
          "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
          "id_comunidad_fk": emprendedor.comunidad.target!.idDBR,
          "telefono": emprendedor.telefono,
          "comentarios": emprendedor.comentarios,
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
      }); 

      if (record.id.isNotEmpty) {
        print("Emprendedor updated succesfully");
        var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedor.id);
        if (updateEmprendedor  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendedor
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateEmprendedor(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateJornada1(Jornadas jornada) async {
    print("Estoy en El syncUpdatJornada1");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateJornada2(Jornadas jornada) async {
    print("Estoy en El syncUpdatJornada2");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "comentarios": updateTarea.comentarios,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada2(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateJornada3(Jornadas jornada) async {
    print("Estoy en El syncUpdateJornada3");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "comentarios": updateTarea.comentarios,
        "descripcion": updateTarea.descripcion,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada3(): $e');
      return false;
    }

  } 

    Future<bool?> syncUpdateJornada4(Jornadas jornada) async {
    print("Estoy en El syncUpdateJornada4");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "comentarios": updateTarea.comentarios,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada4(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateConsultoria(Consultorias consultoria) async {
    print("Estoy en El syncUpdateConsultoria");
    try {
      final record = await client.records.update('consultorias', consultoria.idDBR! ,
      body: {
          "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
          "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
          "archivado": consultoria.archivado,
      });
      if (record.id.isNotEmpty) {
        print("Consultoria updated succesfully");
        var updateConsultoria = dataBase.consultoriasBox.get(consultoria.id);
        if (record.id.isNotEmpty && updateConsultoria != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateConsultoria.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncUpdateConsultoria(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateTareaConsultoria(Tareas tarea) async {
    print("Estoy en El syncUpdateTareaConsultoria");
    List<String> tareasConsultoria = [];
    try {
      //Primero creamos la tarea asociada a la consultoria
      final recordTarea = await client.records.create('tareas', body: {
        "tarea": tarea.tarea,
        "descripcion": tarea.descripcion,
        "comentarios": tarea.comentarios,
        "id_porcentaje_fk": tarea.porcentaje.target!.idDBR,
        "fecha_revision": tarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
      });
      if (recordTarea.id.isNotEmpty) {
        //Se actualiza el estado de la tarea
        String idDBRTarea = recordTarea.id;
        final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(tarea.statusSync.target!.id)).build().findUnique();
        if (statusSyncTarea != null) {
          statusSyncTarea.status = "HoI36PzYw1wtbO1";
          dataBase.statusSyncBox.put(statusSyncTarea);
          print("Se hace el conteo de la tabla statusSync");
          print(dataBase.statusSyncBox.count());
          print("Actualizacion de estado de la Tarea");
        }
        //Se recupera el idDBR de la tarea
        final updateTarea = dataBase.tareasBox.query(Tareas_.id.equals(tarea.id)).build().findUnique();
        if (updateTarea != null) {
          updateTarea.idDBR = recordTarea.id;
          dataBase.tareasBox.put(updateTarea);
          print("Se recupera el idDBR de la Tarea");
        }
        //Segundo actualizamos la consultoria
        final consultoria = dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
        if (consultoria != null) {
          for (var element in consultoria.tareas.toList()) {
            if (element.idDBR != null) {
              tareasConsultoria.add(element.idDBR!);
            }
          }
          tareasConsultoria.add(idDBRTarea);
          print("IdsDBRTareas: $tareasConsultoria");
          final recordConsultoria = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
            "id_tarea_fk": tareasConsultoria,
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
          }); 
          if (recordConsultoria.id.isNotEmpty) {
            print("Consultoria updated succesfully");
            var updateConsultoria = dataBase.consultoriasBox.get(consultoria.id);
            if (updateConsultoria != null) {
              final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateConsultoria.statusSync.target!.id)).build().findUnique();
              if (statusSync != null) {
                statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la consultoria
                dataBase.statusSyncBox.put(statusSync);
                return true;
              }
            }
            else{
              return false;
            }
          }  
          return null;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateTareaConsultoria(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateUsuario(Usuarios usuario) async {
    print("Estoy en El syncUpdateUsuario");
    try {

      final record = await client.records.update('emi_users', usuario.idDBR.toString(), body: {
        "nombre_usuario": usuario.nombre,
        "apellido_p": usuario.apellidoP,
        "apellido_m": usuario.apellidoM,
        "telefono": usuario.telefono,
        "avatar": usuario.image.target?.imagenes,
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
      }); 

      if (record.id.isNotEmpty) {
        print("usuario updated succesfully");
        var updateUsuario = dataBase.usuariosBox.get(usuario.id);
        if (updateUsuario  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateUsuario.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateUsuario(): $e');
      return false;
    }

  } 
void deleteBitacora() {
  dataBase.bitacoraBox.removeAll();
  notifyListeners();
}

  Future<bool?> syncAddProductoEmprendedor(ProductosEmp productoEmp) async {
    print("Estoy en El syncAddProductoEmp");
      try {
      final record = await client.records.create('productos_emp', body: {
          "nombre_prod_emp": productoEmp.nombre,
          "descripcion": productoEmp.descripcion,
          "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
          "costo_prod_emp": productoEmp.costo,
          "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
          "archivado": productoEmp.archivado,
      });
      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Producto Emprendedor created succesfully");
        var updateProdEmprendedor = dataBase.productosEmpBox.get(productoEmp.id);
        if (updateProdEmprendedor != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdEmprendedor.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          updateProdEmprendedor.idDBR = idDBR;
          dataBase.productosEmpBox.put(updateProdEmprendedor);
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncAddProductoEmp(): $e');
      return false;
    }
}

  Future<bool?> syncAddVenta(Ventas venta) async {
    print("Estoy en El syncAddVenta");
      try {
      final record = await client.records.create('ventas', body: {
          "id_emprendimiento_fk": venta.emprendimiento.target!.idDBR,
          "fecha_inicio": venta.fechaInicio.toUtc().toString(),
          "fecha_termino": venta.fechaTermino.toUtc().toString(),
          "total": venta.total,
          "archivado": venta.archivado,
      });
      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Venta created succesfully");
        var updateVenta = dataBase.ventasBox.get(venta.id);
        if (updateVenta != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateVenta.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          updateVenta.idDBR = idDBR;
          dataBase.ventasBox.put(updateVenta);
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncAddVenta(): $e');
      return false;
    }
}

  Future<bool?> syncUpdateVenta(Ventas venta) async {
    print("Estoy en El syncUpdateVenta");
      try {
      final record = await client.records.update('ventas', venta.idDBR! ,
      body: {
          "fecha_inicio": venta.fechaInicio.toUtc().toString(),
          "fecha_termino": venta.fechaTermino.toUtc().toString(),
          "total": venta.total,
          "archivado": venta.archivado,
      });
      if (record.id.isNotEmpty) {
        print("Venta updated succesfully");
        var updateVenta = dataBase.ventasBox.get(venta.id);
        if (record.id.isNotEmpty && updateVenta != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateVenta.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncUpdateVenta(): $e');
      return false;
    }
}

  Future<bool?> syncAddProductoVendido(ProdVendidos productoVendido) async {
    print("Estoy en El syncAddProductoVendido");
      try {
      final record = await client.records.create('prod_vendidos', body: {
          "id_productos_emp_fk": productoVendido.productoEmp.target!.idDBR,
          "cantidad_vendida": productoVendido.cantVendida,
          "subTotal": productoVendido.subtotal,
          "precio_venta": productoVendido.precioVenta,
          "id_venta_fk": productoVendido.venta.target!.idDBR,
      });
      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Producto Emprendedor created succesfully");
        var updateProductoVendido = dataBase.productosVendidosBox.get(productoVendido.id);
        if (updateProductoVendido != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProductoVendido.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          updateProductoVendido.idDBR = idDBR;
          dataBase.productosVendidosBox.put(updateProductoVendido);
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncAddProductoVendido(): $e');
      return false;
    }
}

  Future<bool?> syncAddPagoInversion(Pagos pago) async {
    print("Estoy en El syncAddPagoInversion");
      try {
      final record = await client.records.create('pagos', body: {
          "monto_abonado": pago.montoAbonado,
          "fecha_movimiento": pago.fechaMovimiento.toUtc().toString(),
          "id_inversion_fk": pago.inversion.target!.idDBR,
          "id_usuario_fk": pago.inversion.target!.emprendimiento.target!.usuario.target!.idDBR,
      });
      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Pago created succesfully");
        var updatePago = dataBase.pagosBox.get(pago.id);
        if (updatePago != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updatePago.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          updatePago.idDBR = idDBR;
          dataBase.pagosBox.put(updatePago);
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncAddPagoInversion(): $e');
      return false;
    }
}
  Future<bool?> syncUpdateProductoVendido(ProdVendidos productoVendido) async {
    print("Estoy en El syncUpdateProductoVendido");
      try {
      final record = await client.records.update('prod_vendidos', productoVendido.idDBR!,
      body: {
          "id_productos_emp_fk": productoVendido.productoEmp.target!.idDBR,
          "cantidad_vendida": productoVendido.cantVendida,
          "subTotal": productoVendido.subtotal,
          "precio_venta": productoVendido.precioVenta,
      });
      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Producto Emprendedor updated succesfully");
        var updateProductoVendido = dataBase.productosVendidosBox.get(productoVendido.id);
        if (idDBR.isNotEmpty && updateProductoVendido != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProductoVendido.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncUpdateProductoVendido(): $e');
      return false;
    }
}

  Future<bool?> syncAddInversion(Inversiones inversion) async {
    try {
      print("Estoy en syncAddInversion");
      //Primero creamos la inversion  
      //Se busca el estado de inversión 'Solicitada'
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
      if (newEstadoInversion != null) {
        print("Datos inversion");
        print(inversion.estadoInversion);
        print(inversion.porcentajePago);
        print(inversion.montoPagar);
        final recordInversion = await client.records.create('inversiones', body: {
          "id_emprendimiento_fk": inversion.emprendimiento.target!.idDBR,
          "id_estado_inversion_fk": newEstadoInversion.idDBR,
          "porcentaje_pago": inversion.porcentajePago,
          "monto_pagar": inversion.montoPagar,
          "saldo": inversion.saldo,
          "total_inversion": inversion.totalInversion,
          "inversion_recibida": true,
          "pago_recibido": false,
          "producto_entregado": false
        });

        if (recordInversion.id.isNotEmpty) {
          //Se actualiza el estado de la inversion
          String idDBRInversion = recordInversion.id;
          final statusSyncInversion = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
          if (statusSyncInversion != null) {
            statusSyncInversion.status = "HoI36PzYw1wtbO1";
            dataBase.statusSyncBox.put(statusSyncInversion);
            print("Se hace el conteo de la tabla statusSync");
            print(dataBase.statusSyncBox.count());
            print("Actualizacion de estado de la inversion");
          }
          //Se recupera el idDBR de la inversion
          final updateInversion = dataBase.inversionesBox.query(Inversiones_.id.equals(inversion.id)).build().findUnique();
          if (updateInversion != null) {
            updateInversion.idDBR = idDBRInversion;
            dataBase.inversionesBox.put(updateInversion);
            print("Se recupera el idDBR de la inversion");
          }
        }

        //Se recupera la inversion con los últimos cambios
        final actualInversion = dataBase.inversionesBox.get(inversion.id);
        if (actualInversion != null) {
          //Segundo creamos la instancia de inversion x prod Cotizados en el backend
          final inversionXprodCotizados = actualInversion.inversionXprodCotizados.last;
          final recordInversionXProdCotizados = await client.records.create('inversion_x_prod_cotizados', body: {
            "id_inversion_fk": inversionXprodCotizados.inversion.target!.idDBR,
          });
        if (recordInversionXProdCotizados.id.isNotEmpty) {
          //Se actualiza el estado de la instancia de inversion x prod Cotizados
          String idDBRInversionXProdCotizados = recordInversionXProdCotizados.id;
          final statusSyncInversionXProdCotizados = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversionXprodCotizados.statusSync.target?.id ?? -1)).build().findUnique();
          if (statusSyncInversionXProdCotizados != null) {
            statusSyncInversionXProdCotizados.status = "HoI36PzYw1wtbO1";
            dataBase.statusSyncBox.put(statusSyncInversionXProdCotizados);
            print("Se hace el conteo de la tabla statusSync");
            print(dataBase.statusSyncBox.count());
            print("Actualizacion de estado de la instancia de inversion x prod Cotizados");
          }
          // Se recupera el idDBR de la instancia de inversion x prod Cotizados
          final updateInversionXprodCotizado = dataBase.inversionesXprodCotizadosBox.query(InversionesXProdCotizados_.id.equals(inversionXprodCotizados.id)).build().findUnique();
          if (updateInversionXprodCotizado != null) {
            updateInversionXprodCotizado.idDBR = idDBRInversionXProdCotizados;
            dataBase.inversionesXprodCotizadosBox.put(updateInversionXprodCotizado);
            print("Se recupera el idDBR de la instancia de inversion x prod Cotizados");
          }
        }
        //Tercero creamos los productos solicitados asociados a la inversion
        final prodSolicitadosToSync = actualInversion.prodSolicitados.toList();
        if (prodSolicitadosToSync.isNotEmpty) {  
          for (var i = 0; i < prodSolicitadosToSync.length; i++) {
            print("Datos Prod Solicitados");
            print(prodSolicitadosToSync[i].producto);
            print(prodSolicitadosToSync[i].cantidad);
            print(prodSolicitadosToSync[i].costoEstimado);
            final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
              "producto": prodSolicitadosToSync[i].producto,
              "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
              "descripcion": prodSolicitadosToSync[i].descripcion,
              "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
              "cantidad": prodSolicitadosToSync[i].cantidad,
              "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
              "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
              "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
              "id_inversion_fk": prodSolicitadosToSync[i].inversion.target!.idDBR,
            });
            if (recordProdSolicitado.id.isNotEmpty) {
            //Se actualiza el estado del prod Solicitado
            String idDBRProdSolicitado = recordProdSolicitado.id;
            final statusSyncProdSolicitado = dataBase.statusSyncBox.query(StatusSync_.id.equals(prodSolicitadosToSync[i].statusSync.target!.id)).build().findUnique();
            if (statusSyncProdSolicitado != null) {
              statusSyncProdSolicitado.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSyncProdSolicitado);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
              print("Actualizacion de estado del Prod Solicitado");
            }
            //Se recupera el idDBR del prod Solicitado
            final updateProdSolicitado = dataBase.productosSolicitadosBox.query(ProdSolicitado_.id.equals(prodSolicitadosToSync[i].id)).build().findUnique();
            if (updateProdSolicitado != null) {
              updateProdSolicitado.idDBR = idDBRProdSolicitado;
              dataBase.productosSolicitadosBox.put(updateProdSolicitado);
              print("Se recupera el idDBR del Prod Solicitado");
            }
            }
          }
        }
        }
      }
      } catch (e) {
        print('ERROR - function syncAddInversion(): $e');
        return false;
      }
    
    return null;
}

  Future<bool?> syncUpdateInversion(Inversiones inversion) async {
    try {
      print("Estoy en syncUpdateInversion"); 
      //Se busca el estado de inversión 'Solicitada'
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
      if (newEstadoInversion != null) {
        print("Datos inversion");
        print(inversion.estadoInversion);
        print(inversion.porcentajePago);
        print(inversion.montoPagar);
        final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
          "id_estado_inversion_fk": newEstadoInversion.idDBR,
        }); 

        if (record.id.isNotEmpty) {
          print("Inversion updated succesfully");
          var updateInversion = dataBase.inversionesBox.get(inversion.id);
          if (updateInversion != null) {
            final statusSyncInversion = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
            if (statusSyncInversion != null) {
              statusSyncInversion.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la inversion
              dataBase.statusSyncBox.put(statusSyncInversion);
              updateInversion.estadoInversion.target = newEstadoInversion;
              dataBase.inversionesBox.put(updateInversion);
            }
            //Se recupera la inversion con los últimos cambios
            final actualInversion = dataBase.inversionesBox.get(inversion.id);
            if (actualInversion != null) {
              //Segundo creamos la instancia de inversion x prod Cotizados en el backend
              final inversionXprodCotizados = actualInversion.inversionXprodCotizados.last;
              final recordInversionXProdCotizados = await client.records.create('inversion_x_prod_cotizados', body: {
                "id_inversion_fk": inversionXprodCotizados.inversion.target!.idDBR,
              });
              if (recordInversionXProdCotizados.id.isNotEmpty) {
                //Se actualiza el estado de la instancia de inversion x prod Cotizados
                String idDBRInversionXProdCotizados = recordInversionXProdCotizados.id;
                final statusSyncInversionXProdCotizados = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversionXprodCotizados.statusSync.target?.id ?? -1)).build().findUnique();
                if (statusSyncInversionXProdCotizados != null) {
                  statusSyncInversionXProdCotizados.status = "HoI36PzYw1wtbO1";
                  dataBase.statusSyncBox.put(statusSyncInversionXProdCotizados);
                  print("Se hace el conteo de la tabla statusSync");
                  print(dataBase.statusSyncBox.count());
                  print("Actualizacion de estado de la instancia de inversion x prod Cotizados");
                }
                // Se recupera el idDBR de la instancia de inversion x prod Cotizados
                final updateInversionXprodCotizado = dataBase.inversionesXprodCotizadosBox.query(InversionesXProdCotizados_.id.equals(inversionXprodCotizados.id)).build().findUnique();
                if (updateInversionXprodCotizado != null) {
                  updateInversionXprodCotizado.idDBR = idDBRInversionXProdCotizados;
                  dataBase.inversionesXprodCotizadosBox.put(updateInversionXprodCotizado);
                  print("Se recupera el idDBR de la instancia de inversion x prod Cotizados");
                }
              }
            }
          }
        }
      }
      } catch (e) {
        print('ERROR - function syncUpdateInversion(): $e');
        return false;
      }
    
    return null;
}

  Future<bool?> syncDeleteProductoVendido(String idDBRProductoVendido) async {
    try {
      print("Estoy en syncDeleteProductoVendido"); 
      //Validamos que el elemento exista en el backend
      final record = await client.records.getOne('prod_vendidos', idDBRProductoVendido); 
      if (record.id.isNotEmpty) {
        //Se puede eliminar el producto vendido en el backend
        await client.records.delete('prod_vendidos', idDBRProductoVendido); 
        print("Producto Vendido deleted succesfully");
        return true;
        }
      } catch (e) {
        print('ERROR - function syncDeleteProductoVendido(): $e');
        return false;
      }
    return null;
}

  Future<bool?> syncDeleteProductoSolicitado(String idDBRProductoSolicitado) async {
    try {
      print("Estoy en syncDeleteProductoSolicitado"); 
      //Validamos que el elemento exista en el backend
      final record = await client.records.getOne('productos_solicitados', idDBRProductoSolicitado); 
      if (record.id.isNotEmpty) {
        //Se puede eliminar el producto solicitado en el backend
        await client.records.delete('productos_solicitados', idDBRProductoSolicitado); 
        print("Producto Solicitado deleted succesfully");
        return true;
        }
      } catch (e) {
        print('ERROR - function syncDeleteProductoSolicitado(): $e');
        return false;
      }
    return null;
}

// VALIDAR QUE HAYA INFO EN EL BACKEND
//False se simula
//True ya ha sido simulada
  Future<bool> validateLengthCotizacion(InversionesXProdCotizados inversionXprodCotizados, Inversiones inversion) async {
    print("Id Inversion: ${inversionXprodCotizados.idDBR}");
    final recordInversion = await client.records.
    getOne('inversiones', 
    inversion.idDBR!);
    final recordProdCotizados = await client.records.
    getFullList('productos_cotizados', 
    batch: 200, 
    filter: "id_inversion_x_prod_cotizados_fk='${
      inversionXprodCotizados.idDBR
      }'");
    if (recordProdCotizados.isEmpty && recordInversion.id.isEmpty) {
      return false;
    } else {
      print("No está vacio");
      final GetInversion inversionParse = getInversionFromMap(recordInversion.toString());
      final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(inversionParse.idEstadoInversionFk)).build().findUnique();
      if (estadoInversion != null) {
        if (estadoInversion.estado == "En Cotización") {
          print("tamaño: ${recordProdCotizados.length}");
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  // VALIDAR QUE HAYA CAMBIADO EL ESTADO DE LA INVERSION A COMPRADA
  Future<bool> validateInversionComprada(Inversiones inversion) async {
    print("Id Inversion: ${inversion.idDBR}");
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Comprada")).build().findUnique();
    if (newEstadoInversion != null) {
      final records = await client.records.
      getFullList('inversiones', 
      batch: 200, 
      filter: "id='${
        inversion.idDBR
        }' && id_estado_inversion_fk='${
          newEstadoInversion.idDBR}'");
      if (records.isEmpty) {
        return false;
      } else {
        var updateInversion = dataBase.inversionesBox.get(inversion.id);
        if (updateInversion != null) {
          final statusSyncInversion = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
          if (statusSyncInversion != null) {
            statusSyncInversion.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la inversion
            dataBase.statusSyncBox.put(statusSyncInversion);
            updateInversion.estadoInversion.target = newEstadoInversion;
            dataBase.inversionesBox.put(updateInversion);
            return true;
          }
          else{
            return false;
          }
        }
        else{
          return false;
        }
    }
    } else {
      return false;
    }
  }

  Future<void> getCotizacion(Emprendimientos emprendimiento, Inversiones inversion, InversionesXProdCotizados inversionXprodCotizados) async {
    //obtenemos los productos cotizados
    print("Tamaño ProdCotizados al principio: ${dataBase.productosCotBox.getAll().length}");
    final recordInversion = await client.records.
    getOne('inversiones', 
    inversion.idDBR!);
    final recordProdCotizados = await client.records.
    getFullList('productos_cotizados', 
    batch: 200, 
    filter: "id_inversion_x_prod_cotizados_fk='${
      inversionXprodCotizados.idDBR
      }'");
    if (recordProdCotizados.isEmpty || recordInversion.id.isEmpty) {
    } else {
      print("No está vacio");
      final GetInversion inversionParse = getInversionFromMap(recordInversion.toString());
      final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(inversionParse.idEstadoInversionFk)).build().findUnique();
      if (estadoInversion != null) {
        if (estadoInversion.estado == "En Cotización") {
          final List<GetProdCotizados> listProdCotizados = [];
          for (var element in recordProdCotizados) {
            listProdCotizados.add(getProdCotizadosFromMap(element.toString()));
          }
          print("****Informacion productos cotizados****");
          print("Tamaño: ${recordProdCotizados.length}");
          for (var i = 0; i < recordProdCotizados.length; i++) {
            if (listProdCotizados[i].id.isNotEmpty) {
            final nuevoProductoCotizado = ProdCotizados(
            cantidad: listProdCotizados[i].cantidad,
            costoTotal: listProdCotizados[i].costoTotal,
            idDBR: listProdCotizados[i].id,
            aceptado: listProdCotizados[i].aceptado,
            );
            final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
            final productoProv = dataBase.productosProvBox.query(ProductosProv_.idDBR.equals(listProdCotizados[i].idProductoProvFk)).build().findUnique();
            if (productoProv != null) {
              nuevoProductoCotizado.statusSync.target = nuevoSync;
              nuevoProductoCotizado.inversionXprodCotizados.target = inversionXprodCotizados;
              nuevoProductoCotizado.productosProv.target = productoProv;
              dataBase.productosCotBox.put(nuevoProductoCotizado);
              inversionXprodCotizados.prodCotizados.add(nuevoProductoCotizado);
              dataBase.inversionesXprodCotizadosBox.put(inversionXprodCotizados);
              print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
              print('Prod Cotizado agregado exitosamente');
              print("Tamaño ProdCotizados al final: ${dataBase.productosCotBox.getAll().length}");
            }
            }
          }
          //Se actualiza el estado de la inversión
          final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En Cotización")).build().findFirst();
          if (newEstadoInversion != null) {
            final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
              "id_estado_inversion_fk": newEstadoInversion.idDBR,
            }); 
            if (record.id.isNotEmpty) {
            print("Inversion updated succesfully");
            var updateInversion = dataBase.inversionesBox.get(inversion.id);
            if (updateInversion != null) {
                final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
                if (statusSync != null) {
                  statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
                  dataBase.statusSyncBox.put(statusSync);
                  updateInversion.estadoInversion.target = newEstadoInversion;
                  dataBase.inversionesBox.put(updateInversion);
                }
              }
            }
          }
          procesoterminado = true;
          procesocargando = false;
          notifyListeners();
        } else {
        }
      } else {
      }
    }
  }

    // CAMBIAR EL ESTADO DE LA INVERSION A COMPRADA
  Future<bool?> cambiarInversionAComprada(Inversiones inversion) async {
    print("Id Inversion: ${inversion.idDBR}");
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Comprada")).build().findUnique();
    final record = await client.records.getOne('inversiones', inversion.idDBR.toString()); 
    if (newEstadoInversion != null && record.id.isNotEmpty) {
      GetInversion getInversion = getInversionFromMap(record.toString());
      if (getInversion.idEstadoInversionFk == newEstadoInversion.idDBR) {
        return null;
      } else {
        print("No está actualizada Inversion Comprada");
        //Se actuzaliza a Inversión Comprada
        final updateInversion = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
        }); 
        if (updateInversion.id.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
  // Simular datos de cotizacion en el backend
  Future<bool> simularCotizacion(Inversiones inversion) async {
    try {
      print("Id Inversion: ${inversion.idDBR}");
      //Se recupera el último Id de inversion_x_prod_cotizados
      final records = await client.records.
        getFullList('inversion_x_prod_cotizados', 
        batch: 200, 
        filter: "id_inversion_fk='${
          inversion.idDBR
          }'",
        sort: '-created');   
      final List<GetInversionXProdCotizados> listInversionXProdCotizados = [];
      for (var element in records) {
        listInversionXProdCotizados.add(getInversionXProdCotizadosFromMap(element.toString()));
      }
      final GetInversionXProdCotizados lastInversionXProdCotizados = listInversionXProdCotizados[0];
      for (var i = 0; i < listInversionXProdCotizados.length; i++) {
        print("$i de ${listInversionXProdCotizados.length}");
        print("ID INVERSION X PROD COTIZADOS: ${listInversionXProdCotizados[i].id}");
      }
      //Se enlistan los idDBR de los productos a cotizar
      List<ProductosProv> prodCotizados = dataBase.productosProvBox.getAll().toList();
      List<double> costos = [899.99, 699.99, 758.59, 666.99, 999.99];
      for (var i = 0; i < random.nextInt(5) + 1; i++) {
        //Se crean los prod Simulados Cotizados
        await client.records.create('productos_cotizados', body: {
          "cantidad": random.nextInt(12) + 1,
          "costo_total": costos[random.nextInt(5)],
          "id_producto_prov_fk":prodCotizados[random.nextInt(6)].idDBR,
          "id_inversion_x_prod_cotizados_fk": lastInversionXProdCotizados.id,
          "aceptado": false
        });
      }
      //Se cambia el estado a En Cotización en la colección de inversiones
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En Cotización")).build().findUnique();
      if (newEstadoInversion != null) {
        print("No está actualizada Inversion Comprada");
        //Se actuzaliza a Inversión Comprada
        final updateInversion = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
        }); 
        if (updateInversion.id.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
      
    } catch (e) {
      print("Error en simularCotizacion: $e");
      return false;
    }
  }
}
