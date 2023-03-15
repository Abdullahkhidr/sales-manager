import 'package:hive/hive.dart';

import 'operation.dart';

class TypeOperationAdapter extends TypeAdapter<TypeOperation> {
  @override
  TypeOperation read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeOperation.Sale;
      case 1:
        return TypeOperation.Buy;
      case 2:
        return TypeOperation.Refund;
      default:
        return TypeOperation.Sale;
    }
  }

  @override
  void write(BinaryWriter writer, TypeOperation obj) {
    switch (obj) {
      case TypeOperation.Sale:
        writer.writeByte(0);
        break;
      case TypeOperation.Buy:
        writer.writeByte(1);
        break;
      case TypeOperation.Refund:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get typeId => 10;
}
