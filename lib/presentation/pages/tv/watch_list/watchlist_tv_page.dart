import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/presentation/pages/tv/watch_list/bloc/watch_list_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with WidgetsBindingObserver {
  late WatchListTvBloc _watchListTvBloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _watchListTvBloc = context.read<WatchListTvBloc>();
    Future.microtask(() => _watchListTvBloc.add(OnLoadWatchListTv()));
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListTvBloc, WatchListTvState>(
          builder: (context, state) {
            if (state.requestState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.requestState == RequestState.Loaded) {
              if (state.tv.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/raw/no_data.json",
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      Text("No data found")
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.tv[index];
                    return TvCard(tv);
                  },
                  itemCount: state.tv.length,
                );
              }
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _watchListTvBloc.add(OnLoadWatchListTv());
    }
  }
}
