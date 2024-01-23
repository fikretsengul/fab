import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/appbar_action_settings.dart';
import '../../../../models/appbar_search_bar_settings.dart';
import '../../../../utils/store.dart';
import 'cancel_button_widget.dart';
import 'search_actions_widget.dart';

class DynamicSearchBarWidget extends StatefulWidget {
  const DynamicSearchBarWidget({
    required this.actions,
    required this.searchBar,
    required this.editingController,
    required this.focusNode,
    required this.animationDuration,
    required this.searchBarHasFocus,
    required this.searchBarFocusThings,
    required this.opacity,
    super.key,
  });

  final List<AppBarActionSettings> actions;
  final Duration animationDuration;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final double opacity;
  final AppBarSearchBarSettings searchBar;
  final ValueChanged<bool> searchBarFocusThings;
  final bool searchBarHasFocus;

  @override
  State<DynamicSearchBarWidget> createState() => _DynamicSearchBarWidgetState();
}

class _DynamicSearchBarWidgetState extends State<DynamicSearchBarWidget> {
  bool _isSubmitted = false;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Focus(
            onFocusChange: (hasFocus) {
              if (_isSubmitted) {
                _isSubmitted = false;

                return;
              }
              widget.searchBarFocusThings(hasFocus);
              // ignore: avoid_empty_blocks
              setState(() {});
            },
            child: CupertinoSearchTextField(
              padding: const EdgeInsetsDirectional.fromSTEB(5.5, 0, 5.5, 0),
              onSubmitted: (s) {
                _isSubmitted = true;
                widget.searchBar.onSubmitted?.call(s);
              },
              onChanged: (v) {
                if (v.isNotEmpty) {
                  if (widget.searchBar.resultBehavior == SearchBarResultBehavior.visibleOnInput) {
                    _store.searchBarResultVisible.value = true;
                  }
                } else {
                  if (widget.searchBar.resultBehavior == SearchBarResultBehavior.visibleOnInput) {
                    _store.searchBarResultVisible.value = false;
                  }
                }
                widget.searchBar.onChanged?.call(v);
              },
              prefixIcon: Opacity(
                opacity: widget.opacity,
                child: widget.searchBar.prefixIcon,
              ),
              placeholder: widget.searchBar.placeholderText,
              placeholderStyle: widget.searchBar.placeholderTextStyle.copyWith(
                color: widget.searchBar.placeholderTextStyle.color!.withOpacity(widget.opacity),
              ),
              style: widget.searchBar.textStyle.copyWith(
                color: widget.searchBar.textStyle.color ?? CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
              controller: widget.editingController,
              focusNode: widget.focusNode,
              backgroundColor: Colors.transparent,
              autocorrect: false,
            ),
          ),
        ),
        SearchActionsWidget(
          actions: widget.actions,
          animationDuration: widget.animationDuration,
          searchBarHasFocus: widget.searchBarHasFocus,
        ),
        CancelButtonWidget(
          onCancel: () {
            widget.searchBarFocusThings(false);
            widget.focusNode.unfocus();
            widget.editingController.clear();
          },
          cancelButtonText: widget.searchBar.cancelButtonText,
          cancelButtonTextStyle: widget.searchBar.cancelTextStyle,
          animationDuration: widget.animationDuration,
          searchBarHasFocus: widget.searchBarHasFocus,
        ),
      ],
    );
  }
}
