import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomSearchBar({super.key, this.onChanged, this.onSubmitted});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _clearText() {
    _controller.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: 'Cari destinasi wisata',
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        suffixIcon: _hasText
            ? IconButton(
                icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
                onPressed: _clearText,
              )
            : null,
      ),
    );
  }
}
