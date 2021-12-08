import 'package:studio_ghbli/models/index.dart';

class GetMovies {
  const GetMovies(this.result);

  final void Function(dynamic action) result;
}

class GetMoviesSuccessful {
  const GetMoviesSuccessful(this.movies);

  final List<Movie> movies;
}

class GetMoviesError {
  const GetMoviesError(this.error);

  final Object error;
}
