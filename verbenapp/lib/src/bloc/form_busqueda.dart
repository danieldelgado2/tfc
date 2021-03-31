import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:verbenapp/src/models/provincia.dart';
import 'package:verbenapp/src/providers/provincia_provider.dart';

class FormularioBloc {
  final _switch = BehaviorSubject<bool>();
  final _cambiosBusqueda = BehaviorSubject<bool>();
  final _checkProximas = BehaviorSubject<bool>();
  final _bannerVisible = BehaviorSubject<bool>();

  final _provinciaSeleccionada = BehaviorSubject<Provincia>();
  final _provinciasDropdown = BehaviorSubject<List<Provincia>>();
  final _onPress = BehaviorSubject<void Function()>();

  final _provinciaProvider = ProvinciaProvider();

  // Recuperar los datos del Stream
  Stream<bool> get switchStream => _switch.stream;
  Stream<bool> get cambiosBusquedaStream => _cambiosBusqueda.stream;
  Stream<bool> get proximasStream => _checkProximas.stream;
  Stream<bool> get bannerVisibleStream => _bannerVisible.stream;
  Stream<Provincia> get provinciaSeleccionadaStream =>
      _provinciaSeleccionada.stream;

  Stream<List<Provincia>> get provinciasDropdownStream =>
      _provinciasDropdown.stream;

  Function(List<Provincia>) get changeProvinciasDropDown =>
      _provinciasDropdown.sink.add;
  Function(Provincia) get changeProvinciaSeleccionada =>
      _provinciaSeleccionada.sink.add;
  Function(bool) get changeSwitch => _switch.sink.add;
  Function(bool) get changeCheckProximas => _checkProximas.sink.add;
  Function(bool) get changeCambiosBusqueda => _cambiosBusqueda.sink.add;

  Function(bool) get changeBannerVisibleSwitch => _bannerVisible.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  Provincia get provinciaSeleccionada => _provinciaSeleccionada.value;
  bool get switchBusqueda => _switch.value;
  bool get bannerVisible => _bannerVisible.value;
  bool get proximasCheck => _checkProximas.value;
  List<Provincia> get provinciasDropdownValue => _provinciasDropdown.value;

  void crearProvinciasDropdown() async => _provinciasDropdown.sink
      .add(await _provinciaProvider.provinciasParaSelect());

  Future<List<Provincia>> getProvinciasFiltradas(String filter) async {
    if (filter.isEmpty) return [];
    var results = [];
    provinciasDropdownValue.forEach((p) {
      var plw = p.nombre.toLowerCase();
      var flw = filter.toLowerCase();
      var found = plw.contains(flw);
      if (!found) return false;
      results.add(p);
    });

    return results;
  }

  dispose() {
    _provinciasDropdown?.close();
    _switch?.close();
    _provinciaSeleccionada?.close();
    _bannerVisible?.close();
    _onPress?.close();
    _checkProximas?.close();
    _cambiosBusqueda?.close();
  }
}
