import 'package:assignment1/presentation/cubit/episodescubit/episodes_cubit.dart';
import 'package:assignment1/presentation/cubit/seriescubit/series_cubit.dart';
import 'package:assignment1/presentation/screens/episode_page.dart';
import 'package:assignment1/presentation/widget/loading_widget.dart';
import 'package:assignment1/presentation/widget/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment1/injection_container.dart' as di;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SeriesCubit>(context).getSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Series"),
      ),
      body: BlocBuilder<SeriesCubit, SeriesState>(
        builder: (context, state) {
          if (state is SeriesLoading) {
            return LoadingWidget();
          } else if (state is SeriesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildListWidget(context, state.seriesList),
            );
          } else if (state is SeriesFailed) {
            return MessageDisplay(
              message: state.message,
            );
          }
          return const MessageDisplay(
            message: 'Hi.....',
          );
        },
      ),
    );
  }

  Widget _buildListWidget(BuildContext context, List<String> seriesList) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: seriesList.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap:()=> Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) =>
                        BlocProvider(
                          create: (context) =>di.sl<EpisodesCubit>()..getEpisodes(seriesList[index]),
                          child: const EpisodePage(),
                        ))),
            child: Container(
              alignment: Alignment.center,
              child: Text(seriesList[index]),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            ),
          );
        });
  }
}
