import 'package:auto_route/auto_route.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/presentation/pages/tv/home/bloc/home_tv_bloc.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:ditonton/presentation/widgets/sub_heading_home.dart';
import 'package:ditonton/presentation/widgets/tv_list_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = "home-tv";

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
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
        title: Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              context.pushRoute(SearchTvRoute());
            },
            icon: Icon(Icons.search),
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.nowPlayingTvState ==
                          RequestState.Loaded) {
                        return TvList(state.nowPlayingTv);
                      } else {
                        return Text('Failed');
                      }
                    }),
                    SubHeadingHome(
                        title: 'Popular',
                        onTap: () => context.pushRoute(
                            ListTvRoute(tvType: FilterType.Popular))),
                    Builder(builder: (context) {
                      if (state.popularTvState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.popularTvState == RequestState.Loaded) {
                        return TvList(state.popularTv);
                      } else {
                        return Text('Failed');
                      }
                    }),
                    SubHeadingHome(
                        title: 'Top Rated',
                        onTap: () => context.pushRoute(
                            ListTvRoute(tvType: FilterType.TopRated))),
                    Builder(builder: (context) {
                      if (state.topRatedTvState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.topRatedTvState == RequestState.Loaded) {
                        return TvList(state.topRatedTv);
                      } else {
                        return Text('Failed');
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
