import 'package:assignment1/domain/entity/characters_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_widget.dart';
import 'message_display.dart';

class GridAvatar extends StatelessWidget {
  final CharactersEntity charactersEntity;

  const GridAvatar({required this.charactersEntity, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CircleAvatar(
            backgroundImage: NetworkImage(charactersEntity.img.toString()),
            radius: 50,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(charactersEntity.name.toString()),
      ],
    );

  }
}
