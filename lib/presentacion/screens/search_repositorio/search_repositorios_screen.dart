import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class SeachRepositoriosScreen extends StatelessWidget {

  static const String name = 'SearchRepositoriosScreen';

  const SeachRepositoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repositorios', style: TextStyle(color: Colors.white,)),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.search_rounded)
          )
        ],
      ),
      body: const _RepositoriosList(),
    );  
  }
}

class _RepositoriosList extends StatefulWidget {
  const _RepositoriosList();

  @override
  _RepositoriosListState createState() => _RepositoriosListState();
}

class _RepositoriosListState extends State<_RepositoriosList> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent){
        // context.read<RepositoriosDataCubit>().loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center()
          // MasonryGridView.count(
          //   controller: _scrollController,
          //   physics: const BouncingScrollPhysics(),
          //   crossAxisCount: 2, 
          //   mainAxisSpacing: 20,
          //   crossAxisSpacing: 35,
          //   itemBuilder: (context, index) {

              
          //     return GestureDetector(
          //     );
          //   },
          // ),
        );
    
  }

  
}

