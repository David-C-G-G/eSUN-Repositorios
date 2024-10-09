import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        context.read<RepositoriosDataCubit>().loadNextPage();
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


    return BlocBuilder<RepositoriosDataCubit, RepositoriosDataState>(
      builder: (context, state){
        if(state.isLoading && state.repositorios.isEmpty){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.isLastPage && state.repositorios.isEmpty){
          return const Center(
            child: Text('No hay mas repositorios'),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MasonryGridView.count(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2, 
            mainAxisSpacing: 20,
            crossAxisSpacing: 35,
            itemCount: state.repositorios.length + (state.isLoading ? 1 : 0),
            itemBuilder: (context, index) {

              if(index == state.repositorios.length){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final repositorio = state.repositorios[index];
              return GestureDetector(
                onTap: () => context.push('/repositorio/${repositorio.id}'),
                child: RepositorioCard(repositorio: repositorio)
              );
            },
          ),
        );

      }
    );
    
  }

  
}

