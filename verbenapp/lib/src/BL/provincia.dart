import 'package:verbenapp/src/BL/bl.dart';

class ProvinciaBL {
  final _provinciaRepository = ProvinciaRepository();

  Future<List<Provincia>> provinciasParaSelect() async {
    return await _provinciaRepository.provinciasParaSelect();
  }
}
