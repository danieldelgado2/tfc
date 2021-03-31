import 'package:flutter/material.dart';
import 'package:verbenapp/src/bloc/provider.dart';
import 'package:verbenapp/src/models/localidad.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownLocalidades extends StatelessWidget {
  final List<Localidad> provincias;
  final bool enabled;

  final List<Localidad> results = [];

  DropDownLocalidades({@required this.provincias, @required this.enabled});
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Localidad>(
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
      label: 'Localidades',
      showSearchBox: true,
      autoFocusSearchBox: true,
      autoValidateMode: AutovalidateMode.always,
      onFind: Provider.ofFormInsertar(context).getLocalidadesFiltradas,
      items: provincias,
      itemAsString: (Localidad p) => p.nombre,
      onChanged: (value) {
        Provider.ofFormInsertar(context).changeLocalidadSeleccionada(value);
      },
      dropDownButton: Text(''),
    );
  }
}

// final bloc = Provider.ofFormulario(context);
//   var _onChange;

//   if (!disabled) {
//     _onChange = (Localidade value) {
//       var lista = bloc.provinciasDropdownValue;
//       lista.removeAt(lista.indexOf(value));
//       lista.insert(0, value);
//       bloc.changeLocalidadesDropDown(lista);
//     };
//   }

//   return Container(
//     child: DropdownButton<Localidade>(
//       value: provincias[0],
//       icon: Icon(
//         Icons.arrow_drop_down_circle_rounded,
//         color: Colors.deepPurpleAccent,
//       ),
//       iconSize: 30,
//       elevation: 16,
//       style: TextStyle(fontSize: 25, color: Colors.black),
//       onChanged: _onChange,
//       items: provincias.map<DropdownMenuItem<Localidade>>((Localidade value) {
//         return DropdownMenuItem<Localidade>(
//           value: value,
//           child: Text(value.nombre),
//         );
//       }).toList(),
//     ),
//   );
