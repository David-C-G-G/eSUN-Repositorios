import 'package:esun/presentacion/providers/providers.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';


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

class _RepositoriosList extends ConsumerStatefulWidget {
  const _RepositoriosList();

  @override
  _RepositoriosListState createState() => _RepositoriosListState();
}

class _RepositoriosListState extends ConsumerState{

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener((){
      if((scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent){
        ref.read(repositoriosProvider.notifier).loadNextPage();
      }
    });
    // if()
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final repositoriosState = ref.watch(repositoriosProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2, 
        mainAxisSpacing: 20,
        crossAxisSpacing: 35,
        itemCount: repositoriosState.repositorios.length,
        itemBuilder: (context, index) {
          final repositorio = repositoriosState.repositorios[index];
          return GestureDetector(
            onTap: () => context.push('/repositorio/${ repositorio.id }'),
            child: RepositorioCard(repositorio: repositorio)
          );
        },
      ),
    );
    
  }

  
}

