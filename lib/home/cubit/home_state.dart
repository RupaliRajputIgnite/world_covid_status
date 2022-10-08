abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class CountriesFetchSuccessfulState extends HomeState {}

class HomeRefreshState extends HomeState {}

class HomeErrorState extends HomeState {
  final int statusCode;
  HomeErrorState(this.statusCode);
}
