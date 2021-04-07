part of 'dropdown_provincias_bloc.dart';

enum DropDownProvinciasStatus { initial, success }

class DropDownProvinciasState extends Equatable {
  const DropDownProvinciasState._(
      {this.status = DropDownProvinciasStatus.initial,
      this.provincias = const <Provincia>[]});
  const DropDownProvinciasState.initial() : this._();
  const DropDownProvinciasState.success(provs)
      : this._(status: DropDownProvinciasStatus.success, provincias: provs);
  final status;
  final provincias;
  @override
  List<Object> get props => [];
}
