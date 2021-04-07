import 'package:flutter/material.dart';
import 'package:verbenapp/buscar/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/src/DAL/models/provincia.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownProvincias2 extends StatelessWidget {
  final List<Provincia> provincias;
  final bool enabled;

  final List<Provincia> results = [];

  DropDownProvincias2({@required this.provincias, @required this.enabled});
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Provincia>(
      mode: Mode.BOTTOM_SHEET,
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
            .add(PorProvincia(provinciaSelec: value, celebrandose: null));
      },
      dropDownButton: Text(''),
    );
  }
}

// final bloc = Provider.ofFormMapa(context);
//   var _onChange;

//   if (!disabled) {
//     _onChange = (Provincia value) {
//       var lista = bloc.provinciasDropdownValue;
//       lista.removeAt(lista.indexOf(value));
//       lista.insert(0, value);
//       bloc.changeProvinciasDropDown(lista);
//     };
//   }

//   return Container(
//     child: DropdownButton<Provincia>(
//       value: provincias[0],
//       icon: Icon(
//         Icons.arrow_drop_down_circle_rounded,
//         color: Colors.deepPurpleAccent,
//       ),
//       iconSize: 30,
//       elevation: 16,
//       style: TextStyle(fontSize: 25, color: Colors.black),
//       onChanged: _onChange,
//       items: provincias.map<DropdownMenuItem<Provincia>>((Provincia value) {
//         return DropdownMenuItem<Provincia>(
//           value: value,
//           child: Text(value.nombre),
//         );
//       }).toList(),
//     ),
//   );
