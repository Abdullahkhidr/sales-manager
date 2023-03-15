import 'package:flutter/cupertino.dart';

class Space extends StatelessWidget {
  final int count;
  final bool isH;
  const Space({super.key, this.count = 1, this.isH = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: isH ? 0 : count * 4, height: !isH ? 0 : count * 4);
  }
}
