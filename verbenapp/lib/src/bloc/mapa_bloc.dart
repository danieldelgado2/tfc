import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:verbenapp/src/providers/mapa_provider.dart';

class MapaBloc {
  final mapController = new MapController();
  final _mapaProvider = MapaProvider();
  final initialMapOptions = MapOptions(
    center: LatLng(36.72016, -4.42034),
    zoom: 5.8,
  );

  final _ubicacionController = new BehaviorSubject<LocationData>();
  final _cameraPositionController = BehaviorSubject<LatLng>();
//   final _currentPositionController = BehaviorSubject<LocationData>();
//   final _initialcameraposition = LatLng(40.418889, -3.691944);

//   final _provinciaProvider = ProvinciasProvider();

  Stream<LocationData> get ubicacionStream => _ubicacionController.stream;
  Function(LocationData) get changeUbicacionMapa =>
      _ubicacionController.sink.add;
  LocationData get ubicacion {
    var value = _ubicacionController.value;
    if (value == null) init();
    return value;
  }

  void init() async {
    if (await _mapaProvider.enableService() &&
        await _mapaProvider.setPermissions())
      changeUbicacionMapa(await _mapaProvider.getLocation());
  }

  dispose() {
    _ubicacionController?.close();
    _cameraPositionController?.close();
  }
}
