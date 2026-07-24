import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String adminName = "Akshay";

  @override
  Widget build(BuildContext context) {
    context.read<BookingBloc>().add(GetAllBookingsEvent());
    return Scaffold(
      // backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BookingLoaded) {
              final bookings = state.bookings;

              double totalRevenue = bookings.fold(
                0,
                (sum, item) => sum + item.amount,
              );

              int totalBookings = bookings.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔥 HEADER
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, $adminName 👋",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Here’s your booking overview",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 DASHBOARD CARDS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: "Total Revenue",
                            value: "₹${totalRevenue.toStringAsFixed(0)}",
                            icon: Icons.currency_rupee,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: "Total Bookings",
                            value: "$totalBookings",
                            icon: Icons.book_online,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔥 SECTION TITLE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "All Bookings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔥 BOOKINGS LIST
                  Expanded(
                    child: ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                           child: Padding(
  padding: const EdgeInsets.all(12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// 🔥 TOP ROW
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            booking.serviceName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "₹${booking.amount}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),

      const SizedBox(height: 8),

      /// 👤 USER
      Row(
        children: [
          const Icon(Icons.person, size: 16),
          const SizedBox(width: 6),
          Text(booking.userId),
        ],
      ),

      const SizedBox(height: 4),

      /// ✂ STAFF
      Row(
        children: [
          const Icon(Icons.content_cut, size: 16),
          const SizedBox(width: 6),
          Text(booking.staffName),
        ],
      ),

      const SizedBox(height: 4),

      /// 📅 DATE & TIME
      Row(
        children: [
          const Icon(Icons.calendar_today, size: 16),
          const SizedBox(width: 6),
          Text("${booking.date} • ${booking.time}"),
        ],
      ),

      const SizedBox(height: 8),

      /// 🔥 STATUS BADGE
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: booking.status == "confirmed"
              ? Colors.green.withOpacity(0.2)
              : Colors.orange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          booking.status.toUpperCase(),
          style: TextStyle(
            color: booking.status == "confirmed"
                ? Colors.green
                : Colors.orange,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is BookingFailure) {
              return Center(child: Text(state.error));
            }

            return Center(child: Text("Dashboard is empty"),);
          },
        ),
      ),
    );
  }

  /// 🔥 MODERN CARD
  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
