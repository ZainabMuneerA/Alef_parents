part of 'send_email_bloc.dart';

sealed class SendEmailState extends Equatable {
  const SendEmailState();
  
  @override
  List<Object> get props => [];
}

final class SendEmailInitial extends SendEmailState {}
