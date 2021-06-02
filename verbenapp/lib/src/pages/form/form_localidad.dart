import 'package:Verbenapp/src/pages/form/form_verbena.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Verbenapp/src/pages/form/bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

///
/// Contiene los campos relativos
/// a la localidad localidad que se esta editando
///
class FormLocalidad extends StatefulWidget {
  @override
  _FormLocalidadState createState() => _FormLocalidadState();
}

class _FormLocalidadState extends State<FormLocalidad> {
  Localidad _loc = Localidad(verbenas: []);
  @override
  Widget build(BuildContext context) {
    return BlocListener<FormLocalidadBloc, FormLocalidadState>(
      listener: (context, state) {
        setState(() {
          _loc = state.locEditar;
        });
        if (state.status == FormLocalidadStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar("Oh oh..."));
        } else if (state.status == FormLocalidadStatus.success)
          ScaffoldMessenger.of(context)
              .showSnackBar(_snackBar("Éxito al guardar"));
      },
      child: Container(
        child: Column(
          children: [
            Inputs(
              loc: _loc,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
            // Text(
            //   'Verbenas',
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            // ),
            ListaVerbenas(
              verbenas: _loc.verbenas,
            ),
          ],
        ),
      ),
    );
  }

  Widget _snackBar(text) {
    return SnackBar(
        backgroundColor: Colors.deepOrangeAccent,
        content: Container(
          height: 35,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}

///
/// Los TextFormField de los datos de la
/// localidad que se esta editando
///
class Inputs extends StatefulWidget {
  final loc;

  Inputs({this.loc});
  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  Localidad locEditar;

  @override
  void initState() {
    locEditar = widget.loc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return BlocListener<FormLocalidadBloc, FormLocalidadState>(
        listener: (context, state) {
          setState(() {
            locEditar = state.locEditar;
          });
        },
        child: Container(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Localidad',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                controller: TextEditingController(text: locEditar.nombre),
                style: TextStyle(fontSize: 22),
                onChanged: (value) {
                  setState(() {
                    locEditar.nombre = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Provincia',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                controller: TextEditingController(text: locEditar.provincia),
                style: TextStyle(fontSize: 22),
                onChanged: (value) {
                  setState(() {
                    locEditar.provincia = value;
                  });
                },
              ),
              Container(
                width: sc.width,
                height: sc.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: sc.width * 0.35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Latitud',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        controller: TextEditingController(
                            text: locEditar.latitud.toString()),
                        style: TextStyle(fontSize: 22),
                        onChanged: (value) {
                          var a;
                          if (a = double.tryParse(value) != null)
                            setState(() => locEditar.latitud = a);
                        },
                      ),
                    ),
                    Container(
                      width: sc.width * 0.35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Longitud',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                        controller: TextEditingController(
                            text: locEditar.longitud.toString()),
                        style: TextStyle(fontSize: 22),
                        onChanged: (value) {
                          setState(() {
                            var a;
                            if (a = double.tryParse(value) != null)
                              locEditar.longitud = a;
                          });
                        },
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      width: sc.width * 0.1,
                      child: IconButton(
                          icon: Icon(Icons.location_on_rounded),
                          color: Colors.white,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CogeLocation(
                                    loc: locEditar,
                                  );
                                });
                          }),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Text(
                  'Guardar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                onPressed: () {
                  context
                      .read<FormLocalidadBloc>()
                      .add(GuardarLocalidad(locEditar));
                },
              ),
            ],
          ),
        ));
  }
}

class CogeLocation extends StatefulWidget {
  final loc;
  CogeLocation({this.loc});
  @override
  _CogeLocationState createState() => _CogeLocationState();
}

class _CogeLocationState extends State<CogeLocation> {
  List<Marker> markers = [];
  final controller = MapController();
  LatLng coords;

  @override
  void initState() {
    if (widget.loc.latitud != 0.0 && widget.loc.longitud != 0.0) {
      coords = LatLng(widget.loc.latitud, widget.loc.longitud);
      markers = [
        Marker(
            point: coords,
            builder: (ctx) => Icon(
                  Icons.location_on_rounded,
                  size: 30,
                  color: Colors.red,
                ))
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return AlertDialog(
      titlePadding: EdgeInsets.all(10),
      title: Container(
          child: Text('Pincha sobre un lugar para ver sus coordenadas')),
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        Container(
          width: sc.width,
          child: Column(
            children: [
              Text(coords != null
                  ? '${coords.latitude}, ${coords.longitude}'
                  : ''),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<FormLocalidadBloc>()
                        .add(ModificarLatitud(coords.latitude.toString()));
                    context
                        .read<FormLocalidadBloc>()
                        .add(ModificarLongitud(coords.longitude.toString()));
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar'))
            ],
          ),
        ),
      ],
      content: Container(
        width: sc.width,
        height: sc.height * 0.5,
        color: Colors.purple,
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(
              center: LatLng(36.716667, -4.416667),
              zoom: 6,
              controller: controller,
              onTap: (coord) {
                setState(() {
                  markers = [
                    Marker(
                        point: coord,
                        builder: (ctx) => Icon(
                              Icons.location_on_rounded,
                              size: 30,
                              color: Colors.red,
                            ))
                  ];
                  coords = coord;
                });
              }),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(markers: markers),
          ],
        ),
      ),
    );
  }
}

///
/// Contenedor con todas las verbenas de
/// la localidad que se esta editando
///
class ListaVerbenas extends StatelessWidget {
  final verbenas;
  ListaVerbenas({this.verbenas});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: ListView.builder(
        itemCount: verbenas.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.orange, width: 2.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
            ),
            leading: Icon(Icons.celebration),
            title: Text(verbenas[i].nombre),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                context.read<FormLocalidadBloc>().add(QuitarVerbenas(i));
              },
            ),
            onTap: () {
              //  context
              //       .read<FormVerbenaBloc>()
              //       .add(ChangeVerbena(data: verbenas[i]));
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    final sc = MediaQuery.of(context).size;
                    return Wrap(
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            height: sc.height * 0.75,
                            width: sc.width,
                            child: FormVerbena(
                              verbena: verbenas[i],
                            )),
                      ],
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
