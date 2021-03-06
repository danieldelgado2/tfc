part of 'banner_busqueda_bloc.dart';

enum BannerBusquedaStatus { invalid, valid }

///
/// Clase de tipo State, a la que
/// reaccionarÃ¡ la UI gracias a los
/// BlocBuilders o BlocListeners.
///
/// Disponer de varios constructores
/// dependiendo de las propiedades del
/// estado concreto al que va a pasar
///
///
class BannerBusquedaState extends Equatable {
  const BannerBusquedaState._(
      {this.provincia, this.status, this.ubicacion, this.byDelMes});

  const BannerBusquedaState.valid(ubi, prov, value)
      : this._(
            status: BannerBusquedaStatus.valid,
            provincia: prov,
            byDelMes: value,
            ubicacion: ubi);

  const BannerBusquedaState.invalid()
      : this._(
          status: BannerBusquedaStatus.invalid,
        );
  final status;
  final provincia;
  final ubicacion;
  final byDelMes;
  @override
  List<Object> get props => [status, provincia, ubicacion, byDelMes];
}
