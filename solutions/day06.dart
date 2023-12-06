import '../utils/index.dart';

class Day06 extends GenericDay {
  Day06() : super(6);

  @override
  List<Race> parseInput() {
    return [
      Race(time: 41777096, distance: 249136211271011),
      //  Race(time: 77, distance: 1362),
      //   Race(time: 70, distance: 1127),
      //  Race(time: 96, distance: 1011),
    ];
  }

  @override
  int solvePart1() {
    final recordsList = <int>[];

    for (final raceInput in parseInput()) {
      var records = 0;

      for (var holdTime = 0; holdTime < raceInput.time + 1; holdTime++) {
        final timeAfterHold = raceInput.time - holdTime;

        final distance = holdTime * timeAfterHold;
        if (distance > raceInput.distance) {
          records++;
        }
      }
      recordsList.add(records);
    }

    return recordsList.reduce((a, b) => a * b);
  }

  @override
  int solvePart2() {
    return 0;
  }
}

class Race {
  Race({required this.time, required this.distance});

  final int time;
  final int distance;
}
