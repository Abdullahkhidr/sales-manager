// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationAdapter extends TypeAdapter<Operation> {
  @override
  final int typeId = 3;

  @override
  Operation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operation(
      id: fields[0] as String?,
      idProduct: fields[1] as String?,
      idClient: fields[2] as String?,
      date: fields[4] as DateTime?,
      quantity: fields[5] as double?,
      typeOperation: fields[6] as TypeOperation?,
      notes: fields[7] as String?,
      amount: fields[8] as double?,
      idSupplier: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Operation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idProduct)
      ..writeByte(2)
      ..write(obj.idClient)
      ..writeByte(3)
      ..write(obj.idSupplier)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.typeOperation)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
