import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';
import '../../models/room_model.dart';
import '../../functions/launch_phone.dart';

void showContactProfileSheet(
  BuildContext context, {
  required OwnerInfo details,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _ProfileSheetContent(details: details);
    },
  );
}

class _ProfileSheetContent extends StatelessWidget {
  final OwnerInfo details;

  const _ProfileSheetContent({required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        border: Border.all(color: OColor.gray200),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: icon + "Contact" + close button
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: OColor.green100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FluentIcons.person_24_regular,
                  size: 20,
                  color: OColor.green600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Contact',
                  style: OTextStyle.labelLarge.copyWith(color: OColor.gray800),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: OColor.gray100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FluentIcons.dismiss_24_regular,
                    size: 18,
                    color: OColor.gray600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Profile: avatar + name
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: OColor.gray100,
                child: Icon(
                  FluentIcons.person_24_regular,
                  color: OColor.green600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.name ?? 'Unknown',
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.gray800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Contact info rows
          if (details.phoneNumber != null) ...[
            Row(
              children: [
                Icon(
                  FluentIcons.call_24_regular,
                  size: 16,
                  color: OColor.gray500,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    details.phoneNumber.toString(),
                    style: OTextStyle.labelSmall.copyWith(
                      color: OColor.gray600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          if (details.email != null && details.email!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  FluentIcons.mail_24_regular,
                  size: 16,
                  color: OColor.gray500,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    details.email!,
                    style: OTextStyle.labelSmall.copyWith(
                      color: OColor.gray600,
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),

          // Action buttons: Call / Text / Mail
          Row(
            children: [
              if (details.phoneNumber != null) ...[
                Expanded(
                  child: ContactActionButton(
                    icon: FluentIcons.call_24_regular,
                    label: 'Call',
                    onTap: () => makePhoneCall(details.phoneNumber.toString()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ContactActionButton(
                    icon: FluentIcons.chat_24_regular,
                    label: 'Text',
                    onTap: () => sendSMS(details.phoneNumber.toString()),
                  ),
                ),
              ],
              if (details.email != null && details.email!.isNotEmpty) ...[
                if (details.phoneNumber != null) const SizedBox(width: 8),
                Expanded(
                  child: ContactActionButton(
                    icon: FluentIcons.mail_24_regular,
                    label: 'Mail',
                    onTap: () => launchEmail(details.email!),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),

          // Add to Favourite button - placeholder
          Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: OColor.gray300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FluentIcons.star_12_regular,
                  size: 16,
                  color: OColor.green600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Add to Favourite',
                  style: OTextStyle.labelSmall.copyWith(color: OColor.green600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ContactActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: OColor.gray300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: OColor.green600),
            const SizedBox(width: 8),
            Text(
              label,
              style: OTextStyle.labelSmall.copyWith(color: OColor.green600),
            ),
          ],
        ),
      ),
    );
  }
}
