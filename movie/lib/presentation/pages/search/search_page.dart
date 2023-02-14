import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import 'bloc/search_movie_bloc.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (query){
                context.read<SearchMovieBloc>().add(OnQueryChanged(query));
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: AppConstant.kHeading6,
            ),
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie:movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                      child: Center(
                    child: Text(state.message),
                  ));
                } else {
                  return Expanded(child: Container());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
