part of 'form_bloc.dart';

enum FormStatus {
  initial,
  insertLoc,
  insertProv,
  insertLat,
  insertLng,
  insertRegistro,
  loading,
  creaDropDownProv,
  changeDD
}

class FormState extends Equatable {
  const FormState._(
      {this.localidad = const LocalidadForm('', '', 0.0, 0.0),
      this.status = FormStatus.initial,
      this.localidadesDD = const <Localidad>[]});

  const FormState.initial() : this._();
  const FormState.loading() : this._(status: FormStatus.loading);
  const FormState.insertLoc(LocalidadForm localidad)
      : this._(status: FormStatus.insertLoc, localidad: localidad);
  const FormState.insertProv(LocalidadForm localidad)
      : this._(status: FormStatus.insertProv, localidad: localidad);
  const FormState.insertLat(LocalidadForm localidad)
      : this._(status: FormStatus.insertLat, localidad: localidad);
  const FormState.insertLng(LocalidadForm localidad)
      : this._(status: FormStatus.insertLng, localidad: localidad);
  const FormState.crearDD(List<Localidad> localidadesDDown)
      : this._(
            status: FormStatus.creaDropDownProv,
            localidadesDD: localidadesDDown);
  const FormState.changeDD(LocalidadForm loc)
      : this._(status: FormStatus.changeDD, localidad: loc);

  final FormStatus status;
  final LocalidadForm localidad;
  final List<Localidad> localidadesDD;

  @override
  List<Object> get props => [localidad, status, localidadesDD];
}
