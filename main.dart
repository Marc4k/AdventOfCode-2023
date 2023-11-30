// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'solutions/index.dart';
import 'utils/generic_day.dart';

final days = <GenericDay>[
  //Day01(),
];

void main(List<String?> args) {
  var onlyShowLast = true;

  if (args.length == 1 && args[0].isAllArgument()) {
    onlyShowLast = false;
  }

  onlyShowLast
      ? days.last.printSolutions()
      : days.forEach((day) => day.printSolutions());
}

extension ArgsMatcher on String? {
  bool isAllArgument() {
    return this == '-a' || this == '--all';
  }
}
