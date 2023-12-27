part of '../fab_reactive_textfield.dart';

class Counter extends StatelessWidget {
  const Counter(
    this.hasCounter,
    this.currentLength,
    this.minLength,
    this.maxLength, {
    super.key,
  });

  final bool hasCounter;
  final int currentLength;
  final int? minLength;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    if (!hasCounter) {
      return const Nil();
    }

    if (maxLength == null) {
      throw AssertionError(
        'Max length must be provided when counter is active.',
      );
    }

    final counterColor = minLength != null && currentLength < minLength! && currentLength != 0
        ? Colors.red
        : context.colorScheme.onBackground;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: context.theme.dividerColor),
        ),
        borderRadius: Radiuses.lg.circularBorder,
      ),
      child: FabStyledText(
        text: '<c>${maxLength! - currentLength}</c>/$maxLength',
        style: context.textTheme.titleSmall,
        tags: {
          'c': StyledTextTag(
            style: context.textTheme.titleMedium?.copyWith(
              color: counterColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        },
      ),
    );
  }
}
