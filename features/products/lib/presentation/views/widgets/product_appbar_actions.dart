import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart';

class ProductAppBarActions extends StatelessWidget {
  const ProductAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          minSize: 0,
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Icon(
            UIcons.boldRounded.heart,
            size: 22,
            color: context.fabTheme.primaryColor,
          ),
        ),
        PaddingGap.md(),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return FabButton(
              onPressed: () {
                $.dialog.showCupertinoModal(
                  builder: (_) {
                    return const CartModal();
                  },
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    UIcons.boldRounded.shopping_bag,
                    size: 20,
                    color: context.fabTheme.primaryColor,
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: AnimatedOpacity(
                      opacity: state.cartItems.isNotEmpty ? 1 : 0,
                      duration: $.timings.mil200,
                      child: FabCard(
                        minWidth: 14,
                        height: 14,
                        radius: 7,
                        color: context.fabTheme.errorColor,
                        padding: EdgeInsets.only(left: $.paddings.xxs, right: $.paddings.xxs, top: 1),
                        isContentCentered: true,
                        child: Text(
                          (state.cartItems.isNotEmpty ? state.cartItems.length : 1).toString(),
                          style: context.fabTheme.caption2Style.bold.copyWith(
                            color: context.fabTheme.onPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        PaddingGap.xs(),
      ],
    );
  }
}
