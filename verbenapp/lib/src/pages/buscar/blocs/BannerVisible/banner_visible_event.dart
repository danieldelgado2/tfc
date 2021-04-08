part of 'banner_visible_bloc.dart';

class BannerVisibleEvent extends Equatable {
  const BannerVisibleEvent(this.data);

  final data;
  List<Object> get props => [data];
}
