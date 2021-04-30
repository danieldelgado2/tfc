import 'package:verbenapp/src/BL/bl.dart';

///
/// Usada por los Blocs para hacer operaciones relacionadas
/// con el CRUD
///
class ProvinciaBL {
  final _provinciaRepository = ProvinciaRepository();

  Future<List<Provincia>> provinciasParaSelect() async {
    return await _provinciaRepository.provinciasParaSelect();
  }
}
