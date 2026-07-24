import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/core/colors.dart';
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';
import '../bloc/service_bloc.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceBloc>().add(LoadServices());

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Services",style: TextStyle(color: ConstantColors.secondary),),centerTitle: true,iconTheme: IconThemeData(color: ConstantColors.secondary),backgroundColor: ConstantColors.primary,),

      /// ✅ FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstantColors.primary,
        onPressed: () => _showAddServiceSheet(context),
        child: const Icon(Icons.add,color: ConstantColors.secondary,),
      ),

      /// ✅ LIST
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServiceLoaded) {
            return ListView.builder(
  padding: const EdgeInsets.all(12),
  itemCount: state.services.length,
  itemBuilder: (context, index) {
    final service = state.services[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔹 ICON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.cut, color: Colors.blue),
          ),

          const SizedBox(width: 12),

          /// 🔹 SERVICE DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "₹${service.price}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 DELETE BUTTON
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<ServiceBloc>().add(
                    DeleteServiceEvent(service.id),
                  );
            },
          ),
        ],
      ),
    );
  },
);
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// 🔥 BOTTOM SHEET FUNCTION
  void _showAddServiceSheet(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 🔥 important for keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      height: 5,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    const SizedBox(height: 15),

    const Text(
      "Add Service",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),

    const SizedBox(height: 20),

    TextField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: "Service Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    const SizedBox(height: 15),

    TextField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    const SizedBox(height: 20),

    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: ConstantColors.secondary,
          backgroundColor: ConstantColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          final service = ServiceEntity(
            id: '',
            name: nameController.text,
            price: double.parse(priceController.text),
            duration: 30,
            isActive: true,
          );

          context.read<ServiceBloc>().add(
                AddServiceEvent(service),
              );

          Navigator.pop(context);
        },
        child:  Text("Save",),
      ),
    ),
  ],
),
        );
      },
    );
  }
}