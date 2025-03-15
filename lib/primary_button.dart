import 'package:flutter/material.dart';
import '../commonui.dart';
import 'common_margin.dart';

enum ButtonVariant {
  primary,
  secondary,
  tertiary,
  primaryIconOnly,
  secondaryIconOnly,
  tertiaryIconOnly,
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
      onTapDown: (_) {
        setState(() {
          _isPressed = true; // Set pressed state on tap down
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false; // Reset pressed state when tap is released
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false; // Reset the state when the tap is canceled
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
              // If it's an icon-only variant, show only the icon(s)
              if (_isIconOnlyVariant())
                _buildIcon(context, widget.prefixIconPath, widget.prefixIconColor),
              if (!_isIconOnlyVariant()) ...[
                // Show prefix icon if available
                if (widget.prefixIconPath != null)
                  _buildIcon(context, widget.prefixIconPath, widget.prefixIconColor),
                widget.label,  // Show label in normal cases
                // Show suffix icon if available
                if (widget.suffixIconPath != null)
                  _buildIcon(context, widget.suffixIconPath, widget.suffixIconColor),
              ]
            ],
          ),
        ),
      ),
    );
  }

  bool _isIconOnlyVariant() {
    return widget.variant == ButtonVariant.primaryIconOnly ||
        widget.variant == ButtonVariant.secondaryIconOnly ||
        widget.variant == ButtonVariant.tertiaryIconOnly;
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.isDisabled) {
      return widget.variant == ButtonVariant.primary
          ? Theme.of(context).appColors.neutral100
          : widget.variant == ButtonVariant.secondary
              ? Colors.transparent // Secondary button has no background color
              : Theme.of(context).appColors.neutral300;
    }

    if (_isPressed) {
      // Slightly darker shade when button is pressed
      return widget.variant == ButtonVariant.primary
          ? Theme.of(context).appColors.primary400 // Darker primary color
          : widget.variant == ButtonVariant.secondary
              ? Colors.transparent // Secondary remains transparent when pressed
              : Theme.of(context).appColors.neutral400; // Darker tertiary color
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return Theme.of(context).appColors.primary500;
      case ButtonVariant.secondary:
        return Colors.transparent; // No background for secondary button
      case ButtonVariant.tertiary:
        return Colors.transparent; // No background for tertiary button
      case ButtonVariant.primaryIconOnly:
        return Theme.of(context).appColors.primary500;
      case ButtonVariant.secondaryIconOnly:
        return Colors.transparent; // No background for secondary icon-only
      case ButtonVariant.tertiaryIconOnly:
        return Colors.transparent; // No background for tertiary icon-only
    }
  }

  Border? _getBorder(BuildContext context) {
    if (widget.variant == ButtonVariant.secondary ||
        widget.variant == ButtonVariant.secondaryIconOnly) {
      return Border.all(
        color: Theme.of(context).appColors.primary500, // Primary color for secondary button border
        width: 2,
      );
    }
    return null; // No border for primary, tertiary, or icon-only buttons
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (widget.variant == ButtonVariant.secondary) {
      return TextStyle(
        color: Theme.of(context).appColors.primary500, // Primary color for text and icons in secondary button
        fontWeight: FontWeight.w600,
      );
    } else if (widget.variant == ButtonVariant.tertiary) {
      return TextStyle(
        color: Theme.of(context).appColors.neutral500, // Neutral color for text and icons in tertiary button
        fontWeight: FontWeight.w600,
      );
    }

    return TextStyle(
      color: Theme.of(context).appColors.shadesWhite00, // Default text color for primary button
      fontWeight: FontWeight.w600,
    );
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
            iconColor ?? _getTextStyle(context).color!, // Use appropriate color based on button variant
            BlendMode.srcIn,
          ),
        ),
        const CommonMargin(horizontal: 12),
      ],
    );
  }
}
