import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/color_picker.dart';
import '/widgets/website_item.dart';
import '/models/note.dart';
import '/utils/shared_preferences.dart';
import '/screens/home_screen.dart';

class AIchat extends StatefulWidget {
  @override
  _AIchatState createState() => _AIchatState();
}

class _AIchatState extends State<AIchat> {
  final List<WebsiteItem> websiteItems = [
    WebsiteItem(
      title: 'GPT',
      url: 'https://chat.openai.com/',
      icon: Icons.public, // Use the public icon
    ),
    WebsiteItem(
      title: 'Google Bard',
      url: 'https://bard.google.com/',
      icon: Icons.music_note,
    ),
    WebsiteItem(
        title: 'Bing',
        url:
            'https://www.bing.com/search?form=MY0291&OCID=MY0291&q=Bing+AI&showconv=1',
        icon: Icons.assignment),
    WebsiteItem(
        title: 'C.ai',
        url: 'https://beta.character.ai/',
        icon: Icons.chat_bubble_outline_outlined),
    WebsiteItem(title: 'Flux', url: 'https://www.flux.ai/p', icon: Icons.build),
    WebsiteItem(title: 'TinEye', url: 'https://tineye.com/', icon: Icons.visibility),
  ];

  String username = 'Користувач';
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
                _showDialog('Фото', 'In development rn😁');
              } else if (value == 'change_colors') {
                _changeColors();
              } else if (value == 'third_color_option') {

              }
            },
            itemBuilder: (BuildContext context) {
              return [];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor.withOpacity(0.3),
              headerColor.withOpacity(0.9),
            ],
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
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: _buildNoteTextField(index, note),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              userNotes.removeAt(index);
                            });
                            saveNotes();
                          },
                        ),
                      ),
                    );
                  }),
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
                      icon: const Icon(Icons.add, color: Colors.white),
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
      drawer: _buildSideMenu(),
    );
  }

  Widget _buildTile(BuildContext context, WebsiteItem item) {
    return GestureDetector(
      onTap: () {
        _launchURL(context, item.url, item.title);
      },
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: headerColor.withOpacity(0.93),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, color: Colors.white, size: 40.0),
              Text(
                item.title,
                style: const TextStyle(
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

  Widget _buildSideMenu() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: headerColor,
            ),
            child: Center(
              child: Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home), // Icon for the "Головна" item
            title: const Text('Головна'),
            onTap: () {
              // Then navigate to the home screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.person), // Icon for the "Змінити псевдонім" item
            title: const Text('Змінити псевдонім'),
            onTap: _changeUsername,
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Фото'),
            onTap: () {
              _showDialog('Фото', 'In development rn😁');
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette), // Icon for the "Тема" item
            title: const Text('Тема'),
            onTap: _changeColors,
          ),
          ListTile(
            leading: const Icon(
                Icons.chat_bubble), // Icon for the "Тема" item (Android robot)
            title: const Text('ШІ допомога'),
            onTap: () {
              // Then navigate to the home screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AIchat(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(
                Icons.slideshow_outlined), // Icon for the "Презентація" item
            title: const Text('Презентація'),
            onTap: () {
              // Define the URL and title for your presentation
              final presentationUrl =
                  'https://www.canva.com/design/DAFzIsvddJE/3ym-LYWUEHvHdsOZRvXpiQ/view?utm_content=DAFzIsvddJE&utm_campaign=designshare&utm_medium=link&utm_source=editor'; // Replace with your presentation URL
              final presentationTitle =
                  'Презентація Програми'; // Replace with your presentation title

              // Launch the presentation URL using the _launchURL function
              _launchURL(context, presentationUrl, presentationTitle);
            },
          ),
          ListTile(
            leading: const Icon(
                Icons.code), // Icon for the "Презентація" item
            title: const Text('Git'),
            onTap: () {
              // Launch the presentation URL using the _launchURL function
              _launchURL(
                  context, "https://github.com/Exaster/ISA", 'Код проекту');
            },
          ),
        ],
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
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildNotesTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: notesController,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Додати нотатку',
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
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
              child: const Text('OK'),
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
          title: const Text('Змінити псевдонім'),
          content: TextField(
            onChanged: (text) {
              newUsername = text;
            },
            decoration: const InputDecoration(
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
              child: const Text('Зберегти'),
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
          toolbarColor: headerColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: headerColor,
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
