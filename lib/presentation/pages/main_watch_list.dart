import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watch_list/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/watch_list/watchlist_tv_page.dart';

class MainWatchListPage extends StatefulWidget {
  const MainWatchListPage({Key? key}) : super(key: key);
  static const routeName = "main-watchlist";

  @override
  State<MainWatchListPage> createState() => _MainWatchListPageState();
}

class _MainWatchListPageState extends State<MainWatchListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static List<Tab> _tabs = [
    Tab(child: Container(padding: EdgeInsets.symmetric(horizontal: 32.0),child: Text("Movie"))),
    Tab(child: Container(padding: EdgeInsets.symmetric(horizontal: 32.0),child: Text("Tv"))),
  ];

  static List<Widget> _views = [
    WatchlistMoviesPage(),
    WatchlistTvPage(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        // backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 32),
            height: 45,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25.0)),
            child: TabBar(
              unselectedLabelColor: Colors.black,
              // padding: EdgeInsets.symmetric(horizontal: 32),
              indicator: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius:  BorderRadius.circular(25.0)
              ) ,
              controller: _tabController,
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              onTap: (int index) {
                print('Tab $index is tapped');
              },
              enableFeedback: true,
              tabs: _tabs,
            ),
          ),
          SizedBox(height: 32,),
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
              controller: _tabController,
              children: _views,
            ),
          ),
        ],
      ),
    );
  }
}
