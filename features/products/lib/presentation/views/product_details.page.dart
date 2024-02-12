// ignore_for_file: max_lines_for_function, max_lines_for_file
import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    required this.product,
    this.selectedItemIndex = 0,
    this.onSelectedItemChanged,
    super.key,
  });

  final ProductModel product;
  final int selectedItemIndex;
  final ValueChanged<int>? onSelectedItemChanged;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late String _selectedImage = widget.product.images.elementAt(widget.selectedItemIndex);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        $.dialog.showCupertinoDialog(
          builder: (_) => CupertinoAlertDialog(
            content: const Text('Back navigation disabled!'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: $.navigator.pop,
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  $.navigator.pop();
                  AutoRouter.of(context).popUntilRoot();
                },
                child: const Text('Force back'),
              ),
            ],
          ),
        );
      },
      child: FabScaffold(
        appBar: FabAppBarSettings(
          title: const Text(
            'details.',
          ),
          actions: [
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Icon(
                UIcons.boldRounded.plus,
                size: 20,
                color: context.fabTheme.primaryColor,
              ),
            ),
          ],
          largeTitle: FabAppBarLargeTitleSettings(
            largeTitle: 'details.',
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: $.paddings.md,
            vertical: $.paddings.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Hero(
                        tag: _selectedImage + widget.product.id.toString(),
                        transitionOnUserGestures: true,
                        child: AnimatedSwitcher(
                          duration: $.timings.mil200,
                          transitionBuilder: (child, animation) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          child: FabImage(
                            key: ValueKey<String>(_selectedImage),
                            uri: _selectedImage,
                            width: context.width,
                          ),
                        ),
                      ),
                    ),
                    PaddingGap.md(),
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        runSpacing: $.paddings.md,
                        children: widget.product.images.map((image) {
                          return FabButton(
                            onPressed: _selectedImage != image
                                ? () {
                                    widget.onSelectedItemChanged?.call(widget.product.images.indexOf(image));
                                    setState(() {
                                      _selectedImage = image;
                                    });
                                  }
                                : null,
                            child: FabImage(
                              uri: image,
                              height: (300 - ((widget.product.images.length - 1) * $.paddings.md)) /
                                  (widget.product.images.length),
                              border: Border.fromBorderSide(
                                BorderSide(
                                  color: _selectedImage == image
                                      ? CupertinoTheme.of(context).primaryColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              PaddingGap.md(),
              //TODO:
              FabCard(
                padding: $.paddings.sm.all,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: context.textTheme.titleLarge,
                    ),
                    PaddingGap.sm(),
                    Text(
                      widget.product.description,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.textTheme.bodyMedium?.color?.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
