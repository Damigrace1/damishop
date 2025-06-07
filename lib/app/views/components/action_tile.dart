import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({
    super.key,
    required this.actionText,
  });
  final String actionText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
          color: AppColors.grey200,
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // In real world, this backbutton should not be present for the homepage
                const Icon(Icons.chevron_left, color: AppColors.grey500),
                const SizedBox(
                  width: 18.75,
                ),
                Text(
                  actionText,
                  style: buildTextStyle(weight: FontWeight.w700, size: 18),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: AppColors.greyF5,
          height: 1,
        ),
      ],
    );
  }
}
