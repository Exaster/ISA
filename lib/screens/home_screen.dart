import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/color_picker.dart';
import '/widgets/website_item.dart';
import '/models/note.dart';
import '/utils/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<WebsiteItem> websiteItems = [
    WebsiteItem(
        title: 'Розклад',
        url: 'https://asu.pnu.edu.ua/search-groups.html',
        icon: Icons.schedule),
    WebsiteItem(
        title: 'Дистанційне\n'+'  навчання',
        url: 'https://d-learn.pro/',
        icon: Icons.desktop_mac),
    WebsiteItem(
        title: 'Журнал',
        url: 'https://webportal.pnu.edu.ua/apps',
        icon: Icons.assignment),
    WebsiteItem(
        title: 'Новини', url: 'https://pnu.edu.ua', icon: Icons.new_releases),
    WebsiteItem(
        title: 'Навігація',
        url: 'https://city.dozor.tech/ua/iv-frankivsk/city',
        icon: Icons.navigation),
    WebsiteItem(
        title: 'Путівник студента',
        url: 'https://pnu.edu.ua/studentam-2/',
        icon: Icons.school),
  ];

  String username = '';
  List<Note> userNotes = [];
  final TextEditingController notesController = TextEditingController();
  Color headerColor = Colors.blue; // Default header color
  Color backgroundColor = Colors.white; // Default background color

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadNotes();
    loadColors().then((colors) {
      setState(() {
        headerColor = colors['headerColor'] ?? Colors.blue;
        backgroundColor = colors['backgroundColor'] ?? Colors.white;
      });
    });
  }

  @override
  void dispose() {
    saveNotes();
    saveColors(headerColor, backgroundColor);
    super.dispose();
  }

  void saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'notes', userNotes.map((note) => note.text).toList());
  }

  void loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userNotes = (prefs.getStringList('notes') ?? [])
          .map((text) => Note(text: text))
          .toList();
    });
  }

  void saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  void loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? username;
      if (username.toLowerCase() == 'шарашкіна контора') {
        username = 'База 😎🔥';
        saveUsername();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate a slightly lighter color based on headerColor
    // Adjust the opacity as needed

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(username),
        backgroundColor: headerColor,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'change_username') {
                _changeUsername();
              } else if (value == 'theme') {
                _showDialog('Тема', 'In development rn😁');
              } else if (value == 'avatar') {
                _showDialog('Аватар', 'In development rn😁');
              } else if (value == 'change_colors') {
                _changeColors();
              } else if (value == 'third_color_option') {
                // Handle the third color option here
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                _buildPopupMenuItem('change_username', 'Змінити псевдонім'),
                _buildPopupMenuItem('avatar', 'Аватар'),
                _buildPopupMenuItem('change_colors', 'Тема'),
              ];
            },
          ),
        ],
      ),
      body: Container(
        // Use a LinearGradient to create the desired gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              backgroundColor.withOpacity(0.3),
              headerColor.withOpacity(0.9)
            ], // Ця ХРІНЬ ВІДПОВІДАЄ ЗА ГУСТИНУ КОЛЬОРІВ
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    shrinkWrap: true,
                    children: websiteItems
                        .map((item) => _buildTile(context, item))
                        .toList(),
                  ),
                  ...userNotes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final note = entry.value;
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      padding: EdgeInsets.all(5.0), // Reduce the padding here
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: _buildNoteTextField(index, note),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              userNotes.removeAt(index);
                            });
                            saveNotes();
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            BottomAppBar(
              color: headerColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildNotesTextField(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          userNotes.add(Note(text: notesController.text));
                          notesController.text = '';
                        });
                        saveNotes();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, WebsiteItem item) {
    return GestureDetector(
      onTap: () {
        _launchURL(context, item.url, item.title);
      },
      child: Card(
        color: Colors.blue,
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center, // Center the text horizontally and vertically
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, color: Colors.white, size: 40.0),
              Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildNoteTextField(int index, Note note) {
    return ListTile(
      title: TextField(
        controller: TextEditingController(text: note.text),
        onChanged: (newText) {
          setState(() {
            userNotes[index] = Note(text: newText);
          });
          saveNotes();
        },
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildNotesTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(20.0), // Add rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // Add a shadow for a modern look
          ),
        ],
      ),
      child: TextField(
        controller: notesController,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Додати нотатку',
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black, // You can change the text color
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, String label) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(label),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _changeUsername() {
    showDialog(
      context: context,
      builder: (context) {
        String newUsername = username;
        return AlertDialog(
          title: Text('Змінити псевдонім'),
          content: TextField(
            onChanged: (text) {
              newUsername = text;
            },
            decoration: InputDecoration(
              labelText: 'Новий псевдонім',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  username = newUsername;
                });
                saveUsername();
                Navigator.of(context).pop();
              },
              child: Text('Зберегти'),
            ),
          ],
        );
      },
    );
  }

  void _changeColors() {
    showDialog(
      context: context,
      builder: (context) {
        return ColorPicker(
          onHeaderColorSelected: (color) {
            setState(() {
              headerColor = color;
            });
            saveColors(headerColor, backgroundColor);
            Navigator.of(context).pop();
          },
          onBackgroundColorSelected: (color) {
            setState(() {
              backgroundColor = color;
            });
            saveColors(headerColor, backgroundColor);
            Navigator.of(context).pop();
          },
          headerColor: headerColor,
          backgroundColor: backgroundColor,
        );
      },
    );
  }

  void _launchURL(BuildContext context, String url, String title) async {
    try {
      await launch(
        url,
        customTabsOption: CustomTabsOption(
          toolbarColor: headerColor, // Set the header color
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: headerColor, // Set the header color
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
