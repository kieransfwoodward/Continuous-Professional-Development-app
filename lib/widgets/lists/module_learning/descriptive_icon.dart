import 'package:flutter/material.dart';

// Module information widget

class DescriptiveIcon extends StatefulWidget {
  const DescriptiveIcon({
    Key? key,
    required this.leadingIcon,
    required this.trailingText,
    required this.isLargeItem,
  }) : super(key: key);
  final IconData leadingIcon;
  final String trailingText;
  final bool isLargeItem;

  @override
  State<DescriptiveIcon> createState() => _DescriptiveIconState();
}

class _DescriptiveIconState extends State<DescriptiveIcon> {
  late Color _color;
  late TextStyle? _style;

  // This method runs after the widget is built,
  // running the code only then to prevent memory leaks
  // and access to references that do not yet exist
  @override
  void didChangeDependencies() {
    setState(() {
      _color = const Color(0xffd47828);

      _style = widget.isLargeItem
          ? Theme.of(context).textTheme.headline6?.copyWith(
        color: const Color(0xffd47828),
                fontWeight: FontWeight.normal,
              )
          : Theme.of(context).textTheme.bodyText2?.copyWith(color: _color);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.leadingIcon,
          size: widget.isLargeItem ? null : 18,
          color: const Color(0xffd47828),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: widget.isLargeItem ? 8.0 : 4.0,
          ),
          child: Text(
            widget.trailingText,
            style: _style,
          ),
        ),
      ],
    );
  }
}
