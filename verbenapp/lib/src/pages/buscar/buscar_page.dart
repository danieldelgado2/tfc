import 'package:flutter/material.dart';

import 'package:verbenapp/src/pages/buscar/verbena_horizontal.dart';
import 'appBar.dart';

class BuscarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BuscarPage(),
    );
  }
}

class _BuscarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return CustomScrollView(slivers: [
      SliverAppBar(
        automaticallyImplyLeading: false,
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: _sc.height * 0.9,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: AppBarMapa(),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [ContainerVerbenas()],
        ),
      )
    ]);
  }
}
