import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/features/vehicles/domain/entities/vehicle.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/add_vehicle_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/edit_vehicle_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/bloc/vehicles_bloc.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VehiclesBloc>().add(LoadVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<VehiclesBloc, VehiclesState>(
      listener: (context, state) {
        if (state is VehiclesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('app_name'.tr()),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PREMIUM CONCIERGE',
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'my_garage'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32),
              ),
              const SizedBox(
                height: 5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Divider(
                    color: Colors.cyan,
                    thickness: 3,
                    endIndent: 0,
                    indent: 250,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<VehiclesBloc, VehiclesState>(
                  builder: (context, state) {
                    if (state is VehiclesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is VehiclesLoaded) {
                      if (state.vehicles.isEmpty) {
                        return Center(
                          child: Text(
                            'no_cars_yet'.tr(),
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: state.vehicles.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final vehicle = state.vehicles[index];
                          return _buildCarCard(
                            context,
                            vehicle,
                            "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000",
                          );
                        },
                      );
                    } else if (state is VehiclesError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Material(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddVehicleScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_circle, color: Colors.cyanAccent),
                        const SizedBox(width: 10),
                        Text(
                          'add_new_car'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(BuildContext context, Vehicle vehicle, String imageUrl) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditVehicleScreen(vehicle: vehicle),
          ),
        ),
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            vehicle.plateNumber,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${vehicle.brand} ${vehicle.model}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              'color'.tr() + ': ${vehicle.color}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: _actionButton(
                            "delete".tr(),
                            Icons.delete_outline,
                            Theme.of(context).colorScheme.error.withOpacity(0.1),
                            Theme.of(context).colorScheme.error,
                            () => _showDeleteConfirmation(context, vehicle),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _actionButton(
                            "edit".tr(),
                            Icons.edit_outlined,
                            Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            Theme.of(context).colorScheme.primary,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditVehicleScreen(vehicle: vehicle),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('delete_car_confirm_title'.tr()),
        content: Text(
          'delete_car_confirm_msg'.tr(
            args: ["${vehicle.brand} ${vehicle.model}"],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('cancel'.tr(), style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<VehiclesBloc>().add(DeleteVehicleEvent(vehicle.id));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('delete'.tr(), style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label,
    IconData icon,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Icon(icon, size: 18, color: textColor),
            ],
          ),
        ),
      ),
    );
  }
}
