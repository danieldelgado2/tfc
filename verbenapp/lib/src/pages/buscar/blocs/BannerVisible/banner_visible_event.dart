part of 'banner_visible_bloc.dart';

///
/// Evento para indicar
/// que si se quieren visibilizar/invisibilizar
/// el formulario de Búsqueda
///
class BannerVisibleEvent extends Equatable {
  const BannerVisibleEvent(this.data);

  final data;
  List<Object> get props => [data];
}
