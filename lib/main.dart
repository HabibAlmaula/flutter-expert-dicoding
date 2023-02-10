import 'package:auto_route/auto_route.dart';
import 'package:ditonton/bloc_observer.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/movie/detail/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/home/bloc/home_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/search/bloc/search_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/watch_list/bloc/watch_list_movie_bloc.dart';
import 'package:ditonton/presentation/pages/tv/detail/bloc/detail_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/home/bloc/home_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/search/bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/watch_list/bloc/watch_list_tv_bloc.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:ditonton/presentation/route/app_router_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await di.locator.allReady();
  Bloc.observer = HomeObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<HomeMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<HomeTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListTvBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: AutoRouterDelegate(_appRouter,
            navigatorObservers: () => [AppRouterObserver()]),
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder()
          }),
          colorScheme: AppConstant.kColorScheme,
          primaryColor: AppConstant.kRichBlack,
          scaffoldBackgroundColor: AppConstant.kRichBlack,
          textTheme: AppConstant.kTextTheme,
        ),
        builder: (context, router) {
          return router!;
        },
      ),
    );
  }
}
