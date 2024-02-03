import 'package:deps/design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helpers.dart';
import '../../../../utils/store.dart';
import 'search_actions_widget.dart';

class DynamicSearchBarWidget extends StatefulWidget {
  const DynamicSearchBarWidget({
    required this.searchBar,
    required this.editingController,
    required this.focusNode,
    required this.animationDuration,
    required this.searchBarHasFocus,
    required this.searchBarFocusThings,
    required this.opacity,
    super.key,
  });

  final Duration animationDuration;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final double opacity;
  final FabAppBarSearchBarSettings searchBar;
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            onPressed: () {
              widget.searchBarFocusThings(false);
              widget.focusNode.unfocus();
              widget.editingController.clear();
            },
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: widget.searchBarHasFocus ? 1 : 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.searchBar.cancelButtonText,
                  style: context.fabTheme.appBarTitleNActionsStyle,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
        Row(
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
                  setState(() {});
                },
                child: CupertinoSearchTextField(
                  padding: const EdgeInsetsDirectional.fromSTEB(5.5, 0, 5.5, 0),
                  prefixInsets: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 2),
                  suffixInsets: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                  borderRadius: widget.searchBar.borderRadius,
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
                  placeholderStyle: context.fabTheme.bodyStyle.copyWith(
                    color: context.fabTheme.placeholderColor.withOpacity(widget.opacity),
                  ),
                  style: context.fabTheme.bodyStyle,
                  controller: widget.editingController,
                  focusNode: widget.focusNode,
                  backgroundColor: context.fabTheme.surfaceColor,
                  autocorrect: false,
                ),
              ),
            ),
            SearchActionsWidget(
              actions: widget.searchBar.actions,
              animationDuration: widget.animationDuration,
              searchBarHasFocus: widget.searchBarHasFocus,
            ),
            AnimatedContainer(
              duration: widget.animationDuration,
              width: widget.searchBarHasFocus
                  ? defaultTextSize(
                      widget.searchBar.cancelButtonText,
                      context.fabTheme.appBarTitleNActionsStyle,
                    )
                  : 0,
            ),
          ],
        ),
      ],
    );
  }
}
