import 'dart:math';
import 'package:collection/collection.dart';
import '../utils/index.dart';

class Day04 extends GenericDay {
  Day04() : super(4);

  @override
  Iterable<({Iterable<int> number, Iterable<int> winNumber})> parseInput() {
    return input
        .getPerLine()
        .removeCardTag()
        .map((e) => e.split('|'))
        .map(_getNumbers);
  }

  @override
  int solvePart1() {
    return parseInput().map(_getWinningPoints).sum;
  }

  @override
  int solvePart2() {
    final data2 = parseInput().toList();

    for (var i = 0; i < data2.length; i++) {
      var wins = 0;
      for (final element in data2[i].winNumber) {
        if (data2[i].number.contains(element)) {
          wins++;
        }
      }
      try {
        data2.insertAll(i + 1, data2.toList().getRange(i + 1, i + wins));
      } catch (e) {}
    }
    print(data2.length);
    return 0;
  }
}

extension on Iterable<String> {
  Iterable<String> removeCardTag() =>
      map((e) => e.split(':')).map((e) => e.removeAt(1));
}

({Iterable<int> winNumber, Iterable<int> number}) _getNumbers(
  List<String> data,
) {
  final winNumber = data.first
      .split(' ')
      .whereNot((element) => element.isEmpty)
      .map(int.parse);

  final number = data.last
      .split(' ')
      .whereNot((element) => element.isEmpty)
      .map(int.parse);

  return (
    winNumber: winNumber,
    number: number,
  );
}

int _getWinningPoints(
  ({Iterable<int> winNumber, Iterable<int> number}) numbers,
) {
  var rightNumbers = 0;

  for (final element in numbers.winNumber) {
    if (numbers.number.contains(element)) {
      rightNumbers++;
    }
  }
  return switch (rightNumbers) {
    0 => 0,
    _ => pow(2, rightNumbers - 1).toInt(),
  };
}
