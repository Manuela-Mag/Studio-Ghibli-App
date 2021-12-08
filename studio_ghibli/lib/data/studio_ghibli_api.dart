import 'dart:convert';
import 'package:http/http.dart';
import 'package:studio_ghbli/models/index.dart';

class MoviesApi {
  Future<List<Movie>> getMovies() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'ghibliapi.herokuapp.com',
      pathSegments: <String>['films']
    );

    final Response response = await get(uri);
    if (response.statusCode != 200) {
      throw StateError('Error fetching the movies.');
    }

    final List<dynamic> body = jsonDecode(response.body);
    print(body);
    return body //
        .map((dynamic item) => Movie.fromJson(item))
        .toList();
  }
}

void main(){
  final MoviesApi api = MoviesApi();
  api.getMovies();
}
