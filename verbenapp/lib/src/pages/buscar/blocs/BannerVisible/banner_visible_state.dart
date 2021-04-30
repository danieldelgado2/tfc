part of 'banner_visible_bloc.dart';

///
/// Clase de tipo State, a la que
/// reaccionará la UI gracias a los
/// BlocBuilders o BlocListeners.
///
/// Disponer de varios constructores
/// dependiendo de las propiedades del
/// estado concreto al que va a pasar
///
///
class BannerVisibleState {
  const BannerVisibleState._({this.visible = false});

  const BannerVisibleState.invisible() : this._();
  const BannerVisibleState.visible() : this._(visible: true);

  final visible;

  List<Object> get props => [visible];
}
