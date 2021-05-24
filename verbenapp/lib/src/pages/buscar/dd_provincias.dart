import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Verbenapp/src/DAL/models/provincia.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'blocs/BannerBusqueda/banner_busqueda_bloc.dart';

class DropDownProvincias extends StatelessWidget {
  final List<Provincia> provincias;
  final bool enabled;

  final List<Provincia> results = [];

  DropDownProvincias({@required this.provincias, @required this.enabled});
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Provincia>(
      mode: Mode.DIALOG,
      enabled: enabled,
      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 5),
        suffixIcon: Icon(Icons.arrow_drop_down_circle_rounded,
            color: Colors.deepOrangeAccent),
        suffixIconConstraints: BoxConstraints(minHeight: 50, minWidth: 50),
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
        ),
      ),
      searchBoxDecoration: InputDecoration(
          focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.deepOrangeAccent, width: 2))),
      label: 'Provincias',
      showSearchBox: true,
      autoFocusSearchBox: true,
      autoValidateMode: AutovalidateMode.always,
      onFind: (str) async {
        provincias
            .where((e) => (e.nombre.toLowerCase() == str.toLowerCase()) ?? true)
            .forEach((element) => results.add(element));
        return results;
      },
      items: provincias,
      itemAsString: (Provincia p) => p.nombre,
      onChanged: (value) {
        context
            .read<BannerBusquedaBloc>()
            .add(CambiaProvincia(provincia: value));
      },
      dropDownButton: Text(''),
    );
  }
}
