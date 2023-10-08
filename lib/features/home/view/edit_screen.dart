// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_snow/features/models/note_data.dart';
import 'package:notes_snow/features/models/notes_model.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatefulWidget {
  NoteModel note;
  bool isNewNote;

  EditNotePage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  QuillController _controller = QuillController.basic();
  QuillController _contentcontroller = QuillController.basic();

//to load existing notes details
  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.title);
    setState(() {
      _controller = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(
            offset: 0,
          ));
    });
  }

  // add new note
  void addNewNote() {
    //getting new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //get details from editor
    String title = _controller.document.toPlainText();
    String content = _contentcontroller.document.toPlainText();
    // Color color = Provider.of<NoteData>(context) as Color;
    //add new note
    Provider.of<NoteData>(context, listen: false).addNewNotes(NoteModel(
      id: id,
      title: title,
      content: content,
      // color: color,
    ));
  }

  //update existing note
  void updateNote() {
    //get from editor
    String title = _controller.document.toPlainText();
    String content = _contentcontroller.document.toPlainText();
    // Color color = Provider.of<NoteData>(context) as Color;

    Provider.of<NoteData>(context, listen: false).updateNote(
      widget.note,
      title,
      content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            //new note
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            }
            //for existing notes
            else {
              updateNote();
            }
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              color: Colors.white.withOpacity(0.3),
              child:
                  QuillEditor.basic(controller: _controller, readOnly: false),
            ),
            Expanded(
                child: SizedBox(
              child: QuillEditor.basic(
                  controller: _contentcontroller, readOnly: false),
            )),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: QuillToolbar.basic(
                controller: _controller,
                showCodeBlock: false,
                showDirection: false,
                showFontSize: false,
                showColorButton: false,
                showBackgroundColorButton: false,
                showDividers: false,
                showFontFamily: false,
                showClearFormat: false,
                showListBullets: false,
                showListCheck: false,
                showQuote: false,
                showUndo: false,
                showRedo: false,
                showListNumbers: false,
                showLink: false,
                showSearchButton: false,
                showSmallButton: false,
                showStrikeThrough: false,
                showSubscript: false,
                showSuperscript: false,
                showInlineCode: false,
                showHeaderStyle: false,
                showJustifyAlignment: true,
                showIndent: false,
                showAlignmentButtons: true,
                showLeftAlignment: true,
                showRightAlignment: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
