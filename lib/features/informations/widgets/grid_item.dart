import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:url_launcher/url_launcher.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    required this.title,
    required this.icon,
    required this.url,
    super.key,
    this.category = '',
  });

  final String category;
  final IconData icon;
  final String title;
  final Uri url;

  Future<bool> _launchUrl() async => await canLaunchUrl(url)
      ? await launchUrl(url)
      : throw Exception('Could not launch $url');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: _launchUrl,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon),
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: getTextTheme(context)
                  .titleSmall!
                  .apply(fontWeightDelta: 2, fontSizeDelta: -2),
            ),
            if (category.isNotEmpty) ...{
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  category,
                  style:
                      getTextTheme(context).bodySmall!.apply(fontSizeDelta: -1),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
