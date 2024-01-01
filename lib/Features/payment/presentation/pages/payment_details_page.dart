import 'package:alef_parents/Features/User_Profile/presentation/widgets/EnrollmentStatus.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';
import 'package:alef_parents/Features/outstanding/presentation/bloc/bloc/outstanding_bloc.dart';
import 'package:alef_parents/Features/payment/presentation/widgets/payment_details_widget.dart';
import 'package:alef_parents/core/widget/app_bar.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsPage extends StatelessWidget {
  final int studentId;

  PaymentDetailsPage({
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<OutstandingBloc>()
            ..add(GetOutstandingEvent(studentId: studentId)),
        ),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Payment History',
            showBackButton: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Center(
            child: BlocBuilder<OutstandingBloc, OutstandingState>(
              builder: (context, state) {
                if (state is LoadingOutstandingState) {
                  return const LoadingWidget(); // You can replace this with a loading indicator
                } else if (state is LoadedOutstandingState) {
                  return PaymentListing(
                    outstanding: state.outstanding,
                  );
                } else if (state is ErrorOutstandingState) {
                  return Text(state.message); // Display an error message
                } else {
                  return const Center(child: Text("Unexpected state"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentListing extends StatelessWidget {
  final List<Outstanding> outstanding;

  const PaymentListing({super.key, required this.outstanding});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: outstanding.length,
      itemBuilder: (context, index) {
        final status = outstanding[index];

        return Padding(
          padding: const EdgeInsets.only(
            // bottom: 16,
            top: 20,
          ),
          child: GestureDetector(
            onTap: () {},
            child: PaymentDetailsList(
              feeName: status.type,
              date: status.dueDate,
              status: status.status,
              amount: status.fees.toString(),
              paymentId: status.id,
            ),
          ),
        );
      },
    );
  }
}
