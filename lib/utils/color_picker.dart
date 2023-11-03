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
      title: Text('Обрати кольори'),
      content: Column(
        children: [
          Text('Обрати колір заголовка:'),
          ColorPickerButton(
            onColorSelected: onHeaderColorSelected,
            colors: [
              Colors.blue,
              Colors.red,
              Colors.green,
              Colors.purple,
              Colors.amber,
            ],
          ),
          SizedBox(height: 16.0),
          Text('Обрати колір фону:'),
          ColorPickerButton(
            onColorSelected: onBackgroundColorSelected,
            colors: [
              Colors.white,
              Colors.grey,
              Colors.yellow,
              Colors.pink,
              Colors.teal,
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Закрити'),
        ),
      ],
    );
  }
}

class ColorPickerButton extends StatelessWidget {
  final Function(Color) onColorSelected;
  final List<Color> colors;

  ColorPickerButton({required this.onColorSelected, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
