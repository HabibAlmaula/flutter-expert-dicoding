// coverage:ignore-file
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/pages/home/bloc/home_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class ListTvPage extends StatefulWidget {
  static const routeName = '/list-tv';
  final FilterType tvType;

  const ListTvPage({Key? key, required this.tvType}) : super(key: key);

  @override
  State<ListTvPage> createState() => _ListTvPageState();
}

class _ListTvPageState extends State<ListTvPage> {
  late String _title;
  late HomeTvBloc _homeTvBloc;

  @override
  void initState() {
    _homeTvBloc = context.read<HomeTvBloc>();
    //initialize title
    switch (widget.tvType) {
      case FilterType.NowPlaying:
        _title = "Now Playing Tv";
        _homeTvBloc.add(OnLoadNowPlayingTv());
        break;
      case FilterType.Popular:
        _title = "Popular Tv";
        _homeTvBloc.add(OnLoadPopularTv());
        break;
      case FilterType.TopRated:
        _title = "Top Rated Tv";
        _homeTvBloc.add(OnLoadTopRatedTv());
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: BlocBuilder<HomeTvBloc, HomeTvState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (context) {
                switch (widget.tvType) {
                  case FilterType.NowPlaying:
                    if (state.nowPlayingTvState == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.nowPlayingTvState == RequestState.Loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return TvCard(tv: state.nowPlayingTv[index]);
                        },
                        itemCount: state.nowPlayingTv.length,
                      );
                    } else {
                      return Center(
                        key: const Key('error_message'),
                        child: Text(state.nowPlayingTvMessage),
                      );
                    }
                  case FilterType.Popular:
                    if (state.popularTvState == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.popularTvState == RequestState.Loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return TvCard(tv: state.popularTv[index]);
                        },
                        itemCount: state.popularTv.length,
                      );
                    } else {
                      return Center(
                        key: const Key('error_message'),
                        child: Text(state.popularTvMessage),
                      );
                    }
                  case FilterType.TopRated:
                    if (state.topRatedTvState == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.topRatedTvState == RequestState.Loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return TvCard(tv : state.topRatedTv[index]);
                        },
                        itemCount: state.topRatedTv.length,
                      );
                    } else {
                      return Center(
                        key: const Key('error_message'),
                        child: Text(state.topRatedTvMessage),
                      );
                    }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
