import 'package:flutter/material.dart';
import '../commonui.dart';
import 'common_margin.dart';

class PrimaryButton extends StatelessWidget {
  final Widget label;
  final Color? color;
  final double? maxWidth;
  final VoidCallback onClick;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool isDisabled;

  const PrimaryButton({
    required this.label,
    required this.onClick,
    this.color,
    this.maxWidth,
    this.prefixIconPath,
    this.suffixIconPath,
    this.prefixIconColor,
    this.suffixIconColor,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: isDisabled
          ? null
          : onClick, // Disable button on tap if isDisabled is true
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 640),
        decoration: BoxDecoration(
          color: isDisabled
              ? color ?? Theme.of(context).appColors.neutral100
              : Theme.of(context).appColors.primary500,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(context, prefixIconPath, prefixIconColor),
              label,
              _buildIcon(context, suffixIconPath, suffixIconColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(final BuildContext context, final String? iconPath,
      final Color? iconColor,) {
    if (iconPath == null) {
      return const SizedBox();
    }
    return Row(
      children: [
        const CommonMargin(horizontal: 12),
        SvgImageLoader(
          imagePath: iconPath,
          height: 20,
          width: 20,
          colorFilter: ColorFilter.mode(
            iconColor ?? Theme.of(context).appColors.shadesWhite00,
            BlendMode.srcIn,
          ),
        ),
        const CommonMargin(horizontal: 12),
      ],
    );
  }
}
