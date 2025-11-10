import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_page.dart';

void showTransferPointsBottomSheet(BuildContext context, String userPoints) {
  final emailController = TextEditingController();
  final pointsController = TextEditingController();
  final passwordController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return BlocConsumer<PointsBloc, PointsState>(
        listener: (context, state) {
          if (state.status == PointsStatus.success) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Points transferred successfully')),
            );
          }
          if (state.status == PointsStatus.failure) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Something went wrong. Please try again later')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status.isLoading;

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                const Text(
                  "Transfer Points",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You have a total of $userPoints Points",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                // Email field
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Recipient's Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Points field
                TextField(
                  controller: pointsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Points to Transfer",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Password field
                // TextField(
                //   controller: passwordController,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     labelText: "Your Password",
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Confirm button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<PointsBloc>().add(
                                  PointsEvent.transferPoints(request: {
                                    'email': emailController.text.trim(),
                                    'points': pointsController.text.trim(),
                                  }),
                                );
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Confirm Transfer'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}
