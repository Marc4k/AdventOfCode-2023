// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/index.dart';
import 'index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<GameData> parseInput() {
    final exampleInput = input.getPerLine();

    final gameIds =
        exampleInput.removeWhiteSpace().removeGame().map(_getGameID).toList();

    final blueValues = exampleInput
        .removeWhiteSpace()
        .map((e) => _getValue(e, 'blue'))
        .toList();

    final redValues = exampleInput
        .removeWhiteSpace()
        .map((e) => _getValue(e, 'red'))
        .toList();

    final greenValues = exampleInput
        .removeWhiteSpace()
        .map((e) => _getValue(e, 'green'))
        .toList();

    return getGameData(
      gameList: gameIds,
      blueList: blueValues,
      greenList: greenValues,
      redList: redValues,
    );
  }

  @override
  int solvePart1() {
    return parseInput().map((e) => e.calculatePart1()).sum;
  }

  @override
  int solvePart2() {
    return parseInput().map((e) => e.calculatePart2()).sum;
  }
}

extension MyListExtensionDay2 on Iterable<String> {
  Iterable<String> removeWhiteSpace() => map((e) => e.replaceAll(' ', ''));
  Iterable<String> removeGame() => map((e) => e.replaceAll('Game', ''));
}

String _getGameID(String s) {
  return switch (s.indexOf(':')) {
    2 => s[0] + s[1],
    3 => s[0] + s[1] + s[2],
    _ => s[0],
  };
}

String _getValue(String s, String value) {
  var indexString = '';
  final splitInput = s.split(';');

  for (var i = 0; i < splitInput.length; i++) {
    final index = splitInput[i].indexOf(value);

    // ignore: use_string_buffers
    indexString += switch (index) {
      -1 => '',
      1 => '${splitInput[i][index - 1]},',
      _ => '${splitInput[i][index - 2]}${splitInput[i][index - 1]},',
    };
  }
  return indexString;
}

List<GameData> getGameData({
  required List<String> gameList,
  required List<String> blueList,
  required List<String> greenList,
  required List<String> redList,
}) {
  final data = <GameData>[];
  for (var i = 0; i < gameList.length; i++) {
    final blueString = blueList[i].split(',').removeCharacters()
      ..removeWhere((element) => element.isEmpty);

    final redString = redList[i].split(',').removeCharacters()
      ..removeWhere((element) => element.isEmpty);
    final greenString = greenList[i].split(',').removeCharacters()
      ..removeWhere((element) => element.isEmpty);

    data.add(
      GameData(
        gameID: int.parse(gameList[i]),
        maxBlue: blueString.map(int.parse).reduce(max),
        maxRed: redString.map(int.parse).reduce(max),
        maxGreen: greenString.map(int.parse).reduce(max),
      ),
    );
  }

  return data;
}

class GameData {
  GameData({
    required this.gameID,
    required this.maxBlue,
    required this.maxRed,
    required this.maxGreen,
  });

  final int gameID;
  final int maxBlue;
  final int maxRed;
  final int maxGreen;

  int calculatePart1() =>
      (maxRed < 13 && maxGreen < 14 && maxBlue < 15) ? gameID : 0;

  int calculatePart2() => maxRed * maxGreen * maxBlue;
}
