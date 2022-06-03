part of 'episodes_cubit.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();
}

class EpisodesInitial extends EpisodesState {
  @override
  List<Object> get props => [];
}

class EpisodesLoading extends EpisodesState {
  @override
  List<Object> get props => [];
}

class EpisodesLoaded extends EpisodesState {
  final List<dynamic> episodesList;

  const EpisodesLoaded(this.episodesList);

  @override
  List<Object> get props => [episodesList];
}

class EpisodesFailed extends EpisodesState {
  final String message;

  const EpisodesFailed(this.message);

  @override
  List<Object> get props => [message];
}