import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/informations/widgets/grid_item.dart';
import 'package:flutter_advanced_boilerplate/features/informations/widgets/link_card.dart';
import 'package:flutter_advanced_boilerplate/features/informations/widgets/text_divider.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InformationsScreen extends StatelessWidget {
  const InformationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          LinkCard(
            title: context.t.informations.github_repository_title,
            icon: MdiIcons.github,
            url: Uri.parse(
              'https://github.com/fikretsengul/flutter_advanced_boilerplate',
            ),
          ),
          TextDivider(text: context.t.informations.author_divider_title),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2 / 1.15,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              GridItem(
                title: context.t.informations.donate_card_title,
                icon: MdiIcons.coffee,
                url: Uri.parse(
                  'https://www.buymeacoffee.com/iamfikretB',
                ),
              ),
              GridItem(
                title: context.t.informations.website_card_title,
                icon: MdiIcons.web,
                url: Uri.parse('https://fikretsengul.com'),
              ),
            ],
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
