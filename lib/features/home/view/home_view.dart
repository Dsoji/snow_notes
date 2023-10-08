import 'dart:math';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:notes_snow/core/widget/preview_widget.dart';
import 'package:notes_snow/features/home/view/edit_screen.dart';
import 'package:notes_snow/features/models/notes_model.dart';
import 'package:provider/provider.dart';

import '../../models/note_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create new notes
  void createNewNote() {
    //create id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    // Color color = Colors.white;
    //create blank notes
    NoteModel newNote = NoteModel(
      id: id,
      title: '',
      content: '',
      // color: color,
    );
    //Newpage
    goToNotePage(newNote, true);
  }

  void goToNotePage(NoteModel note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(
          isNewNote: isNewNote,
          note: note,
        ),
      ),
    );
  }

  void deleteNote(NoteModel note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  List<Color> generateRandomColors(int count) {
    final List<Color> uniqueColors = [];
    final Random random = Random();

    while (uniqueColors.length < count) {
      final Color randomColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      );

      if (!uniqueColors.contains(randomColor)) {
        uniqueColors.add(randomColor);
      }
    }

    return uniqueColors;
  }

  final List<Color> predefinedColors = [
    const Color(0xFFC2DCFD),
    const Color(0xFFFCFAD9),
    const Color(0xFFFFD8F4),
    const Color(0xFFF1DBF5),
    const Color(0xFFFBF6AA),
    const Color(0xFFD9E8FC),
    const Color(0xFFB0E9CA),
    const Color(0xFFFFDBE3),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 120,
          flexibleSpace: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${DateFormat.y().format(DateTime.now())} ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Avenir',
                          color: Provider.of<NoteData>(context).isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: DateFormat.MMMM().format(DateTime.now()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Avenir',
                              color: Provider.of<NoteData>(context).isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Provider.of<NoteData>(context).isDarkMode
                            ? Icons.brightness_7
                            : Icons.brightness_4,
                        size: 24,
                      ),
                      onPressed: () {
                        Provider.of<NoteData>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ],
                ),
                const Gap(10),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      hintText: 'Search for notes...',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontFamily: 'Avenir'),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            splashColor: Colors.grey,
            backgroundColor: Colors.black,
            onPressed: createNewNote,
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: DatePicker(
                      DateTime.now(),
                      height: 100,
                      width: 80,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Provider.of<NoteData>(context).isDarkMode
                          ? Colors.black
                          : Colors.black,
                      selectedTextColor:
                          Provider.of<NoteData>(context).isDarkMode
                              ? Colors.white
                              : Colors.white,
                      dayTextStyle: TextStyle(
                        color: Provider.of<NoteData>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'Avenir',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      monthTextStyle: TextStyle(
                        color: Provider.of<NoteData>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Avenir',
                      ),
                      dateTextStyle: TextStyle(
                        color: Provider.of<NoteData>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: value.getAllNotes().isEmpty
                        ? const Center(
                            child: Text("You have no notes yet"),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: value.getAllNotes().length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // childAspectRatio: (1 / .3),
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              final color = predefinedColors[
                                  index % predefinedColors.length];
                              return PreviewContainer(
                                onTap: () => goToNotePage(
                                    value.getAllNotes()[index], false),
                                title: value.getAllNotes()[index].title,
                                content: value.getAllNotes()[index].content,
                                color: color,
                                // content: value.getAllNotes()[index].content,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
