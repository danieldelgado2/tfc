import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/src/pages/form/bloc.dart';
import 'package:verbenapp/src/BL/bl.dart';

class DDLocalidades extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: _sc.height * 0.1,
      width: _sc.width,
      child: DropDownLoc(),
    );
  }
}

class DropDownLoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DDBloc, DDState>(builder: (context, state) {
        if (state.status == DDStatus.initial) {
          context.read<DDBloc>().add(CrearDD());
          return CircularProgressIndicator(
            backgroundColor: Colors.deepOrangeAccent,
          );
        }

        return DropdownSearch<Localidad>(
          mode: Mode.BOTTOM_SHEET,
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
                  const BorderSide(color: Colors.deepOrangeAccent, width: 2),
            ),
          ),
          label: 'Localidades',
          showSearchBox: true,
          autoFocusSearchBox: true,
          autoValidateMode: AutovalidateMode.always,
          onFind: (str) async {
            if (str.isEmpty) return [];
            var results = <Localidad>[];
            state.localidadesDD.forEach((l) {
              if (l.nombre.toLowerCase().contains(str.toLowerCase()))
                results.add(l);
            });

            return results;
          },
          items: state.localidadesDD,
          itemAsString: (Localidad l) => l.nombre,
          onChanged: (value) {
            context.read<FormLocalidadBloc>().add(ChangeDD(value));
            context.read<FormVerbenaBloc>().add(ResetFormVerbena());
          },
          dropDownButton: Text(''),
        );
      }),
    );
  }
}
