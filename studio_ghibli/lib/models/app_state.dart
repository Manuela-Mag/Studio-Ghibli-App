part of models;

@freezed
class AppState with _$AppState {
  const factory AppState({
       @Default(<Movie>[]) List<Movie> movies,
       @Default(false) bool isLoading}) = AppState$;
}
