// ignore_for_file: public_member_api_docs, sort_constructors_first, use_string_buffers
import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    var sum = 0;
    for (var i = 0; i < parseInput().length; i++) {
      final onlyNumber = parseInput()[i].replaceAll(RegExp(r'\D'), '');

      final number = onlyNumber[0] + onlyNumber[onlyNumber.length - 1];

      sum += int.parse(number);
    }

    return sum;
  }

  List<DigitNumberModel> digits = [
    DigitNumberModel(digit: 'one', number: '1'),
    DigitNumberModel(digit: 'two', number: '2'),
    DigitNumberModel(digit: 'three', number: '3'),
    DigitNumberModel(digit: 'four', number: '4'),
    DigitNumberModel(digit: 'five', number: '5'),
    DigitNumberModel(digit: 'six', number: '6'),
    DigitNumberModel(digit: 'seven', number: '7'),
    DigitNumberModel(digit: 'eight', number: '8'),
    DigitNumberModel(digit: 'nine', number: '9'),
  ];

  @override
  int solvePart2() {
    var sum = 0;

    for (final inputNormal in parseInput()) {
      final data = <IndexString>[];

      for (var g = 0; g < digits.length; g++) {
        for (var b = 0; b < inputNormal.length; b++) {
          final indexDigig = inputNormal.indexOf(digits[g].digit, b);

          final indexNumber = inputNormal.indexOf(digits[g].number, b);

          if (indexDigig != -1) {
            data.add(
              IndexString(
                index: indexDigig,
                number: int.parse(digits[g].number),
              ),
            );
          }
          if (indexNumber != -1) {
            data.add(
              IndexString(
                index: indexNumber,
                number: int.parse(digits[g].number),
              ),
            );
          }
        }
      }

      data.sort((a, b) => a.index.compareTo(b.index));
      var numberRight = '';
      for (var c = 0; c < data.length; c++) {
        numberRight += data[c].number.toString();
      }

      final sumNumber = numberRight[0] + numberRight[numberRight.length - 1];
      sum += int.parse(sumNumber);
    }

    return sum;
  }
}

class DigitNumberModel {
  String digit;
  String number;
  DigitNumberModel({
    required this.digit,
    required this.number,
  });
}

class IndexString {
  int index;
  int number;
  IndexString({
    required this.index,
    required this.number,
  });
}
