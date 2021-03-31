import 'package:flutter/material.dart';
import 'package:verbenapp/src/bloc/provider.dart';

class FormPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: _form(context));
  }

  Widget _form(context) {
    final sc = MediaQuery.of(context).size;
    return Container(
      width: sc.width,
      child: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [_datosLocalidad(context)],
          ),
        )
      ]),
    );
  }

  Widget _datosLocalidad(context) {
    final sc = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: sc.width,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Latitud'),
              validator: (v) =>
                  (num.tryParse(v) == null) ??
                  'Formato incorrecto. Sólo números',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Longitud'),
              validator: (v) =>
                  (num.tryParse(v) == null) ??
                  'Formato incorrecto. Sólo números',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Provincia'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Verbena'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            ElevatedButton(onPressed: validar(context), child: Text('Guardar'))
          ],
        ),
      ),
    );
  }

  void Function() validar(context) {
    final bloc = Provider.ofFormInsertar(context);

    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Processing Data')));
  }

  // Widget _form(BuildContext context) {
  //   final _screenSize = MediaQuery.of(context).size;
  //   return Container(
  //     width: _screenSize.width,
  //     height: _screenSize.height,
  //     child: Column(
  //       children: [
  //         Text('Selecciona una provincia'),
  //         Center(
  //           child: FloatingActionButton(
  //               child: Icon(Icons.add),
  //               onPressed: () {
  //                 Provider.ofLocalidades(context)
  //                     .insertarLocalidadesConVerbenasProximas();
  //               }),
  //         ),
  //         StreamBuilder(
  //             initialData: [],
  //             stream:
  //                 Provider.ofLocalidades(context).localidadesInsertadasStream,
  //             builder: (context, snapshot) {
  //               if (snapshot.data.isEmpty)
  //                 return Text('No hay verbenas proximamente');
  //               var verbenas = [];
  //               snapshot.data
  //                   .forEach((l) => l.verbenas.forEach((v) => verbenas.add(v)));
  //               return Container(
  //                   color: Colors.pink,
  //                   width: _screenSize.width,
  //                   height: _screenSize.height * 0.4,
  //                   child: ListView.builder(
  //                       scrollDirection: Axis.vertical,
  //                       itemCount: verbenas.length,
  //                       itemBuilder: (context, i) => Text(verbenas[i].nombre)));
  //             })

  //         // StreamBuilder(
  //         //     stream: bloc.provinciasDropdownStream,
  //         //     builder: (context, snapshot) {
  //         //       if (!snapshot.hasData) return Text('cargando..');
  //         //       return DropDownProvincias(
  //         //         provincias: bloc.provinciasDropdownValue,
  //         //         active: true,
  //         //       );
  //         //     }),

  //         // _footer(context)
  //       ],
  //     ),
  //   );
  // }

}
