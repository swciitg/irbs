import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

Future<void> showSuccessDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: OColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: OColor.green100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FluentIcons.checkmark_circle_24_filled,
                  color: OColor.green600,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Your request has been sent.',
                style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Approval might take 2-3 days to reflect on your OneStop App.',
                style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OColor.green600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: OTextStyle.labelMedium.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Keep old function name as alias for backward compatibility
Future<void> showDialogue(BuildContext context) => showSuccessDialog(context);
