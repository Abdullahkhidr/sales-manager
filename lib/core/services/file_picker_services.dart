import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:manager/core/errors/failures.dart';

class FilePickerServices {
  static Future<Either<Failure, Uint8List>> pickImage() async {
    try {
      PlatformFile file =
          (await FilePicker.platform.pickFiles(type: FileType.image))!
              .files
              .first;
      return Right(await File(file.path!).readAsBytes());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
