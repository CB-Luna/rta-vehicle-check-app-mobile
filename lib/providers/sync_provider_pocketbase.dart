import 'dart:convert';
import 'dart:math';

import 'package:bizpro_app/modelsPocketbase/get_inversion.dart';
import 'package:bizpro_app/modelsPocketbase/get_inversion_x_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/instruccion_no_sincronizada.dart';
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
  List<InstruccionNoSincronizada> instruccionesFallidas = [];
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


  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora, List<InstruccionNoSincronizada> instruccionesFallidasEmiWeb) async {
    // Se recuperan instrucciones fallidas anteriores
    instruccionesFallidas = instruccionesFallidasEmiWeb;
    for (var i = 0; i < instruccionesBitacora.length; i++) {
      print("La instrucción es: ${instruccionesBitacora[i].instruccion}");
      switch (instruccionesBitacora[i].instruccion) {
        case "syncAddImagenUsuario":
          print("Entro al caso de syncAddImagenUsuario Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncAddImagenUsuario = await syncAddImagenUsuario(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenUsuario) {
              banderasExistoSync.add(boolSyncAddImagenUsuario);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenUsuario);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Agregar Imagen de Perfil Usuario Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Agregar Imagen de Perfil Usuario Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddEmprendedor":
          print("Entro al caso de syncAddEmprendedor Pocketbase");
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            final boolSyncAddEmprendedor = await syncAddEmprendedor(emprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncAddEmprendedor) {
              banderasExistoSync.add(boolSyncAddEmprendedor);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddEmprendedor);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendedorToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddEmprendimiento":
          print("Entro al caso de syncAddEmprendimiento Pocketbase");
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            final boolSyncAddEmprendimiento = syncAddEmprendimiento(instruccionesBitacora[i]);
            if (boolSyncAddEmprendimiento) {
              banderasExistoSync.add(boolSyncAddEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendimientoToSync.nombre,
                instruccion: "Agregar Emprendimiento Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Emprendimiento Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada1":
          print("Entro al caso de syncAddJornada1 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada1 = await syncAddJornada1(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada1) {
              banderasExistoSync.add(boolSyncAddJornada1);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada1);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 1 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 1 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada2":
          print("Entro al caso de syncAddJornada2 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada2 = await syncAddJornada2(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada2) {
              banderasExistoSync.add(boolSyncAddJornada2);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada2);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 2 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 2 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada3":
          print("Entro al caso de syncAddJornada3 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada3 = await syncAddJornada3(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada3) {
              banderasExistoSync.add(boolSyncAddJornada3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada4":
          print("Entro al caso de syncAddJornada4 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada4 = await syncAddJornada4(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada4) {
              banderasExistoSync.add(boolSyncAddJornada4);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada4);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 4 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 4 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddConsultoria":
          print("Entro al caso de syncAddConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            final boolSyncAddConsultoria = await syncAddConsultoria(consultoriaToSync, instruccionesBitacora[i]);
            if (boolSyncAddConsultoria) {
              banderasExistoSync.add(boolSyncAddConsultoria);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddConsultoria);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: consultoriaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Consultoría Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Consultoría Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddProductoEmprendedor":
          print("Entro al caso de syncAddProductoEmprendedor Pocketbase");
          final productoEmpToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
          if(productoEmpToSync != null){
            final boolSyncAddProductoEmp = await syncAddProductoEmprendedor(productoEmpToSync, instruccionesBitacora[i]);
            if (boolSyncAddProductoEmp) {
              banderasExistoSync.add(boolSyncAddProductoEmp);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddProductoEmp);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: productoEmpToSync.emprendimientos.target!.nombre,
                instruccion: "Agregar Producto Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Producto Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddVenta":
          print("Entro al caso de syncAddVenta Pocketbase");
          final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if(ventaToSync != null){
            final boolSyncAddVenta = await syncAddVenta(ventaToSync, instruccionesBitacora[i]);
            if (boolSyncAddVenta) {
              banderasExistoSync.add(boolSyncAddVenta);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddVenta);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Venta Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Venta Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddProductoVendido":
          print("Entro al caso de syncAddProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
          if(prodVendidoToSync != null){
            final boolSyncAddProductoVendido = await syncAddProductoVendido(prodVendidoToSync, instruccionesBitacora[i]);
            if (boolSyncAddProductoVendido) {
              banderasExistoSync.add(boolSyncAddProductoVendido);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddProductoVendido);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: prodVendidoToSync.venta.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Producto Vendido Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Producto Vendido Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddInversion":
          print("Entro al caso de syncAddInversion Pocketbase");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            final boolSyncAddInversion = await syncAddInversion(inversionToSync, instruccionesBitacora[i]);
            if (boolSyncAddInversion) {
              banderasExistoSync.add(boolSyncAddInversion);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddInversion);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Inversión Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Inversión Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateEmprendimiento":
          var bitacoraList = dataBase.bitacoraBox.getAll();
          for (var i = 0; i < bitacoraList.length; i++) {
            print("bitacora ID: ${bitacoraList[i].id}");  
            print("Instrucciones: ${bitacoraList[i].instruccion}");
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
        case "syncUpdateFaseEmprendimiento":
          print("Entro al caso de syncUpdateFaseEmprendimiento Pocketbase");
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            final boolSyncUpdateFaseEmprendimiento = await syncUpdateFaseEmprendimiento(emprendimientoToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateFaseEmprendimiento) {
              banderasExistoSync.add(boolSyncUpdateFaseEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateFaseEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendimientoToSync.nombre,
                instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateImagenUsuario":
          print("Entro al caso de syncUpdateImagenUsuario Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncUpdateImagenUsuario = await syncUpdateImagenUsuario(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateImagenUsuario) {
              print("La respuesta es: $boolSyncUpdateImagenUsuario");
              banderasExistoSync.add(boolSyncUpdateImagenUsuario);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateImagenUsuario);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Actualización Imagen de Perfil Usuario Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }     
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Actualización Imagen de Perfil Usuario Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
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
              continue;
            } else {
              if (jornadaToSync.idDBR != null) {
                //Ya se ha enviado al backend la jornada y se puede actualizar
                final boolSyncUpdateJornada1 = await syncUpdateJornada1(jornadaToSync);
                if (boolSyncUpdateJornada1) {
                  banderasExistoSync.add(boolSyncUpdateJornada1);
                  continue;
                } else {
                  //Salimos del bucle
                  banderasExistoSync.add(boolSyncUpdateJornada1);
                  i = instruccionesBitacora.length;
                  break;
                }
              } else {
                //No se ha enviado al backend la jornada y por lo tanto no se puede actualizar
                banderasExistoSync.add(true);
                continue;
              } 
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncUpdateJornada2":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              if (jornadaToSync.idDBR != null) {
                //Ya se ha enviado al backend la jornada y se puede actualizar
                final boolSyncUpdateJornada2 = await syncUpdateJornada2(jornadaToSync);
                if (boolSyncUpdateJornada2) {
                  banderasExistoSync.add(boolSyncUpdateJornada2);
                  continue;
                } else {
                  //Salimos del bucle
                  banderasExistoSync.add(boolSyncUpdateJornada2);
                  i = instruccionesBitacora.length;
                  break;
                }
              } else {
                //No se ha enviado al backend la jornada y por lo tanto no se puede actualizar
                banderasExistoSync.add(true);
                continue;
              } 
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
        case "syncUpdateJornada3":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              continue;
            } else {
              if (jornadaToSync.idDBR != null) {
                //Ya se ha enviado al backend la jornada y se puede actualizar
                final boolSyncUpdateJornada3 = await syncUpdateJornada3(jornadaToSync);
                if (boolSyncUpdateJornada3) {
                  banderasExistoSync.add(boolSyncUpdateJornada3);
                  continue;
                } else {
                  //Salimos del bucle
                  banderasExistoSync.add(boolSyncUpdateJornada3);
                  i = instruccionesBitacora.length;
                  break;
                }
              } else {
                //No se ha enviado al backend la jornada y por lo tanto no se puede actualizar
                banderasExistoSync.add(true);
                continue;
              } 
            }          
          } else {
            //Salimos del bucle
            banderasExistoSync.add(false);
            i = instruccionesBitacora.length;
            break;
          }
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
          print("Entro al caso de syncUpdateUsuario Pocketbase");
          final usuarioToSync = getFirstUsuario(dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
          if(usuarioToSync != null){
            final boolSyncUpdateUsuario = await syncUpdateUsuario(usuarioToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateUsuario) {
              print("La respuesta es: $boolSyncUpdateUsuario");
              banderasExistoSync.add(boolSyncUpdateUsuario);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateUsuario);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Actualización Datos Usuario Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Actualización Datos Usuario Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateEstadoInversion":
          print("Entro al caso de syncUpdateEstadoInversion Pocketbase");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            //Esta instrucción tendrán una bandera para pocketbase con el fin de que no se vuelvan a ejecutar.
            if(instruccionesBitacora[i].executePocketbase) { 
              print("Ya se ha ejecutado en Pocketbase");
              continue;
            } else {
              final boolSyncUpdateEstadoInversion = await syncUpdateEstadoInversion(inversionToSync, instruccionesBitacora[i]);
              if (boolSyncUpdateEstadoInversion) {
                print("La respuesta es: $boolSyncUpdateEstadoInversion");
                banderasExistoSync.add(boolSyncUpdateEstadoInversion);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncUpdateEstadoInversion);
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
        case "syncUpdateInversion":
          print("Entro al caso de syncUpdateInversion Pocketbase");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            //Esta instrucción tendrán una bandera para pocketbase con el fin de que no se vuelvan a ejecutar.
            if(instruccionesBitacora[i].executePocketbase) { 
              print("Ya se ha ejecutado en Pocketbase");
              continue;
            } else {
              final boolSyncUpdateInversion = await syncUpdateInversion(inversionToSync, instruccionesBitacora[i]);
              if (boolSyncUpdateInversion) {
                print("La respuesta es: $boolSyncUpdateInversion");
                banderasExistoSync.add(boolSyncUpdateInversion);
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(boolSyncUpdateInversion);
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
      banderasExistoSync.clear();
      notifyListeners();
      return exitoso;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExistoSync.clear();
       notifyListeners();
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

  Imagenes? getFirstImagen(List<Imagenes> imagenes, int idInstruccionesBitacora)
    {
      for (var i = 0; i < imagenes.length; i++) {
        if (imagenes[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < imagenes[i].bitacora.length; j++) {
            if (imagenes[i].bitacora[j].id == idInstruccionesBitacora) {
              return imagenes[i];
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

  Future<bool> syncAddEmprendedor(Emprendedores emprendedor, Bitacora bitacora) async {
    print("Estoy en El syncAddEmprendedor de Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final emprendimientoToSync = dataBase.emprendimientosBox.query(Emprendimientos_.emprendedor.equals(emprendedor.id)).build().findUnique();
        final faseInscricto = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Inscrito")).build().findUnique();
        if (emprendimientoToSync != null && faseInscricto != null) {
          if (emprendedor.idDBR == null) {
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
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emi_web": emprendedor.idEmiWeb,
            });

            if (recordEmprendedor.id.isNotEmpty) {
              String idDBR = recordEmprendedor.id;
              print("Emprendedor created succesfully");
              //Se recupera el idDBR del emprendedor
              emprendedor.idDBR = idDBR;
              dataBase.emprendedoresBox.put(emprendedor);
              print("Recuperacion de idDBR del Emprendedor");
              //Segundo creamos el emprendimiento
              final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                "nombre_emprendimiento": emprendimientoToSync.nombre,
                "descripcion": emprendimientoToSync.descripcion,
                "imagen": emprendimientoToSync.imagen,
                "activo": emprendimientoToSync.activo,
                "archivado": emprendimientoToSync.archivado,
                "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
                "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                "id_fase_emp_fk": faseInscricto.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emprendedor_fk": emprendimientoToSync.emprendedor.target!.idDBR,
                "id_emi_web": emprendimientoToSync.idEmiWeb,
              });
              if (recordEmprendimiento.id.isNotEmpty) {
                String idDBR = recordEmprendimiento.id;
                print("Emprendimiento created succesfully");
                var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientoToSync.id);
                if (updateEmprendimiento != null) {
                  //Se recupera el idDBR del emprendimiento
                  updateEmprendimiento.idDBR = idDBR;
                  dataBase.emprendimientosBox.put(updateEmprendimiento);
                  //Se marca como realizada en Pocketbase la instrucción en Bitacora
                  bitacora.executePocketbase = true;
                  dataBase.bitacoraBox.put(bitacora);
                  if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                    //Se elimina la instrucción de la bitacora
                    dataBase.bitacoraBox.remove(bitacora.id);
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
            if (emprendimientoToSync.idDBR == null) {
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
                "id_fase_emp_fk": faseInscricto.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emprendedor_fk": emprendimientoToSync.emprendedor.target!.idDBR,
                "id_emi_web": emprendimientoToSync.idEmiWeb,
              });
              if (recordEmprendimiento.id.isNotEmpty) {
                String idDBR = recordEmprendimiento.id;
                print("Emprendimiento created succesfully");
                var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientoToSync.id);
                if (updateEmprendimiento != null) {
                  //Se recupera el idDBR del emprendimiento
                  updateEmprendimiento.idDBR = idDBR;
                  dataBase.emprendimientosBox.put(updateEmprendimiento);
                  //Se marca como realizada en Pocketbase la instrucción en Bitacora
                  bitacora.executePocketbase = true;
                  dataBase.bitacoraBox.put(bitacora);
                  if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                    //Se elimina la instrucción de la bitacora
                    dataBase.bitacoraBox.remove(bitacora.id);
                  } 
                  return true;
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          return false;
        } 
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
  } catch (e) {
    print('ERROR - function syncAddEmprendedor(): $e');
    return false;
  }
}

 bool syncAddEmprendimiento(Bitacora bitacora) {
    print("Estoy en El syncAddEmprendimiento de Emi Web");
    try {
      //Se marca como realizada en Pocketbase la instrucción en Bitacora
      bitacora.executePocketbase = true;
      dataBase.bitacoraBox.put(bitacora);
      if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
        //Se elimina la instrucción de la bitacora
        dataBase.bitacoraBox.remove(bitacora.id);
      } 
      return true;
    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return false;
    }
  }

  Future<bool> syncAddJornada1(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada1");
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              print("Se recupera el idDBR de la Tarea");
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb,
              });

              if (recordJornada.id.isNotEmpty) {
                //Se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                print("Se recupera el idDBR de la jornada");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb,
              });

              if (recordJornada.id.isNotEmpty) {
                //Se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                print("Se recupera el idDBR de la jornada");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
          } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada1(): $e');
      return false;
    }
}

  Future<bool> syncAddJornada2(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada2");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            // Creamos y enviamos las imágenes de la jornada
            for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
              if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                final recordImagen = await client.records.create('imagenes', body: {
                  "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                  "id_emi_web": jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                  "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                });
                jornada.tarea.target!.imagenes.toList()[i].idDBR = recordImagen.id;
                dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } else {
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } 
            }
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb,
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              print("Se recupera el idDBR de la Tarea");
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb,
              });
              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb,
              });

              if (recordJornada.id.isNotEmpty) {
                print("Se recupera el idDBR de la jornada");
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
          } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada2(): $e');
      return false;
    }
}

  Future<bool> syncAddJornada3(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada3");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            // Creamos y enviamos las imágenes de la jornada
            for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
              if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                final recordImagen = await client.records.create('imagenes', body: {
                  "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                  "id_emi_web": jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                  "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                });
                jornada.tarea.target!.imagenes.toList()[i].idDBR = recordImagen.id;
                dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } else {
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } 
            }
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb,
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo actualizamos el catalogoProyecto del emprendimiento
              final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
              if (emprendimiento != null) {
                final recordCatalogoProyecto = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
                  "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
                });
                if (recordCatalogoProyecto.id.isNotEmpty) {
                  //Tercero creamos la jornada  
                  final recordJornada = await client.records.create('jornadas', body: {
                    "num_jornada": jornada.numJornada,
                    "id_tarea_fk": tareaToSync.idDBR,
                    "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                    "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": jornada.completada,
                    "id_emi_web": jornada.idEmiWeb,
                  });

                  if (recordJornada.id.isNotEmpty) {
                    //Cuarto se recupera el idDBR de la jornada
                    jornada.idDBR = recordJornada.id;
                    dataBase.jornadasBox.put(jornada);
                    //Se marca como realizada en Pocketbase la instrucción en Bitacora
                    bitacora.executePocketbase = true;
                    dataBase.bitacoraBox.put(bitacora);
                    if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                      //Se elimina la instrucción de la bitacora
                      dataBase.bitacoraBox.remove(bitacora.id);
                    } 
                    return true;
                  } else {
                    // No se pudo postear la jornada
                    return false;
                  } 
                } else {
                  //No se pudo actualizar el catálogo proyecto del emprendimiento
                  return false;
                }
              } else {
                //No se pudo recuperar el emprendimiento
                return false;
              }
            } else {
              // No se pudo postear la tarea
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo actualizamos el catalogoProyecto del emprendimiento
              final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
              if (emprendimiento != null) {
                final recordCatalogoProyecto = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
                  "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
                });
                if (recordCatalogoProyecto.id.isNotEmpty) {
                  //Tercero creamos la jornada  
                  final recordJornada = await client.records.create('jornadas', body: {
                    "num_jornada": jornada.numJornada,
                    "id_tarea_fk": tareaToSync.idDBR,
                    "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                    "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": jornada.completada,
                    "id_emi_web": jornada.idEmiWeb,
                  });

                  if (recordJornada.id.isNotEmpty) {
                    //Cuarto se recupera el idDBR de la jornada
                    jornada.idDBR = recordJornada.id;
                    dataBase.jornadasBox.put(jornada);
                    //Se marca como realizada en Pocketbase la instrucción en Bitacora
                    bitacora.executePocketbase = true;
                    dataBase.bitacoraBox.put(bitacora);
                    if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                      //Se elimina la instrucción de la bitacora
                      dataBase.bitacoraBox.remove(bitacora.id);
                    } 
                    return true;
                  } else {
                    // No se pudo postear la jornada
                    return false;
                  } 
                } else {
                  //No se pudo actualizar el catálogo proyecto del emprendimiento
                  return false;
                }
              } else {
                //No se pudo recuperar el emprendimiento
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          } 
        } else {
          // No hay ninguna tarea asociada a la jornada
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada3(): $e');
      return false;
    }
}

  Future<bool> syncAddJornada4(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada4");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            // Creamos y enviamos las imágenes de la jornada
            for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
              if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                final recordImagen = await client.records.create('imagenes', body: {
                  "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                  "id_emi_web": jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                  "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                });
                jornada.tarea.target!.imagenes.toList()[i].idDBR = recordImagen.id;
                dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } else {
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } 
            }
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb,
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              print("Se recupera el idDBR de la Tarea");
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb,
              });

              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb,
              });

              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
          } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada4(): $e');
      return false;
    }
}


  Future<bool> syncAddConsultoria(Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en syncAddConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(consultoria.tareas.first.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            //Primero creamos la tarea asociada a la consultoría
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "id_porcentaje_fk": tareaToSync.porcentaje.target!.idDBR,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb,
          });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              print("Se recupera el idDBR de la Tarea");
              //Segundo creamos la consultoria
              final recordConsultoria = await client.records.create('consultorias', body: {
                "id_emprendimiento_fk": consultoria.emprendimiento.target!.idDBR,
                "id_tarea_fk": [recordTarea.id],
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
                "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
                "id_emi_web": consultoria.idEmiWeb,
              });

              if (recordConsultoria.id.isNotEmpty) {
                //Se recupera el idDBR de la consultoría
                consultoria.idDBR = recordConsultoria.id;
                dataBase.consultoriasBox.put(consultoria);
                print("Se recupera el idDBR de la consultoría");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                // No se postea con éxito la consultoría
                return false;
              }
            } else {
              // No se postea con éxito la tarea
              return false;
            }
          } else {
            if (consultoria.idDBR == null) {
              //Segundo creamos la consultoria
              final recordConsultoria = await client.records.create('consultorias', body: {
                "id_emprendimiento_fk": consultoria.emprendimiento.target!.idDBR,
                "id_tarea_fk": [tareaToSync.idDBR],
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
                "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
                "id_emi_web": consultoria.idEmiWeb,
              });

              if (recordConsultoria.id.isNotEmpty) {
                //Se recupera el idDBR de la consultoría
                consultoria.idDBR = recordConsultoria.id;
                dataBase.consultoriasBox.put(consultoria);
                print("Se recupera el idDBR de la consultoría");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                // No se postea con éxito la consultoría
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          // No se encontró una tarea asociada a la consultoría
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddConsultoria(): $e');
      return false;
    }
  }

  Future<bool> syncAddProductoEmprendedor(ProductosEmp productoEmp, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoEmp");
    try {
      if (!bitacora.executePocketbase) {
        final imagenToSync = dataBase.imagenesBox.query(Imagenes_.id.equals(productoEmp.imagen.target?.id ?? -1)).build().findUnique();
        if (imagenToSync != null) {  
          if (imagenToSync.idDBR == null) {
            //Primero creamos la imagen asociada al producto Emp
            final recordImagen = await client.records.create('imagenes', body: {
              "nombre": imagenToSync.nombre,
              "id_emi_web": imagenToSync.idEmiWeb,
              "base64": imagenToSync.base64,
            });
            if (recordImagen.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              imagenToSync.idDBR = recordImagen.id;
              dataBase.imagenesBox.put(imagenToSync);
              print("Se recupera el idDBR de la Imagen");
              //Segundo creamos el producto Emp 
              final recordProductoEmp = await client.records.create('productos_emp', body: {
                "nombre_prod_emp": productoEmp.nombre,
                "descripcion": productoEmp.descripcion,
                "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
                "costo_prod_emp": productoEmp.costo,
                "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
                "archivado": productoEmp.archivado,
                "id_imagen_fk": imagenToSync.idDBR,
                "id_emi_web": productoEmp.idEmiWeb,
              });
              if (recordProductoEmp.id.isNotEmpty) {
                productoEmp.idDBR = recordProductoEmp.id;
                dataBase.productosEmpBox.put(productoEmp);
                print("Producto Emprendedor created succesfully");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              }
              else{
                // No se pudo postear el producto Emp
                return false;
              }    
            } else {
              // No se pudo postear la imagen asociada al producto Emp
              return false;
            }
          } else {
            if (productoEmp.idDBR == null) {
              //Segundo creamos el producto Emp 
              final recordProductoEmp = await client.records.create('productos_emp', body: {
                "nombre_prod_emp": productoEmp.nombre,
                "descripcion": productoEmp.descripcion,
                "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
                "costo_prod_emp": productoEmp.costo,
                "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
                "archivado": productoEmp.archivado,
                "id_imagen_fk": imagenToSync.idDBR,
                "id_emi_web": productoEmp.idEmiWeb,
              });
              if (recordProductoEmp.id.isNotEmpty) {
                productoEmp.idDBR = recordProductoEmp.id;
                dataBase.productosEmpBox.put(productoEmp);
                print("Producto Emprendedor created succesfully");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              }
              else{
                // No se pudo postear el producto Emp
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          // No hay imagen asociada al producto Emp
          if (productoEmp.idDBR == null) {
            //Primero creamos el producto Emp 
            final recordProductoEmp = await client.records.create('productos_emp', body: {
              "nombre_prod_emp": productoEmp.nombre,
              "descripcion": productoEmp.descripcion,
              "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
              "costo_prod_emp": productoEmp.costo,
              "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
              "archivado": productoEmp.archivado,
              "id_emi_web": productoEmp.idEmiWeb,
            });
            if (recordProductoEmp.id.isNotEmpty) {
              productoEmp.idDBR = recordProductoEmp.id;
              dataBase.productosEmpBox.put(productoEmp);
              print("Producto Emprendedor created succesfully");
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
            else{
              // No se pudo postear el producto Emp
              return false;
            }
          } else {
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddProductoEmp(): $e');
      return false;
    }
  }

  Future<bool> syncAddVenta(Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncAddVenta");
    try {
      if (!bitacora.executePocketbase) {
        if (venta.idDBR == null) {
          //Primero creamos la venta
          final recordVenta = await client.records.create('ventas', body: {
              "id_emprendimiento_fk": venta.emprendimiento.target!.idDBR,
              "fecha_inicio": venta.fechaInicio.toUtc().toString(),
              "fecha_termino": venta.fechaTermino.toUtc().toString(),
              "total": venta.total,
              "archivado": venta.archivado,
              "id_emi_web": venta.idEmiWeb,
          });
          if (recordVenta.id.isNotEmpty) {
            //Se recupera el idDBR de la venta
            venta.idDBR = recordVenta.id;
            dataBase.ventasBox.put(venta);
            print("Se recupera el idDBR de la Venta");
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            // Falló al postear la venta en Pocketbase
            return false;
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddVenta(): $e');
      return false;
    }
  }

  Future<bool> syncAddProductoVendido(ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoVendido");
      try {
        if (!bitacora.executePocketbase) {
        if (productoVendido.idDBR == null) {
          //Primero creamos el producto Vendido
          final recordProdVendido = await client.records.create('prod_vendidos', body: {
              "id_productos_emp_fk": productoVendido.productoEmp.target!.idDBR,
              "cantidad_vendida": productoVendido.cantVendida,
              "subTotal": productoVendido.subtotal,
              "precio_venta": productoVendido.precioVenta,
              "id_venta_fk": productoVendido.venta.target!.idDBR,
              "id_emi_web": productoVendido.idEmiWeb,
          });
          if (recordProdVendido.id.isNotEmpty) {
            //Se recupera el idDBR del prod Vendido
            productoVendido.idDBR = recordProdVendido.id;
            dataBase.productosVendidosBox.put(productoVendido);
            print("Se recupera el idDBR del Producto Vendido");
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            // Falló al postear el producto Vendido en Pocketbase
            return false;
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddProductoVendido(): $e');
      return false;
    }
  }

  Future<bool> syncAddInversion(Inversiones inversion, Bitacora bitacora) async {
    try {
      print("Estoy en syncAddInversion");
      if (!bitacora.executePocketbase) {
        if (inversion.idDBR == null) {
          //Primero creamos la inversion  
          //Se busca el estado de inversión 'Solicitada'
          final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
          if (newEstadoInversion != null) {
            final recordInversion = await client.records.create('inversiones', body: {
              "id_emprendimiento_fk": inversion.emprendimiento.target!.idDBR,
              "id_estado_inversion_fk": newEstadoInversion.idDBR,
              "porcentaje_pago": inversion.porcentajePago,
              "monto_pagar": inversion.montoPagar,
              "saldo": inversion.saldo,
              "total_inversion": inversion.totalInversion,
              "inversion_recibida": true,
              "pago_recibido": false,
              "producto_entregado": false,
              "id_emi_web": inversion.idEmiWeb,
            });

          if (recordInversion.id.isNotEmpty) {     
            //Se recupera el idDBR de la inversion
            inversion.idDBR = recordInversion.id;
            dataBase.inversionesBox.put(inversion);
            print("Se recupera el idDBR de la inversion");     
            //Segundo creamos la instancia de inversion x prod Cotizados en el backend
            final inversionXprodCotizados = inversion.inversionXprodCotizados.last;
            final recordInversionXProdCotizados = await client.records.create('inversion_x_prod_cotizados', body: {
              "id_inversion_fk": inversionXprodCotizados.inversion.target!.idDBR,
              "id_emi_web": inversionXprodCotizados.idEmiWeb,
            });
            if (recordInversionXProdCotizados.id.isNotEmpty) {
              //Tercero creamos los productos solicitados asociados a la inversion
              final prodSolicitadosToSync = inversion.prodSolicitados.toList();
              if (prodSolicitadosToSync.isNotEmpty) {  
                for (var i = 0; i < prodSolicitadosToSync.length; i++) {
                  // Creamos y enviamos las imágenes de los prod Solicitados
                  if (prodSolicitadosToSync[i].imagen.target != null) {
                    // El prod Solicitado está asociado a una imagen
                    final recordImagen = await client.records.create('imagenes', body: {
                      "nombre": prodSolicitadosToSync[i].imagen.target!.nombre,
                      "id_emi_web": prodSolicitadosToSync[i].imagen.target!.idEmiWeb,
                      "base64": prodSolicitadosToSync[i].imagen.target!.base64,
                    });
                    if (recordImagen.id.isNotEmpty) {
                      prodSolicitadosToSync[i].imagen.target!.idDBR = recordImagen.id;
                      dataBase.imagenesBox.put(prodSolicitadosToSync[i].imagen.target!);
                      final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                        "producto": prodSolicitadosToSync[i].producto,
                        "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                        "descripcion": prodSolicitadosToSync[i].descripcion,
                        "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                        "cantidad": prodSolicitadosToSync[i].cantidad,
                        "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                        "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                        "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                        "id_inversion_fk": inversion.idDBR,
                        "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                        "id_imagen_fk": prodSolicitadosToSync[i].imagen.target!.idDBR,
                      });
                      if (recordProdSolicitado.id.isNotEmpty) {
                        //Se recupera el idDBR del prod Solicitado
                        prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                        dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                        print("Se recupera el idDBR del Prod Solicitado");
                      } else {
                        //No se pudo postear el producto Solicitado a Pocketbase
                        return false;
                      }
                    } else {
                      // No se pudo postear la imagen del prod Solicitado a Pocketbase
                      return false;
                    }
                  } else {
                    // El prod Solicitado no está asociado a una imagen
                    final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                      "producto": prodSolicitadosToSync[i].producto,
                      "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                      "descripcion": prodSolicitadosToSync[i].descripcion,
                      "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                      "cantidad": prodSolicitadosToSync[i].cantidad,
                      "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                      "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                      "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                      "id_inversion_fk": inversion.idDBR,
                      "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                    });
                    if (recordProdSolicitado.id.isNotEmpty) {
                      //Se recupera el idDBR del prod Solicitado
                      prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                      dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                      print("Se recupera el idDBR del Prod Solicitado");
                    } else {
                      //No se pudo postear el producto Solicitado a Pocketbase
                      return false;
                    }
                  }
                }
                // Se recupera el idDBR de la instancia de inversion x prod Cotizados
                inversionXprodCotizados.idDBR = recordInversionXProdCotizados.id;
                dataBase.inversionesXprodCotizadosBox.put(inversionXprodCotizados);
                print("Se recupera el idDBR de la instancia de inversion x prod Cotizados");
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                //No se encontraron productos Solicitados asociados a la inversión
                return false;
              }
            } else {
              //No se pudo postear la inversionXprodCotizados en Pocketbase
              return false;
            }
          } else {
            //No se pudo postear la inversión en Pocketbase
            return false;
          }
        } else {
          //No se pudo encontrar el estado de la inversión
          return false;
        }
      } else {
        if (inversion.inversionXprodCotizados.last.idDBR == null) {
          //Segundo creamos la instancia de inversion x prod Cotizados en el backend
          final inversionXprodCotizados = inversion.inversionXprodCotizados.last;
          final recordInversionXProdCotizados = await client.records.create('inversion_x_prod_cotizados', body: {
            "id_inversion_fk": inversionXprodCotizados.inversion.target!.idDBR,
            "id_emi_web": inversionXprodCotizados.idEmiWeb,
          });
          if (recordInversionXProdCotizados.id.isNotEmpty) {
            //Tercero creamos los productos solicitados asociados a la inversion
            final prodSolicitadosToSync = inversion.prodSolicitados.toList();
            if (prodSolicitadosToSync.isNotEmpty) {  
              for (var i = 0; i < prodSolicitadosToSync.length; i++) {
                // Creamos y enviamos las imágenes de los prod Solicitados
                if (prodSolicitadosToSync[i].imagen.target != null) {
                  // El prod Solicitado está asociado a una imagen
                  final recordImagen = await client.records.create('imagenes', body: {
                    "nombre": prodSolicitadosToSync[i].imagen.target!.nombre,
                    "id_emi_web": prodSolicitadosToSync[i].imagen.target!.idEmiWeb,
                    "base64": prodSolicitadosToSync[i].imagen.target!.base64,
                  });
                  if (recordImagen.id.isNotEmpty) {
                    prodSolicitadosToSync[i].imagen.target!.idDBR = recordImagen.id;
                    dataBase.imagenesBox.put(prodSolicitadosToSync[i].imagen.target!);
                    final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                      "producto": prodSolicitadosToSync[i].producto,
                      "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                      "descripcion": prodSolicitadosToSync[i].descripcion,
                      "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                      "cantidad": prodSolicitadosToSync[i].cantidad,
                      "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                      "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                      "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                      "id_inversion_fk": inversion.idDBR,
                      "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                      "id_imagen_fk": prodSolicitadosToSync[i].imagen.target!.idDBR,
                    });
                    if (recordProdSolicitado.id.isNotEmpty) {
                      //Se recupera el idDBR del prod Solicitado
                      prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                      dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                      print("Se recupera el idDBR del Prod Solicitado");
                    } else {
                      //No se pudo postear el producto Solicitado a Pocketbase
                      return false;
                    }
                  } else {
                    // No se pudo postear la imagen del prod Solicitado a Pocketbase
                    return false;
                  }
                } else {
                  // El prod Solicitado no está asociado a una imagen
                  final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                    "producto": prodSolicitadosToSync[i].producto,
                    "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                    "descripcion": prodSolicitadosToSync[i].descripcion,
                    "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                    "cantidad": prodSolicitadosToSync[i].cantidad,
                    "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                    "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                    "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                    "id_inversion_fk": inversion.idDBR,
                    "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                  });
                  if (recordProdSolicitado.id.isNotEmpty) {
                    //Se recupera el idDBR del prod Solicitado
                    prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                    dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                    print("Se recupera el idDBR del Prod Solicitado");
                  } else {
                    //No se pudo postear el producto Solicitado a Pocketbase
                    return false;
                  }
                }
              }
              // Se recupera el idDBR de la instancia de inversion x prod Cotizados
              inversionXprodCotizados.idDBR = recordInversionXProdCotizados.id;
              dataBase.inversionesXprodCotizadosBox.put(inversionXprodCotizados);
              print("Se recupera el idDBR de la instancia de inversion x prod Cotizados");
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se encontraron productos Solicitados asociados a la inversión
              return false;
            }
          } else {
            //No se pudo postear la inversionXprodCotizados en Pocketbase
            return false;
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      }
    } else {
      if (bitacora.executeEmiWeb) {
        //Se elimina la instrucción de la bitacora
        dataBase.bitacoraBox.remove(bitacora.id);
      } 
      return true;
    }
  } catch (e) {
    print('ERROR - function syncAddInversion(): $e');
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

  Future<bool> syncAddImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenUsuario");
    try {
      if (!bitacora.executePocketbase) {
        final recordImagenUsuario = await client.records.create('imagenes', body: {
         "nombre": imagen.nombre,
         "base64": imagen.base64,
         "id_emi_web": imagen.idEmiWeb,
        });
        if (recordImagenUsuario.id.isNotEmpty) {
          //Se recupera el idDBR de la imagen
          imagen.idDBR = recordImagenUsuario.id;
          dataBase.imagenesBox.put(imagen);
          print("Se recupera el idDBR de la Imagen");
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          return false;
        }  
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenUsuario(): $e');
      return false;
    }
}

  Future<bool> syncUpdateImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenUsuario en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('imagenes', imagen.idDBR.toString(), body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
        }); 
        if (record.id.isNotEmpty) {
          print("Imagen Usuario updated succesfully");
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenUsuario(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateFaseEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateFaseEmprendimiento en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final faseActual = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals(bitacora.instruccionAdicional!)).build().findUnique();
        if (faseActual != null) {
          print("ID Promotor: ${emprendimiento.usuario.target!.idDBR}");
          print("ID Emprendedor: ${emprendimiento.emprendedor.target!.idDBR}");

          final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
              "id_fase_emp_fk": faseActual.idDBR,
          }); 

          if (record.id.isNotEmpty) {
            print("Emprendimiento updated succesfully");
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else{
            return false;
          }
        } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateFaseEmprendimiento(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateEstadoInversion(Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEstadoInversion en Pocketbase");
    try {
      print("Instrucción Adicional: ${bitacora.instruccionAdicional}");
      final estadoActual = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals(bitacora.instruccionAdicional!)).build().findUnique();
      if (estadoActual != null) {

        final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
            "id_estado_inversion_fk": estadoActual.idDBR,
        }); 

        if (record.id.isNotEmpty) {
          print("Inversión updated succesfully");
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          print("Se marca como realizada en Pocketbase la instrucción en Bitacora");
          return true;
        }
        else{
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateEstadoInversion(): $e');
      return false;
    }
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

  Future<bool> syncUpdateJornada1(Jornadas jornada) async {
    print("Estoy en El syncUpdateJornada1");
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
              //Segundo actualizamos la jornada
              final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
                  "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "HoI36PzYw1wtbO1",
              }); 

              if (recordJornada.id.isNotEmpty) {
                print("Jornada updated succesfully");
                final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornada.statusSync.target!.id)).build().findUnique();
                if (statusSync != null) {
                  statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
                  dataBase.statusSyncBox.put(statusSync);
                  return true;
                } else {
                  return false;
                }
              }
              else{
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
      }
      else{
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateJornada2(Jornadas jornada) async {
    print("Estoy en El syncUpdateJornada2");
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
              //Segundo actualizamos la jornada
              final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
                  "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "HoI36PzYw1wtbO1",
              }); 

              if (recordJornada.id.isNotEmpty) {
                print("Jornada updated succesfully");
                final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornada.statusSync.target!.id)).build().findUnique();
                if (statusSync != null) {
                  statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
                  dataBase.statusSyncBox.put(statusSync);
                  return true;
                } else {
                  return false;
                }
              }
              else{
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
      }
      else{
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateJornada3(Jornadas jornada) async {
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
              //Segundo actualizamos la jornada
              final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
                  "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "HoI36PzYw1wtbO1",
              }); 

              if (recordJornada.id.isNotEmpty) {
                print("Jornada updated succesfully");
                final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornada.statusSync.target!.id)).build().findUnique();
                if (statusSync != null) {
                  statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
                  dataBase.statusSyncBox.put(statusSync);
                  return true;
                } else {
                  return false;
                }
              }
              else{
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
      }
      else{
        return false;
      }

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

  Future<bool> syncUpdateUsuario(Usuarios usuario, Bitacora bitacora) async {
    print("Estoy en El syncUpdateUsuario");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('emi_users', usuario.idDBR.toString(), body: {
          "nombre_usuario": usuario.nombre,
          "apellido_p": usuario.apellidoP,
          "apellido_m": usuario.apellidoM,
          "telefono": usuario.telefono,
          "id_status_sync_fk": "HoI36PzYw1wtbO1"
        }); 

        if (record.id.isNotEmpty) {
          print("Usuario updated succesfully");
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateUsuario(): $e');
      return false;
    }

  } 
void deleteBitacora() {
  dataBase.bitacoraBox.removeAll();
  notifyListeners();
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

  Future<bool> syncUpdateInversion(Inversiones inversion, Bitacora bitacora) async {
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
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          print("Se marca como realizada en Pocketbase la instrucción en Bitacora");
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
      } catch (e) {
        print('ERROR - function syncUpdateInversion(): $e');
        return false;
      }
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

// PROCESO DE OBTENCIÓN DE PRODUCTOS COTIZADOS 

  Future<bool> executeProductosCotizadosPocketbase(Emprendimientos emprendimiento, Inversiones inversion) async {
    exitoso = await getproductosCotizadosPocketbase(emprendimiento, inversion);
    //Verificamos que no haya habido errores en el proceso
    if (exitoso) {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      notifyListeners();
      return exitoso;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      notifyListeners();
      return exitoso;
    }
  }

  Future<bool> getproductosCotizadosPocketbase(Emprendimientos emprendimiento, Inversiones inversion) async {
    //¿Como recupero la inversionXprodCotizado? Si no está en Objectbox, sólo en pocketBase y Emi Web
    //Se obtiene el último inversionXprodCotizado en Pocketbase
    final recordsInversionXProdCotizado = await client.records.
    getFullList('inversion_x_prod_cotizados', 
    batch: 200, 
    filter: "id_inversion_fk='${
      inversion.idDBR
      }'",
    sort: "-created");
    if (recordsInversionXProdCotizado.isNotEmpty) {
    for (var element in recordsInversionXProdCotizado) {
      print("Records IXPC: ${element.id.toString()}");
    }
    final inversionXprodCotizadosParse =  getInversionXProdCotizadosFromMap(recordsInversionXProdCotizado[0].toString());
    //Obtenemos los productos cotizados
    final recordInversion = await client.records.
    getOne('inversiones', 
    inversion.idDBR!);
    final recordProdCotizados = await client.records.
    getFullList('productos_cotizados', 
    batch: 200, 
    filter: "id_inversion_x_prod_cotizados_fk='${
      inversionXprodCotizadosParse.id
      }'");
    if (recordProdCotizados.isEmpty || recordInversion.id.isEmpty) {
      //No se encontró la inversión ni los productos cotizados
      return false;
    } else {
      print("Se encontraron los prod cotizados y la inversión");
      for (var element in recordProdCotizados) {
        print("Prod Cotizado: ${element.data}");
      }
      print("Id Inversion: ${recordInversion.id}");
      final GetInversion inversionParse = getInversionFromMap(recordInversion.toString());
      final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(inversionParse.idEstadoInversionFk)).build().findUnique();
      if (estadoInversion != null) {
        if (estadoInversion.estado == "En Cotización") {
          final List<GetProdCotizados> listProdCotizados = [];
          for (var element in recordProdCotizados) {
            listProdCotizados.add(getProdCotizadosFromMap(element.toString()));
          }
          print("Dentro de En Cotización");
          print("****Informacion productos cotizados****");
          print("Tamaño: ${recordProdCotizados.length}");
          // Se recupera el idDBR de la instancia de inversion x prod Cotizados
          final nuevaIversionXprodCotizados = InversionesXProdCotizados(
            idDBR: inversionXprodCotizadosParse.id,
            idEmiWeb: inversionXprodCotizadosParse.idEmiWeb,
          );
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1");
          nuevaIversionXprodCotizados.statusSync.target = nuevoSync;
          for (var i = 0; i < recordProdCotizados.length; i++) {
            //Se valida que el nuevo prod Cotizado aún no existe en Objectbox
            final prodCotizadoExistente = dataBase.productosCotBox.query(ProdCotizados_.idDBR.equals(listProdCotizados[i].id)).build().findUnique();
            if (prodCotizadoExistente == null) {
              final nuevoProductoCotizado = ProdCotizados(
              cantidad: listProdCotizados[i].cantidad,
              costoTotal: listProdCotizados[i].costoTotal,
              idDBR: listProdCotizados[i].id,
              aceptado: listProdCotizados[i].aceptado,
              idEmiWeb: listProdCotizados[i].idEmiWeb,
              );
              final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
              final productoProv = dataBase.productosProvBox.query(ProductosProv_.idDBR.equals(listProdCotizados[i].idProductoProvFk)).build().findUnique();
              if (productoProv != null) {
                nuevoProductoCotizado.statusSync.target = nuevoSync;
                nuevoProductoCotizado.inversionXprodCotizados.target = nuevaIversionXprodCotizados;
                nuevoProductoCotizado.productosProv.target = productoProv;
                dataBase.productosCotBox.put(nuevoProductoCotizado);
                nuevaIversionXprodCotizados.prodCotizados.add(nuevoProductoCotizado);
                dataBase.inversionesXprodCotizadosBox.put(nuevaIversionXprodCotizados);
                print('Prod Cotizado agregado exitosamente');
                print("Tamaño ProdCotizados al final: ${dataBase.productosCotBox.getAll().length}");
              } else {
                return false;
              }
            } else {
              print("Ya existe el prod Cotizado en ObjectBox");
              print("Id Pocketbase Prod Cotizado ${prodCotizadoExistente.idDBR}");
              print("Id Emi web Prod Cotizado ${prodCotizadoExistente.idEmiWeb}");
              print("Prod proveedor Prod Cotizado ${prodCotizadoExistente.productosProv.target!.nombre}");

            }
          }
          //Se actualiza el estado de la inversión en ObjectBox
          final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En Cotización")).build().findFirst();
          if (newEstadoInversion != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
              dataBase.statusSyncBox.put(statusSync);
              inversion.estadoInversion.target = newEstadoInversion;
              nuevaIversionXprodCotizados.inversion.target = inversion; //Posible solución al error de PAGOS SCREEN
              dataBase.inversionesXprodCotizadosBox.put(nuevaIversionXprodCotizados);
              inversion.inversionXprodCotizados.add(nuevaIversionXprodCotizados);
              dataBase.inversionesBox.put(inversion);
              print("Inversion updated succesfully");
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          print("No se encuentar en Cotización la inversión");
          return false;
        }
      } else {
        return false;
      }
    }
    } else {
      //No se encontró ninguna inversión x prod Cotizado
      return false;
    }
  }
}
