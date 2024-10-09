import 'package:flutter/material.dart';

class RepositorioScreen extends StatefulWidget {

    static const String name = 'RepositorioScreen';
    final String repositorioId;

  const RepositorioScreen({
    required this.repositorioId,
    super.key
    });

  @override
  RepositorioScreenState createState() => RepositorioScreenState();
}

class RepositorioScreenState extends State<RepositorioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Editar Repositorio'),
        ),
        body: Center(
            child: Text(widget.repositorioId,style: TextStyle(color: Colors.white, fontSize: 10)),
        ),
    );
  }
}