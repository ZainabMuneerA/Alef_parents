import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';
import 'package:equatable/equatable.dart';

class Bill extends Equatable {
  final String message;
  final Outstanding outstanding;

  const Bill({required this.message, required this.outstanding});
  
  @override
  List<Object?> get props => [message, outstanding];

}
