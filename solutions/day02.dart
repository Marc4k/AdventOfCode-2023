// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/index.dart';
import 'index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<GameData> parseInput() {
    final line = input.getPerLine();

    return getGameData(
      game: line.removeWhiteSpace().removeGame().map(_getGameID).toList(),
      blue: line.removeWhiteSpace().getGameValue('blue').toList(),
      green: line.removeWhiteSpace().getGameValue('green').toList(),
      red: line.removeWhiteSpace().getGameValue('red').toList(),
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

extension on Iterable<String> {
  Iterable<String> removeWhiteSpace() => map((e) => e.replaceAll(' ', ''));
  Iterable<String> removeGame() => map((e) => e.replaceAll('Game', ''));
  Iterable<String> getGameValue(String value) =>
      map((e) => _getValue(e, value));
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
  required List<String> game,
  required List<String> blue,
  required List<String> green,
  required List<String> red,
}) {
  final data = <GameData>[];

  for (var i = 0; i < game.length; i++) {
    final blueString = blue[i].split(',').removeCharacters()
      ..removeWhere((element) => element.isEmpty);

    final redString = red[i].split(',').removeCharacters()
      ..removeWhere((element) => element.isEmpty);
    final greenString = green[i].split(',').removeCharacters()
      ..removeWhere((element) => element.isEmpty);

    data.add(
      GameData(
        gameID: int.parse(game[i]),
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
