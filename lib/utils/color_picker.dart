import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final Color headerColor;
  final Color backgroundColor;
  final Function(Color) onHeaderColorSelected;
  final Function(Color) onBackgroundColorSelected;

  ColorPicker({
    required this.headerColor,
    required this.backgroundColor,
    required this.onHeaderColorSelected,
    required this.onBackgroundColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Colors'),
      content: Column(
        children: [
          Text('Choose a header color:'),
          ColorPickerButton(
            onColorSelected: onHeaderColorSelected,
            colors: [
              hexToColor("#333333"),  // Dark Gray
              hexToColor("#1A237E"),  // Navy Blue
              hexToColor("#009688"),  // Teal
              hexToColor("#FF5733"),  // Dark Orange
              hexToColor("#673AB7"),  // Deep Purple
            ],
          ),
          SizedBox(height: 16.0),
          Text('Choose a background color:'),
          ColorPickerButton(
            onColorSelected: onBackgroundColorSelected,
            colors: [
              hexToColor("#1BF702"),
              hexToColor("#AA1BF7"),
              hexToColor("#F7DD11"),
              hexToColor("#FFEBD6"),
              hexToColor("#EAE7E9"),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class ColorPickerButton extends StatelessWidget {
  final Function(Color) onColorSelected;
  final List<Color> colors;

  ColorPickerButton({
    required this.onColorSelected,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (final color in colors)
          Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Color hexToColor(String hexColor) {
  return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
}
