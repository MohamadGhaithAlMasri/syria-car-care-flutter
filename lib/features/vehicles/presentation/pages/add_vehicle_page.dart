import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/vehicles_bloc.dart';
import '../../domain/entities/vehicle.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _plateController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<VehiclesBloc, VehiclesState>(
      listener: (context, state) {
        if (state is VehiclesLoaded) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('add_car_success'.tr())));
          Navigator.pop(context);
        } else if (state is VehiclesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('add_new_car'.tr()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.directions_car,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Theme.of(context).cardColor,
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'upload_car_image'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const Text(
                        'تصل إلى 5 ميغابايت JPG, PNG',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _buildInputField(
                controller: _brandController,
                label: 'brand'.tr(),
                hint: 'brand_hint'.tr(),
                icon: Icons.business,
              ),
              _buildInputField(
                controller: _modelController,
                label: 'model'.tr(),
                hint: 'model_hint'.tr(),
                icon: Icons.model_training,
              ),
              _buildInputField(
                controller: _yearController,
                label: 'year'.tr(),
                hint: 'year_hint'.tr(),
                icon: Icons.calendar_today,
              ),
              _buildInputField(
                controller: _colorController,
                label: 'color'.tr(),
                hint: 'color_hint'.tr(),
                icon: Icons.palette,
              ),
              _buildInputField(
                controller: _plateController,
                label: 'plate_number'.tr(),
                hint: '123456 - DAMASCUS',
                icon: Icons.pin,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'data_accuracy'.tr(),
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'data_accuracy_desc'.tr(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.info_outline, color: Colors.cyanAccent),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<VehiclesBloc, VehiclesState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: state is VehiclesLoading
                          ? null
                          : () {
                              final vehicle = Vehicle(
                                id: '',
                                brand: _brandController.text,
                                model: _modelController.text,
                                year: _yearController.text,
                                color: _colorController.text,
                                plateNumber: _plateController.text,
                              );
                              context.read<VehiclesBloc>().add(
                                AddVehicleEvent(vehicle),
                              );
                            },
                      child: state is VehiclesLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'add_car'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
