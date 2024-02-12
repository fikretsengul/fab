import 'package:deps/design/design.dart';
import 'package:deps/packages/smooth_sheets.dart';
import 'package:flutter/material.dart';

class CartModal extends StatelessWidget {
  const CartModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const DraggableSheet(
      child: FabModal(
        title: 'cart.',
        child: SizedBox(),
      ),
    );
  }
}
