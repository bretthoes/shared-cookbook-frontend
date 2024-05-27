import 'package:boilerplate/domain/entity/direction/direction.dart';

class DirectionList {
  final List<Direction> directions;

  DirectionList({
    required this.directions,
  });

  factory DirectionList.fromJson(List<dynamic> json) {
    var directions =
        json.map((direction) => Direction.fromMap(direction)).toList();

    return DirectionList(
      directions: directions,
    );
  }
}
