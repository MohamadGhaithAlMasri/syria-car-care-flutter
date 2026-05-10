import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account_bloc.dart';
import '../../domain/entities/user_address.dart';
import 'address_picker_page.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addresses'.tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccountLoaded) {
            final addresses = state.addresses;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAddressCard(
                  context,
                  title: 'home_loc'.tr(),
                  icon: Icons.home,
                  type: 'home',
                  address: addresses.firstWhere(
                    (a) => a.type == 'home',
                    orElse: () => const UserAddress(
                      id: '',
                      userId: '',
                      type: 'home',
                      latitude: 0,
                      longitude: 0,
                      addressName: '',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                _buildAddressCard(
                  context,
                  title: 'work_loc'.tr(),
                  icon: Icons.work,
                  type: 'work',
                  address: addresses.firstWhere(
                    (a) => a.type == 'work',
                    orElse: () => const UserAddress(
                      id: '',
                      userId: '',
                      type: 'work',
                      latitude: 0,
                      longitude: 0,
                      addressName: '',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                _buildAddressCard(
                  context,
                  title: 'parents_loc'.tr(),
                  icon: Icons.people,
                  type: 'parents',
                  address: addresses.firstWhere(
                    (a) => a.type == 'parents',
                    orElse: () => const UserAddress(
                      id: '',
                      userId: '',
                      type: 'parents',
                      latitude: 0,
                      longitude: 0,
                      addressName: '',
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildAddressCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String type,
    required UserAddress address,
  }) {
    final bool isSet = address.addressName.isNotEmpty;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddressPickerScreen(
              type: type,
              initialAddress: isSet ? address : null,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSet ? Colors.cyan.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isSet ? Colors.cyan : Colors.grey).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSet ? Colors.cyan : Colors.grey,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isSet ? address.addressName : 'not_set'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSet ? Colors.grey : Colors.grey.shade400,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
