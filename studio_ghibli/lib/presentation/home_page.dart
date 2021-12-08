import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:studio_ghbli/actions/get_movies.dart';
import 'package:studio_ghbli/container/is_loading_container.dart';
import 'package:studio_ghbli/container/movies_container.dart';
import 'package:studio_ghbli/models/index.dart';
import 'package:studio_ghbli/utils/like_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    final Store store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(GetMovies(onResult));

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final double currentPosition = _controller.offset;
    final double maxPosition = _controller.position.maxScrollExtent;

    final Store<AppState> store = StoreProvider.of<AppState>(context);

    if (!store.state.isLoading && currentPosition > maxPosition) {
      store.dispatch(GetMovies(onResult));
    }
  }

  void onResult(dynamic action) {
    if (action is GetMoviesError) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error getting movies'),
            content: Text('${action.error}'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IsLoadingContainer(
            builder: (BuildContext context, bool isLoading) {
              if (!isLoading) {
                return const SizedBox.shrink();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      body: MoviesContainer(
        builder: (BuildContext context, List<Movie> movies) {
          return Container(
            child: ListView.builder(
              controller: _controller,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie movie = movies[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.amber,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                              Container(
                                height: 400,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(movie.image,
                                  ),
                                ),
                              ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: ListTile(
                                          title: Text('${movie.title} - ${movie
                                              .release_date}')
                                      ),
                                  ),
                                  LikeButtonWidget(
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }
}
