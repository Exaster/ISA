
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class SharedPreferencesHelper {
  static const String usernameKey = 'username';
  static const String headerColorKey = 'headerColor';
  static const String backgroundColorKey = 'backgroundColor';

  // Save the username to shared preferences

  void saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  void saveNotes(List<Note> userNotes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', userNotes.map((note) => note.text).toList());
  }

  Future<List<Note> > loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final noteTexts = prefs.getStringList('notes') ?? [];
    return noteTexts.map((text) => Note(text: text)).toList();
  }

  void saveColors(Color headerColor, Color backgroundColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('headerColor', headerColor.value);
    await prefs.setInt('backgroundColor', backgroundColor.value);
  }

  Future<Map<String, Color>> loadColors() async {
    final prefs = await SharedPreferences.getInstance();
    final headerColor = Color(prefs.getInt('headerColor') ?? Colors.blue.value);
    final backgroundColor = Color(prefs.getInt('backgroundColor') ?? Colors.white.value);
    return {
      'headerColor': headerColor,
      'backgroundColor': backgroundColor,
    };
  }
  // Load the username from shared preferences


  // Save the header color to shared preferences
  static Future<void> saveHeaderColor(int colorValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(headerColorKey, colorValue);
  }

  // Load the header color from shared preferences
  static Future<int?> loadHeaderColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(headerColorKey);
  }

  // Save the background color to shared preferences
  static Future<void> saveBackgroundColor(int colorValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(backgroundColorKey, colorValue);
  }

  // Load the background color from shared preferences
  static Future<int?> loadBackgroundColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(backgroundColorKey);
  }
}
void saveColors(Color headerColor, Color backgroundColor) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('headerColor', headerColor.value);
  await prefs.setInt('backgroundColor', backgroundColor.value);
}

Future<Map<String, Color>> loadColors() async {
  final prefs = await SharedPreferences.getInstance();
  final headerColor = Color(prefs.getInt('headerColor') ?? Colors.blue.value);
  final backgroundColor = Color(prefs.getInt('backgroundColor') ?? Colors.white.value);
  return {
    'headerColor': headerColor,
    'backgroundColor': backgroundColor,
  };
}