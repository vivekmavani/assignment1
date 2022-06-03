import 'package:assignment1/domain/entity/episodes_entity.dart';
import 'package:assignment1/presentation/cubit/episodescubit/episodes_cubit.dart';
import 'package:assignment1/presentation/widget/grid_avatar.dart';
import 'package:assignment1/presentation/widget/loading_widget.dart';
import 'package:assignment1/presentation/widget/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EpisodeDetailPage extends StatelessWidget {
  final EpisodesEntity episodesEntity;

  const EpisodeDetailPage(this.episodesEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episodesEntity.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 30,
                    child: Center(
                      child: Text(
                        "Episode : " + episodesEntity.episode.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.movie)),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "AirDate : " + episodesEntity.airDate.toString(),
                          style: TextStyle(
                            package: 'awesome_card',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'MavenPro',
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "series : " + episodesEntity.series.toString(),
                              style: TextStyle(
                                  package: 'awesome_card',
                                  color: Colors.black,
                                  fontFamily: 'MavenPro',
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "season : " + episodesEntity.season.toString(),
                              style: TextStyle(
                                  package: 'awesome_card',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'MavenPro',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 7, // 60% of space => (6/(6 + 4))
                              child: Text(
                                "EpisodeId : " +
                                    episodesEntity.episodeId.toString(),
                                style: TextStyle(
                                  package: 'awesome_card',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'MavenPro',
                                  fontSize: 17,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Characters",
                          style: TextStyle(
                            package: 'awesome_card',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'MavenPro',
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<EpisodesCubit, EpisodesState>(
                          builder: (context, state) {
                            if (state is EpisodesLoading) {
                              return const LoadingWidget();
                            } else if (state is EpisodesLoaded) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                    itemCount: state.episodesList.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return GridAvatar(
                                          charactersEntity: state.episodesList[index]);
                                    }),
                              );
                            } else if (state is EpisodesFailed) {
                              return MessageDisplay(
                                message: state.message,
                              );
                            }
                            return const MessageDisplay(
                              message: 'Hi.....',
                            );
                          },
                        ),

                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
