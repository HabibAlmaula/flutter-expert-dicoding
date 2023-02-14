import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/sub_heading_home.dart';
import 'package:tv/presentation/widgets/tv_list_home.dart';

import 'bloc/home_tv_bloc.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = "home-tv";

  const HomeTvPage({super.key});

  @override
  HomeTvPageState createState() => HomeTvPageState();
}

class HomeTvPageState extends State<HomeTvPage> {
  late HomeTvBloc _homeTvBloc;

  @override
  void initState() {
    _homeTvBloc = context.read<HomeTvBloc>();
    Future.microtask(() {
      _homeTvBloc.add(OnLoadNowPlayingTv());
      _homeTvBloc.add(OnLoadPopularTv());
      _homeTvBloc.add(OnLoadTopRatedTv());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, SearchPage.routeName);
              context.pushRoute(const SearchTvRoute());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeTvBloc, HomeTvState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                Future.microtask(() {
                  _homeTvBloc.add(OnLoadNowPlayingTv());
                  _homeTvBloc.add(OnLoadPopularTv());
                  _homeTvBloc.add(OnLoadTopRatedTv());
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing',
                      style: AppConstant.kHeading6,
                    ),
                    Builder(builder: (context) {
                      if (state.nowPlayingTvState == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.nowPlayingTvState ==
                          RequestState.Loaded) {
                        return TvList(state.nowPlayingTv);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    SubHeadingHome(
                        title: 'Popular',
                        onTap: () => context.pushRoute(
                            ListTvRoute(tvType: FilterType.Popular))),
                    Builder(builder: (context) {
                      if (state.popularTvState == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.popularTvState == RequestState.Loaded) {
                        return TvList(state.popularTv);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    SubHeadingHome(
                        title: 'Top Rated',
                        onTap: () => context.pushRoute(
                            ListTvRoute(tvType: FilterType.TopRated))),
                    Builder(builder: (context) {
                      if (state.topRatedTvState == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.topRatedTvState == RequestState.Loaded) {
                        return TvList(state.topRatedTv);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
