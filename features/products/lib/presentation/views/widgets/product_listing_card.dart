import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/models/product.model.dart';

class ProductListingCard extends StatefulWidget {
  const ProductListingCard({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  State<ProductListingCard> createState() => _ProductListingCardState();
}

class _ProductListingCardState extends State<ProductListingCard> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: FabCard(
        pressedOpacity: 1,
        radius: 0,
        onPressed: () => $.navigator.push(
          ProductDetailsRoute(
            product: widget.product,
            selectedItemIndex: _pageController.page!.round(),
            onSelectedItemChanged: (index) {
              _pageController.jumpToPage(index);
            },
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: ImageSlider(
                images: widget.product.images,
                pageController: _pageController,
              ),
            ),
            Expanded(
              flex: 3,
              child: PaddingAll.xs(
                child: Column(
                  children: [
                    Text(widget.product.title, style: context.appTheme.footnoteStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
