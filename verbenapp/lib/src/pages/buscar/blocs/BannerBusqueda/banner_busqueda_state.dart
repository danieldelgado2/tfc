part of 'banner_busqueda_bloc.dart';

enum BannerBusquedaStatus { porProvincia, porUbicacion, invalid }

class BannerBusquedaState extends Equatable {
  const BannerBusquedaState._(
      {this.provincia, this.status, this.ubicacion, this.byDelMes});

  const BannerBusquedaState.porProvincia(prov, value)
      : this._(
          status: BannerBusquedaStatus.porProvincia,
          provincia: prov,
          byDelMes: value,
        );
  const BannerBusquedaState.porUbicacion(ubi, value)
      : this._(
          status: BannerBusquedaStatus.porUbicacion,
          ubicacion: ubi,
          byDelMes: value,
        );
  const BannerBusquedaState.invalid(ubi, prov, value)
      : this._(
          status: BannerBusquedaStatus.invalid,
          provincia: prov,
          ubicacion: ubi,
          byDelMes: value,
        );
  final status;
  final provincia;
  final ubicacion;
  final byDelMes;
  @override
  List<Object> get props => [status, provincia, ubicacion, byDelMes];
}
