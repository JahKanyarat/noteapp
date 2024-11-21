import 'package:flutter/material.dart';
import 'package:hw5_noteapp/components/my_drawer.dart';
import 'package:hw5_noteapp/components/notes_tile.dart';
import 'package:hw5_noteapp/model/note_db.dart';
import 'package:hw5_noteapp/model/note_model.dart';
import 'package:provider/provider.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _formKey = GlobalKey<FormState>();
  String _newNote = "";

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Enter new note")),
                          onSaved: (newValue) {
                            _newNote = newValue!;
                          },
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              context.read<NoteDb>().addNote(_newNote);
                              _formKey.currentState!.reset();
                              Navigator.pop(context);
                            },
                            child: const Text("ADD"))
                      ],
                    )),
              ),
            ));
  }

  void readNote() {
    context.read<NoteDb>().fetchAllNotes();
  }

  @override
  void initState() {
    super.initState();
    readNote();
  }

  void updateNote(NoteModel note) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Update your note")),
                          initialValue: note.noteTxt,
                          onSaved: (newValue) {
                            _newNote = newValue!;
                          },
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              context
                                  .read<NoteDb>()
                                  .updateNote(note.id, _newNote);
                              _formKey.currentState!.reset();
                              Navigator.pop(context);
                            },
                            child: const Text("UPDATE"))
                      ],
                    )),
              ),
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDb>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDb>();
    List<NoteModel> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTES"),
        backgroundColor: const Color.fromARGB(255, 87, 171, 240),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  return NotesTile(
                      text: note.noteTxt,
                      onEdtPressed: () => updateNote(note),
                      onDelPreesed: () => deleteNote(note.id));
                }),
          ),
        ],
      ),
    );
  }
}
