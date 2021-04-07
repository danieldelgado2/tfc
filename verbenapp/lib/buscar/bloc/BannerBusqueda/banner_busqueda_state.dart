part of 'banner_busqueda_bloc.dart';

enum BannerBusquedaStatus {
  porProvincia,
  porUbicacion,
  invalid,
}

class BannerBusquedaState extends Equatable {
  const BannerBusquedaState._(
      {this.celebrandose = false,
      this.status = BannerBusquedaStatus.porProvincia,
      this.provincia,
      this.ubicacion});
  const BannerBusquedaState.initial() : this._();
  const BannerBusquedaState.porUbicacion(celb, ubi)
      : this._(
            status: BannerBusquedaStatus.porUbicacion,
            celebrandose: celb,
            ubicacion: ubi);
  const BannerBusquedaState.porProvincia(celb, prov)
      : this._(
            status: BannerBusquedaStatus.porProvincia,
            celebrandose: celb,
            provincia: prov);
  const BannerBusquedaState.invalid()
      : this._(status: BannerBusquedaStatus.invalid);

  final provincia;
  final ubicacion;
  final celebrandose;
  final status;
  @override
  List<Object> get props => [celebrandose];
}
