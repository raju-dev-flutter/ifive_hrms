part of 'sfa_crud_bloc.dart';

sealed class SfaCrudEvent extends Equatable {
  const SfaCrudEvent();

  @override
  List<Object> get props => [];
}

class GenerateTicketEvent extends SfaCrudEvent {
  final DataMap body;
  final String type;

  const GenerateTicketEvent({required this.body, required this.type});

  @override
  List<Object> get props => [body, type];
}
