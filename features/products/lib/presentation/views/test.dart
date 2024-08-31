import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  const Test({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      key: const PageStorageKey<String>('asd'),
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
