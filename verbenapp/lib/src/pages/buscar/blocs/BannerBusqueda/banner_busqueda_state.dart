part of 'banner_busqueda_bloc.dart';

enum BannerBusquedaStatus {
  porProvincia,
  porUbicacion,
}

class BannerBusquedaState {
  const BannerBusquedaState._({
    this.celebrandose = false,
    this.status = BannerBusquedaStatus.porProvincia,
  });
  const BannerBusquedaState.initial() : this._();
  const BannerBusquedaState.porUbicacion(
    celb,
  ) : this._(
          status: BannerBusquedaStatus.porUbicacion,
          celebrandose: celb,
        );
  const BannerBusquedaState.porProvincia(celb)
      : this._(
          status: BannerBusquedaStatus.porProvincia,
          celebrandose: celb,
        );

  final celebrandose;
  final status;
  List<Object> get props => [celebrandose, status];
}
