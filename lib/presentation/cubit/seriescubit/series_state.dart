part of 'series_cubit.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();
}

class SeriesInitial extends SeriesState {
  @override
  List<Object> get props => [];
}
class SeriesLoading extends SeriesState {
  @override
  List<Object> get props => [];
}
class SeriesLoaded extends SeriesState {
 final List<String> seriesList;

  const SeriesLoaded(this.seriesList);

  @override
  List<Object> get props => [seriesList];
}

class SeriesFailed extends SeriesState {
  final String message;

  const SeriesFailed(this.message);

  @override
  List<Object> get props => [message];
}