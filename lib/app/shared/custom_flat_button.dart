import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading,
    this.color,
    this.labelStyle,
    this.isWrapped = false,
    this.borderRadius = 6.0,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    this.overlayColor,
  });
  final VoidCallback? onPressed;
  final String label;
  final TextStyle? labelStyle;
  final ValueNotifier<bool>? isLoading;
  final bool isWrapped;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? overlayColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWrapped ? null : double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading ?? ValueNotifier(false),
        builder: (context, loading, child) {
          return TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(padding),
              // backgroundColor: MaterialStateProperty.all(
              //   loading
              //       ? Theme.of(context).disabledColor
              //       : color ?? Theme.of(context).primaryColor,
              // ),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
              ),
              overlayColor: MaterialStateProperty.all(
                  overlayColor ?? Theme.of(context).primaryColorDark),
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onPressed: loading ? null : onPressed,
            child: loading
                ? SizedBox(
                    height: 22,
                    width: 22,
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            color ?? Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  )
                : child!,
          );
        },
        child: Text(
          label,
          style: labelStyle ??
              GoogleFonts.sarabun(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
