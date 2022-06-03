import 'package:equatable/equatable.dart';

class EpisodesEntity extends Equatable{
  int? episodeId;
  String? title;
  String? season;
  String? airDate;
  List<String>? characters;
  String? episode;
  String? series;

  EpisodesEntity(
      {this.episodeId,
        this.title,
        this.season,
        this.airDate,
        this.characters,
        this.episode,
        this.series});

  @override
  // TODO: implement props
  List<Object?> get props => [episodeId,title,season,airDate,characters,episode,series];
}