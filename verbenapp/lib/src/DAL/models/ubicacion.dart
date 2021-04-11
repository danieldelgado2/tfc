import 'package:latlong/latlong.dart';
import 'package:verbenapp/src/BL/bl.dart';

class Ubicacion {
  Ubicacion({this.coord, this.localidades});

  LatLng coord;
  List<Localidad> localidades;
}
