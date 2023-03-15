part of 'clients_bloc.dart';

@immutable
abstract class ClientsState {}

class ClientsInitial extends ClientsState {}

class ClientsLoadedState extends ClientsState {}

class ClientsResultSearchState extends ClientsState {}

class EditorSetClientDataState extends ClientsState {}

class EditorAddedClientState extends ClientsState {}

class EditorDeletedClientState extends ClientsState {}

class EditorEditedClientState extends ClientsState {}
