import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/generated/intl/messages_ar.dart';

String mapFailureToMessage(Failure failure) {
  // Map different Failure types to corresponding error messages
  if (failure is ServerFailure) {
    return failure.message ?? 'Server Failuare';
  }
   else if (failure is OfflineFailure) {
    return 'Offline failure';
  } else {
    return 'Unexpected error occurred';
  }
}
