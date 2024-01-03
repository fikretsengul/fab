// ignore_for_file: max_lines_for_function, max_lines_for_file

import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:feature_user/presentation/cubits/user.cubit.dart';
import 'package:flutter/material.dart';

import '../_core/super/super.dart';

@RoutePage()
class FontsPage extends StatelessWidget {
  const FontsPage({
    this.title = '',
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => $.alert.showModal(
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Log user'),
                      onTap: () => $.debug(context.read<UserCubit>().state.user),
                    ),
                    ElevatedButton(onPressed: () => context.router.pop(), child: const Text('pop')),
                  ],
                ),
              ),
              child: const Text('Modal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await $.alert.showDialog(
                  builder: (_) => SimpleDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    title: const Text('Select assignment'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          $.alert.popDialog(1);
                        },
                        child: const Text('Number 1'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          $.alert.popDialog(2);
                        },
                        child: const Text('Number 2'),
                      ),
                    ],
                  ),
                );

                $.debug(result);
              },
              child: const Text('Dialog'),
            ),
            ElevatedButton(
              onPressed: () => $.alert.showSheet(
                builder: (_) => Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red,
                  ),
                  margin: const EdgeInsets.all(16),
                  alignment: Alignment.topCenter,
                  height: 200,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 50,
                    color: Colors.white,
                    onPressed: $.alert.popDialog,
                  ),
                ),
              ),
              child: const Text('Sheet'),
            ),
            ElevatedButton(
              onPressed: () => $.overlay.showOverlay(
                builder: (_) => Stack(
                  children: <Widget>[
                    ModalBarrier(
                      dismissible: false,
                      color: Colors.black45,
                      onDismiss: () {
                        $.overlay.hideOverlay();
                      },
                    ),
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              child: const Text('Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
