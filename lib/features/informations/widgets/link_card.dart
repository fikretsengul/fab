import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({
    super.key,
    required this.title,
    required this.icon,
    required this.url,
  });

  final String title;
  final IconData icon;
  final Uri url;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: getPrimaryColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: ListTile(
        onTap: _launchUrl,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        trailing: Icon(
          Ionicons.open_outline,
          color: getTextTheme(context).titleMedium!.color,
        ),
        title: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Text(
              tr(title),
              style: getTextTheme(context).titleMedium!.apply(fontWeightDelta: 2),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _launchUrl() async =>
      await canLaunchUrl(url) ? await launchUrl(url) : throw Exception('Could not launch $url');
}
