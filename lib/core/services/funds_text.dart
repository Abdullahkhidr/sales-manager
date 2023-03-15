import 'package:manager/core/constants/constants.dart';

String fundsText(double funds) {
  String res = '';
  if (funds < 0) funds *= -1;
  List<String> originalFundsText = funds.toString().split('.');
  for (var i = 0; i < originalFundsText.first.length; i++) {
    res += originalFundsText.first[i];
    if ((i + 1 - originalFundsText.first.length) % 3 == 0 &&
        i != originalFundsText.first.length - 1) {
      res += ',';
    }
  }
  // res += '.${originalFundsText.last}';
  res += ' $currency';
  return res;
}
