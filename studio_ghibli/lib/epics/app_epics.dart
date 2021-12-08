import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studio_ghbli/actions/get_movies.dart';
import 'package:studio_ghbli/data/studio_ghibli_api.dart';
import 'package:studio_ghbli/models/index.dart';

// action => action
class AppEpics {
  AppEpics(this._api);

  final MoviesApi _api;

  Epic<AppState> get epics {
    return combineEpics([
      TypedEpic<AppState, GetMovies>(getMovies),
    ]);
  }

  Stream<dynamic> getMovies(
      Stream<GetMovies> actions, EpicStore<AppState> store) {
    print("Epic ");
    print(store.state.movies);
    return actions //
        .flatMap((GetMovies action) => Stream<void>.value(null)
            .asyncMap((_) => _api.getMovies())
            .map<Object>((List<Movie> movies) => GetMoviesSuccessful(movies))
            .onErrorReturnWith((error, stackTrace) => GetMoviesError(error))
            .doOnData(action.result));
  }
}

