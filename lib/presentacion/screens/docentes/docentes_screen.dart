import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';


const cards = <Map<String,dynamic>> [

  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },
  { 'elevation': 2.0, 'label':'Elevation 2' },

];

class DocentesScreen extends StatelessWidget {

  static const String name = 'DocentesScreen';

  const DocentesScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return const Scaffold(
      body: _DocentesList(),
    );  
  }
}

class _DocentesList extends StatelessWidget {
  const _DocentesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbar(),

        Expanded(
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              String label = cards[index]['label'];
              // print(label);
              // return Text(label,style: const TextStyle(color: Colors.white),);
              return ListTile(
                title: Text(label, style: const TextStyle(color: Colors.white),),
              );            },
          )
        ),
      ],
    );
  }
}

