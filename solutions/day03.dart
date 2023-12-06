import 'package:collection/collection.dart';

import '../utils/index.dart';

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final data = parseInput().map(_getIndexOfSymbols).toList();

    final allValue = <int>[];

    for (var i = 0; i < data.length; i++) {
      for (final indexList in data[i].indexOfSymbol) {
        final currentLineData = data[i].input;

        if (currentLineData[indexList - 1].contains(RegExp('[0-9]'))) {
          allValue.add(_getNumberLeft(currentLineData, indexList));
        }

        if (currentLineData[indexList + 1].contains(RegExp('[0-9]'))) {
          allValue.add(_getNumberRight(currentLineData, indexList));
        }

        if (i != 0) {
          //Check Top
          if (data[i - 1].input[indexList].contains(RegExp('[0-9]'))) {
            allValue.add(_getNumberTopBottom(data[i - 1].input, indexList));
          } else {
            //Check Top Left
            if (data[i - 1].input[indexList - 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberLeft(
                  data[i - 1].input,
                  indexList,
                ),
              );
            }
            //Check Bottom left
            if (data[i - 1].input[indexList + 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberRight(
                  data[i - 1].input,
                  indexList,
                ),
              );
            }
          }
          //Check bottom
          if (data[i + 1].input[indexList].contains(RegExp('[0-9]'))) {
            allValue.add(_getNumberTopBottom(data[i + 1].input, indexList));
          } else {
            //Check Top Left
            if (data[i + 1].input[indexList - 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberLeft(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
            //Check Bottom left
            if (data[i + 1].input[indexList + 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberRight(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
          }
        } else {
          //Check bottom
          if (data[i + 1].input[indexList].contains(RegExp('[0-9]'))) {
            allValue.add(_getNumberTopBottom(data[i + 1].input, indexList));
          } else {
            //Check Top Left
            if (data[i + 1].input[indexList - 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberLeft(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
            //Check Bottom left
            if (data[i + 1].input[indexList + 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberRight(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
          }
        }
      }
    }
    if (allValue.sum == 540025) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  int solvePart2() {
    final data = parseInput().map(_getGears).toList();

    final sumValue = <int>[];
    for (var i = 0; i < data.length; i++) {
      for (final indexList in data[i].indexOfSymbol) {
        final allValue = <int>[];

        final currentLineData = data[i].input;

        if (currentLineData[indexList - 1].contains(RegExp('[0-9]'))) {
          allValue.add(_getNumberLeft(currentLineData, indexList));
        }

        if (currentLineData[indexList + 1].contains(RegExp('[0-9]'))) {
          allValue.add(_getNumberRight(currentLineData, indexList));
        }

        if (i != 0) {
          //Check Top
          if (data[i - 1].input[indexList].contains(RegExp('[0-9]'))) {
            allValue.add(_getNumberTopBottom(data[i - 1].input, indexList));
          } else {
            //Check Top Left
            if (data[i - 1].input[indexList - 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberLeft(
                  data[i - 1].input,
                  indexList,
                ),
              );
            }
            //Check Bottom left
            if (data[i - 1].input[indexList + 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberRight(
                  data[i - 1].input,
                  indexList,
                ),
              );
            }
          }
          //Check bottom
          if (data[i + 1].input[indexList].contains(RegExp('[0-9]'))) {
            allValue.add(_getNumberTopBottom(data[i + 1].input, indexList));
          } else {
            //Check Top Left
            if (data[i + 1].input[indexList - 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberLeft(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
            //Check Bottom left
            if (data[i + 1].input[indexList + 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberRight(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
          }
        } else {
          //Check bottom
          if (data[i + 1].input[indexList].contains(RegExp('[0-9]'))) {
            allValue.add(_getNumberTopBottom(data[i + 1].input, indexList));
          } else {
            //Check Top Left
            if (data[i + 1].input[indexList - 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberLeft(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
            //Check Bottom left
            if (data[i + 1].input[indexList + 1].contains(RegExp('[0-9]'))) {
              allValue.add(
                _getNumberRight(
                  data[i + 1].input,
                  indexList,
                ),
              );
            }
          }
        }

        if (allValue.length > 1) {
          sumValue.add(allValue.first * allValue.last);
        }
        //    print(data[i].input[indexList + -1].contains(RegExp('[0-9]')));
        //    print(data[i].input[indexList + 1].contains(RegExp('[0-9]')));
      }
    }

    return sumValue.sum;
  }
}

StringIndex _getIndexOfSymbols(String input) {
  final regExp = RegExp(r'[$*?\-@#%&/+=]');

  final indexList = <int>[];

  for (var i = 0; i < input.length; i++) {
    final index = input.indexOf(regExp, i);
    if (index != -1) {
      indexList.add(index);
    }
  }

  return StringIndex(indexOfSymbol: indexList.toSet().toList(), input: input);
}

StringIndex _getGears(String input) {
  final regExp = RegExp('[*]');

  final indexList = <int>[];

  for (var i = 0; i < input.length; i++) {
    final index = input.indexOf(regExp, i);
    if (index != -1) {
      indexList.add(index);
    }
  }

  return StringIndex(indexOfSymbol: indexList.toSet().toList(), input: input);
}

int _getNumberLeft(String input, int index) {
  if (input[index - 3].contains(RegExp('[0-9]'))) {
    return int.parse(input[index - 3] + input[index - 2] + input[index - 1]);
  } else if (input[index - 2].contains(RegExp('[0-9]'))) {
    return int.parse(input[index - 2] + input[index - 1]);
  }

  return int.parse(input[index - 1]);
}

int _getNumberRight(String input, int index) {
  if (input[index + 3].contains(RegExp('[0-9]'))) {
    return int.parse(input[index + 1] + input[index + 2] + input[index + 3]);
  } else if (input[index + 2].contains(RegExp('[0-9]'))) {
    return int.parse(input[index + 1] + input[index + 2]);
  }
  return int.parse(input[index + 1]);
}

int _getNumberTopBottom(String input, int index) {
  var number = input[index];

  if (input[index + 1].contains(RegExp('[0-9]'))) {
    number += input[index + 1];
    if (input[index + 2].contains(RegExp('[0-9]'))) {
      number += input[index + 2];

      if (input[index + 3].contains(RegExp('[0-9]'))) {
        number += input[index + 3];
      }
    }
  }

  if (input[index - 1].contains(RegExp('[0-9]'))) {
    number = input[index - 1] + number;
    if (input[index - 2].contains(RegExp('[0-9]'))) {
      number = input[index - 2] + number;
      if (input[index - 3].contains(RegExp('[0-9]'))) {
        number = input[index - 3] + number;
      }
    }
  }

  return int.parse(number);
}

class StringIndex {
  StringIndex({required this.indexOfSymbol, required this.input});

  final List<int> indexOfSymbol;
  final String input;
}
