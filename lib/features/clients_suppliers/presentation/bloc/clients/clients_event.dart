part of 'clients_bloc.dart';

@immutable
abstract class ClientsEvent {}

class ClientsGetAllEvent extends ClientsEvent {}

class ClientsSearchEvent extends ClientsEvent {
  final String textSearch;

  ClientsSearchEvent(this.textSearch);
}

class EditorSetClientDataEvent extends ClientsEvent {
  final Client client;
  EditorSetClientDataEvent(this.client);
}

class ClientsGetOperationsOfClient extends ClientsEvent {
  final Client client;

  ClientsGetOperationsOfClient(this.client);
}

class EditorAddClientEvent extends ClientsEvent {}

class EditorDeleteClientEvent extends ClientsEvent {}

class EditorEditClientEvent extends ClientsEvent {}

class ClientsMakeCallEvent extends ClientsEvent {
  final Client client;
  ClientsMakeCallEvent(this.client);
}
