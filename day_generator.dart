import 'dart:async';
import 'dart:io';

void main(List<String?> args) async {
  const year = '2023';
  const session =
      '53616c7465645f5f5ba268355c6fe59e69b65bc9df5d4781ea0ef5a5fc715ddd865752e0f46712c99ae31eb5ac73af9a967d6f9714a1d620e028d0f37aa8b1c3';

  if (args.length > 1) {
    print('Please call with: <dayNumber>');
    return;
  }

  String? dayNumber;

  // input through terminal
  if (args.isEmpty) {
    print('Please enter a day for which to generate files');
    final input = stdin.readLineSync();
    if (input == null) {
      print('No input given, exiting');
      return;
    }
    // pad day number to have 2 digits
    dayNumber = int.parse(input).toString().padLeft(2, '0');
    // input from CLI call
  } else {
    dayNumber = int.parse(args[0]!).toString().padLeft(2, '0');
  }

  // inform user
  print('Creating day: $dayNumber');

  // Create lib file
  final dayFileName = 'day$dayNumber.dart';
  unawaited(
    File('solutions/$dayFileName').writeAsString(dayTemplate(dayNumber)),
  );

  final exportFile = File('solutions/index.dart');
  final exports = exportFile.readAsLinesSync();
  final content = "export 'day$dayNumber.dart';\n";
  var found = false;
  // check if line already exists
  for (final line in exports) {
    if (line.contains('day$dayNumber.dart')) {
      found = true;
      break;
    }
  }

  // export new day in index file if not present
  if (!found) {
    await exportFile.writeAsString(
      content,
      mode: FileMode.append,
    );
  }

  // Create input file
  print('Loading input from adventofcode.com...');
  try {
    final request = await HttpClient().getUrl(
      Uri.parse(
        'https://adventofcode.com/$year/day/${int.parse(dayNumber)}/input',
      ),
    );
    request.cookies.add(Cookie('session', session));
    final response = await request.close();
    final dataPath = 'input/aoc$dayNumber.txt';
    // unawaited(File(dataPath).create());
    await response.pipe(File(dataPath).openWrite());
  } catch (e) {
    print('Error loading file: $e');
  }

  print('All set, Good luck!');
}

String dayTemplate(String dayNumber) {
  return '''
import '../utils/index.dart';

class Day$dayNumber extends GenericDay {
  Day$dayNumber() : super(${int.parse(dayNumber)});

  @override
  parseInput() {

  }

  @override
  int solvePart1() {

    return 0;
  }

  @override
  int solvePart2() {

    return 0;
  }
}

''';
}
