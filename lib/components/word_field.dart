import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lexduel/style/app_colors.dart';

class WordField extends StatefulWidget {
  final List<String> restricted;
  final ValueChanged<String>? onSubmitted;

  const new({super.key, this.restricted = const [], this.onSubmitted});

  @override
  State<WordField> createState() => _WordFieldState();
}

class _WordFieldState extends State<WordField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColorsLight.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
      ),
      style: const TextStyle(color: AppColorsLight.primary),
      cursorColor: AppColorsLight.primary,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
        if (widget.restricted.isNotEmpty)
          FilteringTextInputFormatter.deny(
            RegExp(widget.restricted.map(RegExp.escape).join('|')),
          ),
      ],
      onSubmitted: (value) {
        final normalized = value.toLowerCase();
        _controller.clear();
        widget.onSubmitted?.call(normalized);
      },
    );
  }
}
