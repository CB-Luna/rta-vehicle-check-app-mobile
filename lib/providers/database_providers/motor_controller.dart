
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';


class MotorController extends ChangeNotifier {

  GlobalKey<FormState> motorFormKey = GlobalKey<FormState>();

  //Datos del formulario Motor
  String aceite = "";
  String observacionesAceite = "";
  String filtroDeAire = "";
  String observacionesFiltroDeAire = "";
  String cpoDeAceleracion = "";
  String observacionesCpoDeAceleracion = "";
  String bujias = "";
  String observacionesBujias = "";
  String bandaCadenaTiempo = "";
  String observacionesBandaCadenaTiempo = "";
  String soportes = "";
  String observacionesSoportes = "";
  String bandas = "";
  String observacionesBandas = "";
  String mangueras = "";
  String observacionesMangueras = "";


  bool validateForm(GlobalKey<FormState> motorFormKey) {
    return motorFormKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    aceite = "";
    observacionesAceite = "";
    filtroDeAire = "";
    observacionesFiltroDeAire = "";
    cpoDeAceleracion = "";
    observacionesCpoDeAceleracion = "";
    bujias = "";
    observacionesBujias = "";
    bandaCadenaTiempo = "";
    observacionesBandaCadenaTiempo = "";
    soportes = "";
    observacionesSoportes = "";
    bandas = "";
    observacionesBandas = "";
    mangueras = "";
    observacionesMangueras = "";
    notifyListeners();
  }

  //*********Formulario Uno
  void actualizarAceiteBueno ()
  {
   if (aceite == "Bueno") {
     aceite = "";
   } else {
      aceite = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAceiteRecomendado ()
  {
   if (aceite == "Recomendado") {
     aceite = "";
   } else {
      aceite = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAceiteUrgente ()
  {
   if (aceite == "Urgente") {
     aceite = "";
   } else {
      aceite = "Urgente";
   }
    notifyListeners();
  }
  void actualizarFiltroDeAireBueno ()
  {
   if (filtroDeAire == "Bueno") {
     filtroDeAire = "";
   } else {
      filtroDeAire = "Bueno";
   }
    notifyListeners();
  }
  void actualizarFiltroDeAireRecomendado ()
  {
   if (filtroDeAire == "Recomendado") {
     filtroDeAire = "";
   } else {
      filtroDeAire = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarFiltroDeAireUrgente ()
  {
   if (filtroDeAire == "Urgente") {
     filtroDeAire = "";
   } else {
      filtroDeAire = "Urgente";
   }
    notifyListeners();
  }


   void actualizarCpoDeAceleracionBueno ()
  {
   if (cpoDeAceleracion == "Bueno") {
     cpoDeAceleracion = "";
   } else {
      cpoDeAceleracion = "Bueno";
   }
    notifyListeners();
  }
  void actualizarCpoDeAceleracionRecomendado ()
  {
   if (cpoDeAceleracion == "Recomendado") {
     cpoDeAceleracion = "";
   } else {
      cpoDeAceleracion = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarCpoDeAceleracionUrgente ()
  {
   if (cpoDeAceleracion == "Urgente") {
     cpoDeAceleracion = "";
   } else {
      cpoDeAceleracion = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBujiasBueno ()
  {
   if (bujias == "Bueno") {
     bujias = "";
   } else {
      bujias = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujiasRecomendado ()
  {
   if (bujias == "Recomendado") {
     bujias = "";
   } else {
      bujias = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujiasUrgente ()
  {
   if (bujias == "Urgente") {
     bujias = "";
   } else {
      bujias = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (aceite != "" 
    && filtroDeAire != ""
    && cpoDeAceleracion != ""
    && bujias != "") {
      return true;
    } else {
      return false;
    }
  }


  //*********Formulario Dos
  void actualizarBandaCadenaTiempoBueno ()
  {
   if (bandaCadenaTiempo == "Bueno") {
     bandaCadenaTiempo = "";
   } else {
      bandaCadenaTiempo = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBandaCadenaTiempoRecomendado ()
  {
   if (bandaCadenaTiempo == "Recomendado") {
     bandaCadenaTiempo = "";
   } else {
      bandaCadenaTiempo = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBandaCadenaTiempoUrgente ()
  {
   if (bandaCadenaTiempo == "Urgente") {
     bandaCadenaTiempo = "";
   } else {
      bandaCadenaTiempo = "Urgente";
   }
    notifyListeners();
  }
  void actualizarSoportesBueno ()
  {
   if (soportes == "Bueno") {
     soportes = "";
   } else {
      soportes = "Bueno";
   }
    notifyListeners();
  }
  void actualizarSoportesRecomendado ()
  {
   if (soportes == "Recomendado") {
     soportes = "";
   } else {
      soportes = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarSoportesUrgente ()
  {
   if (soportes == "Urgente") {
     soportes = "";
   } else {
      soportes = "Urgente";
   }
    notifyListeners();
  }

  void actualizarBandasBueno ()
  {
   if (bandas == "Bueno") {
     bandas = "";
   } else {
      bandas = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBandasRecomendado ()
  {
   if (bandas == "Recomendado") {
     bandas = "";
   } else {
      bandas = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBandasUrgente ()
  {
   if (bandas == "Urgente") {
     bandas = "";
   } else {
      bandas = "Urgente";
   }
    notifyListeners();
  }
  void actualizarManguerasBueno ()
  {
   if (mangueras == "Bueno") {
     mangueras = "";
   } else {
      mangueras = "Bueno";
   }
    notifyListeners();
  }
  void actualizarManguerasRecomendado ()
  {
   if (mangueras == "Recomendado") {
     mangueras = "";
   } else {
      mangueras = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarManguerasUrgente ()
  {
   if (mangueras == "Urgente") {
     mangueras = "";
   } else {
      mangueras = "Urgente";
   }
    notifyListeners();
  }
    bool validarSeccionDosFormulario ()
  {
    if (bandaCadenaTiempo != "" 
    && soportes != ""
    && bandas != ""
    && mangueras != "") {
      return true;
    } else {
      return false;
    }
  }

  
  bool agregarMotor(OrdenTrabajo ordenTrabajo) {
    try {
      //Se válida que la revisión exista en la orden de trabajo
      final fechaRegistro =  DateTime.now();
      final nuevoMotor = Motor(
          aceite: aceite,
          aceiteObservaciones: observacionesAceite,
          filtroDeAire: filtroDeAire,
          filtroDeAireObservaciones: observacionesFiltroDeAire,
          cpoDeAceleracion: cpoDeAceleracion,
          cpoDeAceleracionObservaciones: observacionesCpoDeAceleracion,
          bujias: bujias,
          bujiasObservaciones: observacionesBujias,
          bandaCadenaDeTiempo: bandaCadenaTiempo,
          bandaCadenaDeTiempoObservaciones: observacionesBandaCadenaTiempo,
          soportes: soportes,
          soportesObservaciones: observacionesSoportes,
          bandas: bandas,
          bandasObservaciones: observacionesBandas,
          mangueras: mangueras,
          manguerasObservaciones: observacionesMangueras,
          completado: true,
          fechaRegistro: fechaRegistro,
        );
      //Revisión
      if (ordenTrabajo.estatus.target!.estatus == "Observación")  {
        final estatus = dataBase.estatusBox
          .query(Estatus_.estatus.equals("Revisión"))
          .build()
          .findFirst();
        ordenTrabajo.estatus.target = estatus;
        final nuevaInstruccionEstatusOrdenTrabajo = Bitacora(
          instruccion: 'syncActualizarEstatusOrdenTrabajo',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
          instruccionAdicional: estatus?.estatus,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionEstatusOrdenTrabajo.ordenTrabajo.target = ordenTrabajo;
        dataBase.bitacoraBox.put(nuevaInstruccionEstatusOrdenTrabajo);
      }
      if (ordenTrabajo.revision.target == null) {
        final nuevaRevision = Revision(
          completado: false,
          fechaRegistro: fechaRegistro,
        );
        nuevaRevision.motor.target = nuevoMotor;
        nuevoMotor.revision.target = nuevaRevision;
        nuevaRevision.ordenTrabajo.target = ordenTrabajo;
        ordenTrabajo.revision.target = nuevaRevision;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionRevision = Bitacora(
          instruccion: 'syncAgregarRevision',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionRevision.revision.target = nuevaRevision;
        dataBase.revisionBox.put(nuevaRevision);
        dataBase.bitacoraBox.put(nuevaInstruccionRevision);
        final nuevaInstruccionMotor = Bitacora(
          instruccion: 'syncAgregarMotor',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionMotor.motor.target = nuevoMotor;
        dataBase.motorBox.put(nuevoMotor);
        dataBase.bitacoraBox.put(nuevaInstruccionMotor);
        notifyListeners();
        return true;

      } else {
        nuevoMotor.revision.target = ordenTrabajo.revision.target;
        ordenTrabajo.revision.target!.motor.target = nuevoMotor;
        if (ordenTrabajo.revision.target?.suspensionDireccion.target != null 
          && ordenTrabajo.revision.target?.frenos.target != null
          && ordenTrabajo.revision.target?.fluidos.target != null
          && ordenTrabajo.revision.target?.electrico.target != null
          && ordenTrabajo.revision.target?.motor.target != null) {      
          ordenTrabajo.revision.target!.completado = true;
          final nuevaInstruccionRevision = Bitacora(
            instruccion: 'syncActualizarRevision',
            usuarioPropietario: prefs.getString("userId")!,
            idOrdenTrabajo: ordenTrabajo.id,
          ); //Se crea la nueva instruccion a realizar en bitacora
          nuevaInstruccionRevision.revision.target = ordenTrabajo.revision.target;
          dataBase.bitacoraBox.put(nuevaInstruccionRevision);
        }
        dataBase.revisionBox.put(ordenTrabajo.revision.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionMotor = Bitacora(
          instruccion: 'syncAgregarMotor',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionMotor.motor.target = nuevoMotor;
        dataBase.motorBox.put(nuevoMotor);
        dataBase.bitacoraBox.put(nuevaInstruccionMotor);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {
    notifyListeners();
  }
}
