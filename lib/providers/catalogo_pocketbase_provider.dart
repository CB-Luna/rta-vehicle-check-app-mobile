import 'package:bizpro_app/modelsPocketbase/get_bancos.dart';
import 'package:bizpro_app/modelsPocketbase/get_condiciones_pago.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/get_porcentaje_avance.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_productos_prov.dart';
import 'package:bizpro_app/modelsPocketbase/get_proveedores.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proveedor.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/modelsPocketbase/get_tipo_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_comunidades.dart';
import 'package:bizpro_app/modelsPocketbase/get_ambito_consultoria.dart';
import 'package:bizpro_app/modelsPocketbase/get_area_circulo.dart';
import 'package:bizpro_app/modelsPocketbase/get_catalogo_proyectos.dart';
import 'package:bizpro_app/modelsPocketbase/get_roles.dart';
import 'package:bizpro_app/modelsPocketbase/get_unidades_medida.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados.dart';
import 'package:bizpro_app/modelsPocketbase/get_municipios.dart';
import 'package:bizpro_app/modelsPocketbase/get_estado_inversiones.dart';
import 'package:bizpro_app/modelsPocketbase/get_familia_productos.dart';
import 'package:bizpro_app/modelsPocketbase/get_fases_emp.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_empaques.dart';
import '../objectbox.g.dart';

class CatalogoPocketbaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
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

  Future<void> getCatalogos() async {
    banderasExistoSync.add(await getEstados());
    banderasExistoSync.add(await getMunicipios());
    banderasExistoSync.add(await getComunidades());
    banderasExistoSync.add(await getTipoProyecto());
    banderasExistoSync.add(await getCatalogosProyectos());
    banderasExistoSync.add(await getFamiliaProd());
    banderasExistoSync.add(await getUnidadMedida());
    banderasExistoSync.add(await getAmbitoConsultoria());
    banderasExistoSync.add(await getAreaCirculo());
    banderasExistoSync.add(await getFasesEmp());
    // await getTipoEmpaque();
    // await getEstadoInversion();
    // await getTipoProveedor();
    // await getCondicionesPago();
    // await getBancos();
    // await getPorcentajeAvance();
    // await getProveedores();
    // await getProductosProv();
    // await getProdProyecto();
    // await getEstadosProdCotizados();
    for (var element in banderasExistoSync) {
      //Aplicamos una operación and para validar que no haya habido un catálogo con False
      exitoso = exitoso && element;
    }
    //Verificamos que no haya habido errores al sincronizar con las banderas
    if (exitoso) {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      notifyListeners();
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      clearDataBase();
      notifyListeners();
    }
  }

//Función para limpiar el contenido de registros en las bases de datos para todos los catálogos
  void clearDataBase() {
    dataBase.comunidadesBox.removeAll();
    dataBase.municipiosBox.removeAll();
    dataBase.estadosBox.removeAll();
  }
  
//Función para recuperar el catálogo de estados desde Pocketbase
  Future<bool> getEstados() async {
    //Se recupera toda la colección de estados en Pocketbase
    final records = await client.records.
    getFullList('estados', batch: 200, sort: '+nombre_estado');
    if (records.isNotEmpty) {
      //Existen datos de estados en Pocketbase
      final List<GetEstados> listEstados = [];
      for (var element in records) {
        listEstados.add(getEstadosFromMap(element.toString()));
      }
      for (var i = 0; i < listEstados.length; i++) {
        //Se valida que el nuevo estado aún no existe en Objectbox
        final estadoExistente = dataBase.estadosBox.query(Estados_.idDBR.equals(listEstados[i].id)).build().findUnique();
        if (estadoExistente == null) {
          if (listEstados[i].id.isNotEmpty) {
            final nuevoEstado = Estados(
            nombre: listEstados[i].nombreEstado,
            activo: listEstados[i].activo,
            idDBR: listEstados[i].id, 
            idEmiWeb: listEstados[i].idEmiWeb,
            );
            dataBase.estadosBox.put(nuevoEstado);
            print('Estado Nuevo agregado exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (estadoExistente.fechaRegistro != listEstados[i].updated) {
            //Se actualiza el registro en Objectbox
            estadoExistente.nombre = listEstados[i].nombreEstado;
            estadoExistente.activo = listEstados[i].activo;
            estadoExistente.fechaRegistro = listEstados[i].updated!;
            dataBase.estadosBox.put(estadoExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de municipios desde Pocketbase
  Future<bool> getMunicipios() async {
    //Se recupera toda la colección de municipios en Pocketbase
    final records = await client.records.
      getFullList('municipios', batch: 200, sort: '+nombre_municipio');
    if (records.isNotEmpty) {
      //Existen datos de muncipios en Pocketbase
      final List<GetMunicipios> listMunicipios = [];
      for (var element in records) {
        listMunicipios.add(getMunicipiosFromMap(element.toString()));
      }
      for (var i = 0; i < listMunicipios.length; i++) {
        //Se valida que el nuevo municipio aún no existe en Objectbox
        final estado = dataBase.estadosBox.query(Estados_.idDBR.equals(listMunicipios[i].idEstadoFk)).build().findUnique();
        final municipioExistente = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listMunicipios[i].id)).build().findUnique();
        if (municipioExistente == null) {
          if (listMunicipios[i].id.isNotEmpty) {
            final nuevoMunicipio = Municipios(
              nombre: listMunicipios[i].nombreMunicipio,
              activo: listMunicipios[i].activo,
              idDBR: listMunicipios[i].id,
              fechaRegistro: listMunicipios[i].updated, 
              idEmiWeb: listMunicipios[i].idEmiWeb,
              );
            if (estado != null) {
              nuevoMunicipio.estados.target = estado;
              dataBase.municipiosBox.put(nuevoMunicipio);
              print('Municipio Nuevo agregado éxitosamente');
            }
            else {
              return false;
            }
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (municipioExistente.fechaRegistro != listMunicipios[i].updated) {
            if (estado != null) {
              //Se actualiza el registro en Objectbox
              municipioExistente.nombre = listMunicipios[i].nombreMunicipio;
              municipioExistente.activo = listMunicipios[i].activo;
              municipioExistente.estados.target = estado;
              municipioExistente.fechaRegistro = listMunicipios[i].updated!;
              dataBase.municipiosBox.put(municipioExistente);
            }
            else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de comunidades desde Pocketbase
  Future<bool> getComunidades() async {
    //Se recupera toda la colección de comunidades en Pocketbase
    final records = await client.records.
      getFullList('comunidades', batch: 200, sort: '+nombre_comunidad');
    if (records.isNotEmpty) {
      //Existen datos de comunidades en Pocketbase
      final List<GetComunidades> listComunidades = [];
      for (var element in records) {
        listComunidades.add(getComunidadesFromMap(element.toString()));
      }
      for (var i = 0; i < listComunidades.length; i++) {
        //Se valida que la nueva comunidad aún no existe en Objectbox
        final municipio = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listComunidades[i].idMunicipioFk)).build().findUnique();
        final comunidadExistente = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listComunidades[i].id)).build().findUnique();
        if (comunidadExistente == null) {
          if (listComunidades[i].id.isNotEmpty) {
            final nuevaComunidad = Comunidades(
              nombre: listComunidades[i].nombreComunidad,
              activo: listComunidades[i].activo,
              idDBR: listComunidades[i].id,
              fechaRegistro: listComunidades[i].updated, 
              idEmiWeb: listComunidades[i].idEmiWeb,
              );
            if (municipio != null) {
              nuevaComunidad.municipios.target = municipio;
              dataBase.comunidadesBox.put(nuevaComunidad);
              print('Comunidad Nueva agregada éxitosamente');
            }
            else {
              return false;
            }
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (comunidadExistente.fechaRegistro != listComunidades[i].updated) {
            if (municipio != null) {
              //Se actualiza el registro en Objectbox
              comunidadExistente.nombre = listComunidades[i].nombreComunidad;
              comunidadExistente.activo = listComunidades[i].activo;
              comunidadExistente.municipios.target = municipio;
              comunidadExistente.fechaRegistro = listComunidades[i].updated!;
              dataBase.comunidadesBox.put(comunidadExistente);
            }
            else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de tipo de proyectos desde Pocketbase
  Future<bool> getTipoProyecto() async {
    //Se recupera toda la colección de tipo de proyecto en Pocketbase
    final records = await client.records.
        getFullList('tipo_proyecto', batch: 200, sort: '+tipo_proyecto');
    if (records.isNotEmpty) {
      //Existen datos de tipo de proyecto en Pocketbase
      final List<GetTipoProyecto> listTipoProyecto = [];
      for (var element in records) {
        listTipoProyecto.add(getTipoProyectoFromMap(element.toString()));
      }
      for (var i = 0; i < listTipoProyecto.length; i++) {
        //Se valida que el nuevo tipo de Proyecto aún no existe en Objectbox
        final tipoProyectoExistente = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listTipoProyecto[i].id)).build().findUnique();
        if (tipoProyectoExistente == null) {
          if (listTipoProyecto[i].id.isNotEmpty) {
            final nuevoTipoProyecto = TipoProyecto(
            tipoProyecto: listTipoProyecto[i].tipoProyecto,
            activo: listTipoProyecto[i].activo,
            idDBR: listTipoProyecto[i].id, 
            idEmiWeb: listTipoProyecto[i].idEmiWeb,
            );
            dataBase.tipoProyectoBox.put(nuevoTipoProyecto);
            print('Tipo Proyecto Nuevo agregado exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (tipoProyectoExistente.fechaRegistro != listTipoProyecto[i].updated) {
            //Se actualiza el registro en Objectbox
            tipoProyectoExistente.tipoProyecto = listTipoProyecto[i].tipoProyecto;
            tipoProyectoExistente.activo = listTipoProyecto[i].activo;
            tipoProyectoExistente.fechaRegistro = listTipoProyecto[i].updated!;
            dataBase.tipoProyectoBox.put(tipoProyectoExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de catalogo proyecto desde Pocketbase
  Future<bool> getCatalogosProyectos() async {
    //Se recupera toda la colección de catalogo proyecto en Pocketbase
    final records = await client.records.
      getFullList('cat_proyecto', batch: 200, sort: '+nombre_proyecto');
    if (records.isNotEmpty) {
      //Existen datos de catalogo proyecto en Pocketbase
      final List<GetCatalogoProyectos> listCatalogoProyecto = [];
      for (var element in records) {
        listCatalogoProyecto.add(getCatalogoProyectosFromMap(element.toString()));
      }
      for (var i = 0; i < listCatalogoProyecto.length; i++) {
        //Se valida que el nuevo catalogo proyecto aún no existe en Objectbox
        final tipoProyecto = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listCatalogoProyecto[i].idTipoProyectoFk)).build().findUnique();
        final catalogoProyectoExistente = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listCatalogoProyecto[i].id)).build().findUnique();
        if (catalogoProyectoExistente == null) {
          if (listCatalogoProyecto[i].id.isNotEmpty) {
            final nuevoCatalogoProyecto = CatalogoProyecto(
              nombre: listCatalogoProyecto[i].nombreProyecto,
              activo: listCatalogoProyecto[i].activo,
              idDBR: listCatalogoProyecto[i].id,
              fechaRegistro: listCatalogoProyecto[i].updated, 
              idEmiWeb: listCatalogoProyecto[i].idEmiWeb,
              );
            if (tipoProyecto != null) {
              nuevoCatalogoProyecto.tipoProyecto.target = tipoProyecto;
              dataBase.catalogoProyectoBox.put(nuevoCatalogoProyecto);
              print('Catalogo Proyecto Nuevo agregado éxitosamente');
            }
            else {
              return false;
            }
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (catalogoProyectoExistente.fechaRegistro != listCatalogoProyecto[i].updated) {
            if (tipoProyecto != null) {
              //Se actualiza el registro en Objectbox
              catalogoProyectoExistente.nombre = listCatalogoProyecto[i].nombreProyecto;
              catalogoProyectoExistente.activo = listCatalogoProyecto[i].activo;
              catalogoProyectoExistente.tipoProyecto.target = tipoProyecto;
              catalogoProyectoExistente.fechaRegistro = listCatalogoProyecto[i].updated!;
              dataBase.catalogoProyectoBox.put(catalogoProyectoExistente);
            }
            else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de familia de producto desde Pocketbase
  Future<bool> getFamiliaProd() async {
    //Se recupera toda la colección de familia producto en Pocketbase
    final records = await client.records.
      getFullList('familia_prod', batch: 200, sort: '+nombre_tipo_prod');
    if (records.isNotEmpty) {
      //Existen datos de familia producto en Pocketbase
      final List<GetFamiliaProductos> listFamiliaProductos = [];
      for (var element in records) {
        listFamiliaProductos.add(getFamiliaProductosFromMap(element.toString()));
      }
      for (var i = 0; i < listFamiliaProductos.length; i++) {
        //Se valida que la nueva familia producto aún no existe en Objectbox
        final familiaProductoExistente = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listFamiliaProductos[i].id)).build().findUnique();
        if (familiaProductoExistente == null) {
          if (listFamiliaProductos[i].id.isNotEmpty) {
            final nuevaFamiliaProducto = FamiliaProd(
            nombre: listFamiliaProductos[i].nombreTipoProd,
            activo: listFamiliaProductos[i].activo,
            idDBR: listFamiliaProductos[i].id, 
            idEmiWeb: listFamiliaProductos[i].idEmiWeb,
            );
            dataBase.familiaProductosBox.put(nuevaFamiliaProducto);
            print('Familia Producto Nueva agregada exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (familiaProductoExistente.fechaRegistro != listFamiliaProductos[i].updated) {
            //Se actualiza el registro en Objectbox
            familiaProductoExistente.nombre = listFamiliaProductos[i].nombreTipoProd;
            familiaProductoExistente.activo = listFamiliaProductos[i].activo;
            familiaProductoExistente.fechaRegistro = listFamiliaProductos[i].updated!;
            dataBase.familiaProductosBox.put(familiaProductoExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de unidad de medida desde Pocketbase
  Future<bool> getUnidadMedida() async {
    //Se recupera toda la colección de unidad de medida en Pocketbase
    final records = await client.records.
      getFullList('und_medida', batch: 200, sort: '+unidad_medida');
    if (records.isNotEmpty) {
      //Existen datos de unidad de medida en Pocketbase
      final List<GetUnidadesMedida> listUnidadMedida = [];
      for (var element in records) {
        listUnidadMedida.add(getUnidadesMedidaFromMap(element.toString()));
      }
      for (var i = 0; i < listUnidadMedida.length; i++) {
        //Se valida que la nueva unidad de medida aún no existe en Objectbox
        final unidadMedidaExistente = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listUnidadMedida[i].id)).build().findUnique();
        if (unidadMedidaExistente == null) {
          if (listUnidadMedida[i].id.isNotEmpty) {
            final nuevaUnidadMedida = UnidadMedida(
            unidadMedida: listUnidadMedida[i].unidadMedida,
            activo: listUnidadMedida[i].activo,
            idDBR: listUnidadMedida[i].id, 
            idEmiWeb: listUnidadMedida[i].idEmiWeb,
            );
            dataBase.unidadesMedidaBox.put(nuevaUnidadMedida);
            print('Unidad de Medida Nueva agregada exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (unidadMedidaExistente.fechaRegistro != listUnidadMedida[i].updated) {
            //Se actualiza el registro en Objectbox
            unidadMedidaExistente.unidadMedida = listUnidadMedida[i].unidadMedida;
            unidadMedidaExistente.activo = listUnidadMedida[i].activo;
            unidadMedidaExistente.fechaRegistro = listUnidadMedida[i].updated!;
            dataBase.unidadesMedidaBox.put(unidadMedidaExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de ámbito consultoría desde Pocketbase
  Future<bool> getAmbitoConsultoria() async {
    //Se recupera toda la colección de ámbito consultoría en Pocketbase
    final records = await client.records.
      getFullList('ambito_consultoria', batch: 200, sort: '+nombre_ambito');
    if (records.isNotEmpty) {
      //Existen datos de ámbito consultoría en Pocketbase
      final List<GetAmbitoConsultoria> listAmbitoConsultoria = [];
      for (var element in records) {
        listAmbitoConsultoria.add(getAmbitoConsultoriaFromMap(element.toString()));
      }
      for (var i = 0; i < listAmbitoConsultoria.length; i++) {
        //Se valida que la nueva ámbito consultoría aún no existe en Objectbox
        final ambitoConsultoriaExistente = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.idDBR.equals(listAmbitoConsultoria[i].id)).build().findUnique();
        if (ambitoConsultoriaExistente == null) {
          if (listAmbitoConsultoria[i].id.isNotEmpty) {
            final nuevoAmbitoConsultoria = AmbitoConsultoria(
            nombreAmbito: listAmbitoConsultoria[i].nombreAmbito,
            activo: listAmbitoConsultoria[i].activo,
            idDBR: listAmbitoConsultoria[i].id, 
            idEmiWeb: listAmbitoConsultoria[i].idEmiWeb,
            );
            dataBase.ambitoConsultoriaBox.put(nuevoAmbitoConsultoria);
            print('Ámbito Consultoría Nuevo agregado exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (ambitoConsultoriaExistente.fechaRegistro != listAmbitoConsultoria[i].updated) {
            //Se actualiza el registro en Objectbox
            ambitoConsultoriaExistente.nombreAmbito = listAmbitoConsultoria[i].nombreAmbito;
            ambitoConsultoriaExistente.activo = listAmbitoConsultoria[i].activo;
            ambitoConsultoriaExistente.fechaRegistro = listAmbitoConsultoria[i].updated!;
            dataBase.ambitoConsultoriaBox.put(ambitoConsultoriaExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de área círculo desde Pocketbase
  Future<bool> getAreaCirculo() async {
    //Se recupera toda la colección de área círculo en Pocketbase
    final records = await client.records.
      getFullList('area_circulo', batch: 200, sort: '+nombre_area');
    if (records.isNotEmpty) {
      //Existen datos de área círculo en Pocketbase
      final List<GetAreaCirculo> listAreaCirculo = [];
      for (var element in records) {
        listAreaCirculo.add(getAreaCirculoFromMap(element.toString()));
      }
      for (var i = 0; i < listAreaCirculo.length; i++) {
        //Se valida que la nueva área círculo aún no existe en Objectbox
        final areaCirculoExistente = dataBase.areaCirculoBox.query(AreaCirculo_.idDBR.equals(listAreaCirculo[i].id)).build().findUnique();
        if (areaCirculoExistente == null) {
          if (listAreaCirculo[i].id.isNotEmpty) {
            final nuevaAreaCirculo = AreaCirculo(
            nombreArea: listAreaCirculo[i].nombreArea,
            activo: listAreaCirculo[i].activo,
            idDBR: listAreaCirculo[i].id, 
            idEmiWeb: listAreaCirculo[i].idEmiWeb,
            );
            dataBase.areaCirculoBox.put(nuevaAreaCirculo);
            print('Área Círculo Nueva agregada exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (areaCirculoExistente.fechaRegistro != listAreaCirculo[i].updated) {
            //Se actualiza el registro en Objectbox
            areaCirculoExistente.nombreArea = listAreaCirculo[i].nombreArea;
            areaCirculoExistente.activo = listAreaCirculo[i].activo;
            areaCirculoExistente.fechaRegistro = listAreaCirculo[i].updated!;
            dataBase.areaCirculoBox.put(areaCirculoExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }

//Función para recuperar el catálogo de fases de emprendimeinto desde Pocketbase
  Future<bool> getFasesEmp() async {
    //Se recupera toda la colección de fases de emprendimiento en Pocketbase
    final records = await client.records.
      getFullList('fases_emp', batch: 200);
    if (records.isNotEmpty) {
      //Existen datos de fases de emprendimiento en Pocketbase
      final List<GetFasesEmp> listFasesEmp = [];
      for (var element in records) {
        listFasesEmp.add(getFasesEmpFromMap(element.toString()));
      }
      for (var i = 0; i < listFasesEmp.length; i++) {
        //Se valida que la nueva fase de emprendimiento aún no existe en Objectbox
        final faseEmprendimientoExistente = dataBase.fasesEmpBox.query(FasesEmp_.idDBR.equals(listFasesEmp[i].id)).build().findUnique();
        if (faseEmprendimientoExistente == null) {
          if (listFasesEmp[i].id.isNotEmpty) {
            final nuevaFaseEmp = FasesEmp(
            fase: listFasesEmp[i].fase,
            idDBR: listFasesEmp[i].id, 
            idEmiWeb: listFasesEmp[i].idEmiWeb,
            );
            dataBase.fasesEmpBox.put(nuevaFaseEmp);
            print('Fase Emprendimiento Nueva agregada exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (faseEmprendimientoExistente.fechaRegistro != listFasesEmp[i].updated) {
            //Se actualiza el registro en Objectbox
            faseEmprendimientoExistente.fase = listFasesEmp[i].fase;
            faseEmprendimientoExistente.fechaRegistro = listFasesEmp[i].updated!;
            dataBase.fasesEmpBox.put(faseEmprendimientoExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  }
  
  Future<void> getRoles() async {
    if (dataBase.rolesBox.isEmpty()) {
      final records = await client.records.
      getFullList('roles', batch: 200, sort: '+rol');
      final List<GetRoles> listRoles = [];
      for (var element in records) {
        listRoles.add(getRolesFromMap(element.toString()));
      }

      print("*****Informacion roles*****");
      for (var i = 0; i < listRoles.length; i++) {
        if (listRoles[i].id.isNotEmpty) {
        final nuevoRol = Roles(
        rol: listRoles[i].rol,
        idDBR: listRoles[i].id,
        fechaRegistro: listRoles[i].updated
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoRol.statusSync.target = nuevoSync;
        dataBase.rolesBox.put(nuevoRol);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Rol agregado exitosamente');
        final record = await client.records.update('roles', listRoles[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Rol actualizado en el backend exitosamente');
          }

        }
      }
      notifyListeners();
      }
  }

  Future<void> getTipoEmpaque() async {
    if (dataBase.tipoEmpaquesBox.isEmpty()) {
      final records = await client.records.
      getFullList('tipo_empaques', batch: 200, sort: '+tipo_empaque');
      final List<GetTipoEmpaques> listTipoEmpaques = [];
      for (var element in records) {
        listTipoEmpaques.add(getTipoEmpaquesFromMap(element.toString()));
      }
      print("****Informacion tipo empaque****");
      for (var i = 0; i < records.length; i++) {
        if (listTipoEmpaques[i].id.isNotEmpty) {
        final nuevoTipoEmpaque = TipoEmpaques(
        tipo: listTipoEmpaques[i].tipoEmpaque,
        idDBR: listTipoEmpaques[i].id,
        activo: listTipoEmpaques[i].activo,
        fechaRegistro: listTipoEmpaques[i].updated
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoTipoEmpaque.statusSync.target = nuevoSync;
        dataBase.tipoEmpaquesBox.put(nuevoTipoEmpaque);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Tipo empaque agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }
  
  Future<void> getEstadoInversion() async {
    if (dataBase.estadoInversionBox.isEmpty()) {
      final records = await client.records.
      getFullList('estado_inversiones', batch: 200, sort: '+estado');
      final List<GetEstadoInversiones> listEstadoInversiones = [];
      for (var element in records) {
        listEstadoInversiones.add(getEstadoInversionesFromMap(element.toString()));
      }
      print("****Informacion estado inversiones****");
      for (var i = 0; i < records.length; i++) {
        if (listEstadoInversiones[i].id.isNotEmpty) {
        final nuevaEstadoInversiones = EstadoInversion(
        estado: listEstadoInversiones[i].estado,
        idDBR: listEstadoInversiones[i].id,
        fechaRegistro: listEstadoInversiones[i].updated
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaEstadoInversiones.statusSync.target = nuevoSync;
        dataBase.estadoInversionBox.put(nuevaEstadoInversiones);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Estado inversion agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

  Future<void> getTipoProveedor() async {
    if (dataBase.tipoProveedorBox.isEmpty()) {
      final records = await client.records.
      getFullList('tipo_proveedor', batch: 200, sort: '+tipo_proveedor');
      final List<GetTipoProveedor> listTipoProveedor = [];
      for (var element in records) {
        listTipoProveedor.add(getTipoProveedorFromMap(element.toString()));
      }
      print("****Informacion tipo proveedor****");
      for (var i = 0; i < records.length; i++) {
        if (listTipoProveedor[i].id.isNotEmpty) {
        final nuevoTipoProveedor = TipoProveedor(
        tipo: listTipoProveedor[i].tipoProveedor,
        idDBR: listTipoProveedor[i].id,
        activo: listTipoProveedor[i].activo,
        fechaRegistro: listTipoProveedor[i].updated
        );
        dataBase.tipoProveedorBox.put(nuevoTipoProveedor);
        print('Tipo proveedor agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

  Future<void> getCondicionesPago() async {
    if (dataBase.condicionesPagoBox.isEmpty()) {
      final records = await client.records.
      getFullList('condiciones_pago', batch: 200, sort: '+condicion_pago');
      final List<GetCondicionesPago> listCondicionesPago = [];
      for (var element in records) {
        listCondicionesPago.add(getCondicionesPagoFromMap(element.toString()));
      }
    
      print("****Informacion condición pago****");
      for (var i = 0; i < records.length; i++) {
        if (listCondicionesPago[i].id.isNotEmpty) {
        final nuevaCondicionPago = CondicionesPago(
        condicion: listCondicionesPago[i].condicionPago,
        idDBR: listCondicionesPago[i].id,
        activo: listCondicionesPago[i].activo,
        fechaRegistro: listCondicionesPago[i].updated
        );
        dataBase.condicionesPagoBox.put(nuevaCondicionPago);
        print('Condición pago agregada exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getBancos() async {
    if (dataBase.bancosBox.isEmpty()) {
      final records = await client.records.
      getFullList('bancos', batch: 200, sort: '+nombre_banco');
      final List<GetBancos> listBancos = [];
      for (var element in records) {
        listBancos.add(getBancosFromMap(element.toString()));
      }
      print("****Informacion banco****");
      for (var i = 0; i < records.length; i++) {
        if (listBancos[i].id.isNotEmpty) {
        final nuevoBanco = Bancos(
        banco: listBancos[i].nombreBanco,
        idDBR: listBancos[i].id,
        activo: listBancos[i].activo,
        fechaRegistro: listBancos[i].updated
        );
        dataBase.bancosBox.put(nuevoBanco);
        print('Banco agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getPorcentajeAvance() async {
    if (dataBase.porcentajeAvanceBox.isEmpty()) {
      final records = await client.records.
      getFullList('porcentaje_avance', batch: 200, sort: '+porcentaje');
      final List<GetPorcentajeAvance> listPorcentaje = [];
      for (var element in records) {
        listPorcentaje.add(getPorcentajeAvanceFromMap(element.toString()));
      }
      print("****Informacion porcentaje****");
      for (var i = 0; i < records.length; i++) {
        if (listPorcentaje[i].id.isNotEmpty) {
        final nuevoPorcentaje = PorcentajeAvance(
        porcentajeAvance: listPorcentaje[i].porcentaje,
        idDBR: listPorcentaje[i].id,
        activo: listPorcentaje[i].activo,
        fechaRegistro: listPorcentaje[i].updated
        );
        dataBase.porcentajeAvanceBox.put(nuevoPorcentaje);
        print('Porcentaje agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getEstadosProdCotizados() async {
    if (dataBase.estadosProductoCotizadosBox.isEmpty()) {
      final records = await client.records.
      getFullList('estado_prod_cotizados', batch: 200, sort: '+estado');
      final List<GetEstadosProdCotizados> listEstadosProdCotizados = [];
      for (var element in records) {
        listEstadosProdCotizados.add(getEstadosProdCotizadosFromMap(element.toString()));
      }

      print("****Informacion estado prod cotizado****");
      for (var i = 0; i < records.length; i++) {
        if (listEstadosProdCotizados[i].id.isNotEmpty) {
        final nuevoEstadoProdCotizado = EstadoProdCotizado(
        estado: listEstadosProdCotizados[i].estado,
        idDBR: listEstadosProdCotizados[i].id,
        fechaRegistro: listEstadosProdCotizados[i].updated
        );
        dataBase.estadosProductoCotizadosBox.put(nuevoEstadoProdCotizado);
        print('Estado prod Cotizado agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getProveedores() async {
    if (dataBase.proveedoresBox.isEmpty()) {
      final records = await client.records.
      getFullList('proveedores', batch: 200, sort: '+nombre_fiscal');
      final List<GetProveedores> listProveedores = [];
      for (var element in records) {
        listProveedores.add(getProveedoresFromMap(element.toString()));
      }
      print("****Informacion proveedor****");
      for (var i = 0; i < records.length; i++) {
        if (listProveedores[i].id.isNotEmpty) {
          final nuevoProveedor = Proveedores(
          nombreFiscal: listProveedores[i].nombreFiscal,
          rfc: listProveedores[i].rfc,
          direccion: listProveedores[i].direccion,
          nombreEncargado: listProveedores[i].nombreEncargado,
          clabe: listProveedores[i].clabe,
          telefono: listProveedores[i].telefono,
          registradoPor: listProveedores[i].registradoPor,
          archivado: listProveedores[i].archivado,
          idDBR: listProveedores[i].id,
          fechaRegistro: listProveedores[i].updated
          );
          final tipoProveedor = dataBase.tipoProveedorBox.query(TipoProveedor_.idDBR.equals(listProveedores[i].idTipoProveedorFk)).build().findUnique();
          final condicionPago = dataBase.condicionesPagoBox.query(CondicionesPago_.idDBR.equals(listProveedores[i].idCondicionPagoFk)).build().findUnique();
          final banco = dataBase.bancosBox.query(Bancos_.idDBR.equals(listProveedores[i].idBancoFk)).build().findUnique();
          final comunidad = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listProveedores[i].idComunidadFk)).build().findUnique();
          if (tipoProveedor != null && condicionPago != null && banco != null && comunidad != null) {
            nuevoProveedor.tipoProveedor.target = tipoProveedor;
            nuevoProveedor.condicionPago.target = condicionPago;
            nuevoProveedor.banco.target = banco;
            nuevoProveedor.comunidades.target = comunidad;
            dataBase.proveedoresBox.put(nuevoProveedor);
            print('Proveedor agregado exitosamente');
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getProductosProv() async {
    if (dataBase.productosProvBox.isEmpty()) {
      final records = await client.records.
      getFullList('productos_prov', batch: 200, sort: '+nombre_prod_prov');
      final List<GetProductosProv> listProductosProv = [];
      for (var element in records) {
        listProductosProv.add(getProductosProvFromMap(element.toString()));
      }
      print("****Informacion producto prov****");
      for (var i = 0; i < records.length; i++) {
        if (listProductosProv[i].id.isNotEmpty) {
          final nuevoProductoProv = ProductosProv(
          nombre: listProductosProv[i].nombreProdProv,
          descripcion: listProductosProv[i].descripcionProdProv,
          marca: listProductosProv[i].marca,
          costo: listProductosProv[i].costoProdProv,
          tiempoEntrega: listProductosProv[i].tiempoEntrega,
          archivado: listProductosProv[i].archivado,
          idDBR: listProductosProv[i].id,
          fechaRegistro: listProductosProv[i].updated
          );
          final proveedor = dataBase.proveedoresBox.query(Proveedores_.idDBR.equals(listProductosProv[i].idProveedorFk)).build().findUnique();
          final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listProductosProv[i].isUndMedidaFk)).build().findUnique();
          final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProductosProv[i].idFamiliaProdFk)).build().findUnique();
          if (proveedor != null && unidadMedida != null && familiaProd != null) {
            nuevoProductoProv.unidadMedida.target = unidadMedida;
            nuevoProductoProv.familiaProducto.target = familiaProd;
            nuevoProductoProv.proveedor.target = proveedor;
            dataBase.productosProvBox.put(nuevoProductoProv);
            print('Prducto Prov agregado exitosamente');
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> getProdProyecto() async {
    if (dataBase.productosProyectoBox.isEmpty()) {
      final records = await client.records.
      getFullList('prod_proyecto', batch: 200, sort: '+producto');

      final List<GetProdProyecto> listProdProyecto = [];
      for (var element in records) {
        listProdProyecto.add(getProdProyectoFromMap(element.toString()));
      }

      print("****Informacion prod Proyecto****");
      for (var i = 0; i < records.length; i++) {
        if (listProdProyecto[i].id.isNotEmpty) {
        final nuevoProdProyecto = ProdProyecto(
        producto: listProdProyecto[i].producto,
        marcaSugerida: listProdProyecto[i].marcaSugerida,
        descripcion: listProdProyecto[i].descripcion,
        proveedorSugerido: listProdProyecto[i].proveedorSugerido,
        cantidad: listProdProyecto[i].cantidad,
        costoEstimado: listProdProyecto[i].costoEstimado,
        idDBR: listProdProyecto[i].id,
        fechaRegistro: listProdProyecto[i].updated
        );
        final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProdProyecto[i].idFamiliaProdFk)).build().findUnique();
        final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(listProdProyecto[i].idTipoEmpaquesFk)).build().findUnique();
        final catalogoProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listProdProyecto[i].idCatalogoProyectoFk)).build().findUnique();
        if (familiaProd != null && tipoEmpaque != null && catalogoProyecto != null) {
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
          nuevoProdProyecto.statusSync.target = nuevoSync;
          nuevoProdProyecto.familiaProducto.target = familiaProd;
          nuevoProdProyecto.tipoEmpaques.target = tipoEmpaque;
          nuevoProdProyecto.catalogoProyecto.target = catalogoProyecto;
          // dataBase.productosProyectoBox.put(nuevoProdProyecto);
          catalogoProyecto.prodProyecto.add(nuevoProdProyecto);
          dataBase.catalogoProyectoBox.put(catalogoProyecto);
          print("TAMANÑO PROD PROYECTO: ${dataBase.productosProyectoBox.getAll().length}");
          print('Prod Proyecto agregado exitosamente');
          }
        }
      }
      notifyListeners();
      }
    }
}
