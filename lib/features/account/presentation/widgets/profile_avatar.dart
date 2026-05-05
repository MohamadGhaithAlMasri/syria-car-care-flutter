import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account_bloc.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final bool showBorder;
  final Widget? child;

  const ProfileAvatar({
    super.key,
    this.radius = 18,
    this.showBorder = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        String? avatarUrl;
        if (state is AccountLoaded) {
          avatarUrl = state.accountInfo.avatarUrl;
        }

        final hasImage = avatarUrl != null && avatarUrl.isNotEmpty;

        return Container(
          decoration: showBorder ? BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.cyan, width: 1.5),
          ) : null,
          padding: showBorder ? const EdgeInsets.all(2) : null,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: hasImage
                ? NetworkImage(avatarUrl)
                : null,
            child: child ?? (!hasImage
                ? Icon(Icons.person, size: radius * 1.2, color: Colors.grey)
                : null),
          ),
        );
      },
    );
  }
}
