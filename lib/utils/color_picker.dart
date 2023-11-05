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
      title: Text('Вибір теми', style: TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 1)])),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Основні кольори для заголовків:', style: TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 1)]),
            ),
            ColorPickerButton(
              onColorSelected: onHeaderColorSelected,
              colors: [
                hexToColor("#333333"),  // Dark Gray
                hexToColor("#1A237E"),  // Navy Blue
                hexToColor("#009688"),  // Teal
                hexToColor("#FF5733"),  // Dark Orange
                hexToColor("#673AB7"),  // Deep Purple
                hexToColor("#E57373"),  // Light Red
                hexToColor("#26A69A"),  // Turquoise
                hexToColor("#FFA726"),  // Orange
                hexToColor("#03A9F4"),  // Light Blue
                hexToColor("#4CAF50"),  // Green
                hexToColor("#FF3D00"),  // Tomato Red
                hexToColor("#4E342E"),  // Brown
                hexToColor("#795548"),  // Light Brown
                hexToColor("#8D6E63"),  // Taupe
                hexToColor("#00BCD4"),  // Cyan
                hexToColor("#FF4081"),  // Pink
                hexToColor("#3F51B5"),  // Indigo
                hexToColor("#827717"),  // Mustard
                hexToColor("#9C27B0"),  // Purple
                hexToColor("#607D8B"),  // Blue Gray
              ],
            ),
            SizedBox(height: 16.0),
            Text('Фонові кольори:', style: TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 1)]),
            ),
            ColorPickerButton(
              onColorSelected: onBackgroundColorSelected,
              colors: [
                hexToColor("#1BF702"),  // Neon Green
                hexToColor("#AA1BF7"),  // Lavender
                hexToColor("#F7DD11"),  // Yellow
                hexToColor("#FFEBD6"),  // Peach
                hexToColor("#EAE7E9"),  // Gray
                hexToColor("#B2EBF2"),  // Light Blue
                hexToColor("#D1C4E9"),  // Light Purple
                hexToColor("#C5E1A5"),  // Light Green
                hexToColor("#FFD600"),  // Bright Yellow
                hexToColor("#BBDEFB"),  // Sky Blue
                hexToColor("#FF8A80"),  // Coral
                hexToColor("#C8E6C9"),  // Light Green
                hexToColor("#FFE0B2"),  // Light Orange
                hexToColor("#E0E0E0"),  // Silver
                hexToColor("#90CAF9"),  // Blue
                hexToColor("#FF80AB"),  // Pink
                hexToColor("#7986CB"),  // Indigo
                hexToColor("#A5D6A7"),  // Green
                hexToColor("#A1887F"),  // Brown
                hexToColor("#E0E0E0"),  // Light Gray
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Закрити', style: TextStyle(shadows: [Shadow(color:  Colors.blue.withOpacity(0.1), blurRadius: 1)]),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final color in colors)
            Padding(
              padding: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => onColorSelected(color),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        offset: Offset(0, 0),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Color hexToColor(String hexColor) {
  return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
}
