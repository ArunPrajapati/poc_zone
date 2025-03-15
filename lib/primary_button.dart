import 'package:flutter/material.dart';
import '../commonui.dart';
import 'common_margin.dart';

enum ButtonVariant {
  primary,
  secondary,
  tertiary,
}

class AppButton extends StatefulWidget {
  final Widget label;
  final ButtonVariant variant;
  final VoidCallback onClick;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool isDisabled;

  const AppButton({
    required this.label,
    required this.onClick,
    this.variant = ButtonVariant.primary,
    this.prefixIconPath,
    this.suffixIconPath,
    this.prefixIconColor,
    this.suffixIconColor,
    this.isDisabled = false,
    super.key,
  });

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisabled
          ? null
          : () {
              setState(() {
                _isPressed = true;
              });
              widget.onClick(); // Call the onClick callback
            },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(12),
          border: _getBorder(context),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: MediaQuery.of(context).size.width > 400 ? 24 : 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,  // Wraps content based on label and icons
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(context, widget.prefixIconPath, widget.prefixIconColor),
              widget.label,
              _buildIcon(context, widget.suffixIconPath, widget.suffixIconColor),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.isDisabled) {
      return widget.variant == ButtonVariant.primary
          ? Theme.of(context).appColors.neutral100
          : widget.variant == ButtonVariant.secondary
              ? Theme.of(context).appColors.neutral200
              : Theme.of(context).appColors.neutral300;
    }

    if (_isPressed) {
      // Slightly darker shade when button is pressed
      return widget.variant == ButtonVariant.primary
          ? Theme.of(context).appColors.primary400 // Darker primary color
          : widget.variant == ButtonVariant.secondary
              ? Theme.of(context).appColors.secondary400 // Darker secondary color
              : Theme.of(context).appColors.neutral400; // Darker tertiary color
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return Theme.of(context).appColors.primary500;
      case ButtonVariant.secondary:
        return Theme.of(context).appColors.secondary500;
      case ButtonVariant.tertiary:
        return Colors.transparent; // No background color for tertiary
    }
  }

  Border? _getBorder(BuildContext context) {
    if (widget.variant == ButtonVariant.tertiary) {
      return Border.all(
        color: Theme.of(context).appColors.neutral500,
        width: 2,
      );
    }
    return null; // No border for primary or secondary
  }

  Widget _buildIcon(
    final BuildContext context,
    final String? iconPath,
    final Color? iconColor,
  ) {
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
