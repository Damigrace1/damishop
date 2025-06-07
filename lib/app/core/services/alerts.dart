import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlertService {
  // static void showSuccess(String message) {
  //   BuildContext context = Get.context!;

  //   final snackBar = SnackBar(
  //     behavior: SnackBarBehavior.fixed,
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     duration: const Duration(seconds: 3),
  //     content: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border(left: BorderSide(width: 4, color: AppColors.success)),
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.1),
  //             blurRadius: 20,
  //             offset: const Offset(0, 6),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           SvgPicture.asset(AppIcons.successCheck),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Text(
  //               message,
  //               style: const TextStyle(
  //                 color: Color(0xFF2F3542),
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
  //             child: const Icon(CupertinoIcons.clear,
  //                 size: 20, color: Colors.black54),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  //   ScaffoldMessenger.of(context)
  //     ..hideCurrentSnackBar()
  //     ..showSnackBar(snackBar);
  // }

  static void showSuccess(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 4,
        left: 16,
        right: 16,
        child: _SuccessToast(
          message: message,
          onDismiss: () {
            overlayEntry.remove();
          },
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (overlayEntry.mounted) overlayEntry.remove();
    });
  }
}

class _SuccessToast extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _SuccessToast({
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
              left: BorderSide(width: 4, color: AppColors.success)),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.successCheck),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Color(0xFF2F3542),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onDismiss();
              },
              child: const Icon(CupertinoIcons.clear,
                  size: 20, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
