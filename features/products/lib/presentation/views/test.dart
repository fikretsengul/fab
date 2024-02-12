import 'package:deps/packages/nested_scroll_view_plus/others/custom_scroll_provider.dart';
import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  const Test({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final scrollProvider = CustomScrollProviderData.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      key: PageStorageKey<int>(index),
      controller: scrollProvider.scrollControllers[index],
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final number = index + 1;

              return Container(
                height: 50,
                color: index.isEven ? CupertinoColors.lightBackgroundGray : CupertinoColors.extraLightBackgroundGray,
                alignment: Alignment.center,
                child: Text(
                  '$number',
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
