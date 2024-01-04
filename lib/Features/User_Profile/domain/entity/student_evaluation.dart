

import 'package:equatable/equatable.dart';

class StudentEvaluation extends Equatable {
  final int id;

  final List<int> pdfBytes;

  const StudentEvaluation({
    required this.id,
   
    required this.pdfBytes,
  });

  @override
  List<Object?> get props => [id,pdfBytes];
}