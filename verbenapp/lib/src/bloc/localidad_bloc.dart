import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';
import 'package:verbenapp/src/models/localidad.dart';
import 'package:verbenapp/src/models/provincia.dart';
import 'package:verbenapp/src/providers/localidad_provider.dart';

class LocalidadesBloc {
  final _insertarLocalidadesController = new BehaviorSubject<List<Localidad>>();
  final _localidadesMapaController = new BehaviorSubject<List<Localidad>>();
  final _localidadSeleccionadaMapaController = new BehaviorSubject<Localidad>();
  final _isVerbenasCercaController = new BehaviorSubject<bool>();
  final _localidadesProvider = new LocalidadProvider();

  Stream<List<Localidad>> get localidadesInsertadasStream =>
      _insertarLocalidadesController.stream;
  Stream<List<Localidad>> get localidadesMapaStream =>
      _localidadesMapaController.stream;
  Stream<Localidad> get localidadSeleccionadaMapaStream =>
      _localidadSeleccionadaMapaController.stream;

  Function(List<Localidad>) get changeLocalidadesMapa =>
      _localidadesMapaController.sink.add;
  Function(Localidad) get changelocalidadSeleccionadaMapa =>
      _localidadSeleccionadaMapaController.sink.add;
  Function(List<Localidad>) get insertarLocalidades =>
      _insertarLocalidadesController.sink.add;

  List<Localidad> get localidadesMapa => _localidadesMapaController.value;
  Localidad get localidadSeleccionadaMapa =>
      _localidadSeleccionadaMapaController.value;

  void localidadesFromUbicacion(LatLng ubicacion) async =>
      _localidadesMapaController.sink
          .add(await _localidadesProvider.localidadesFromUbicacion(ubicacion));

  void localidadesCelebrandosePorUbicacion(ubi) async =>
      _localidadesMapaController.sink.add(
          await _localidadesProvider.localidadesCelebrandoseFromUbicacion(ubi));

  void localidadesFromProvincia(Provincia provincia) async =>
      _localidadesMapaController.sink
          .add(await _localidadesProvider.localidadesFromProvincia(provincia));
  void localidadesCelebrandosePorProvincia(p) async =>
      _localidadesMapaController.sink.add(
          await _localidadesProvider.localidadesCelebrandoseFromProvincia(p));

  void insertarLocalidadesConVerbenasProximas() async {
    final results = await _localidadesProvider.insertarLocalidadesProximas();
    insertarLocalidades(results);
  }

  dispose() {
    _isVerbenasCercaController?.close();
    _localidadesMapaController?.close();
    _localidadSeleccionadaMapaController?.close();
    _insertarLocalidadesController?.close();
  }
}
