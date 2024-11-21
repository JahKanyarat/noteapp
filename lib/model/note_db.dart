import 'package:flutter/material.dart';
import 'package:hw5_noteapp/model/note_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDb extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    // final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([NoteModelSchema], directory: dir.path);
  }

  final List<NoteModel> currentNotes = [];

  Future<void> fetchAllNotes() async {
    List<NoteModel> notes = await isar.noteModels.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(notes);
    notifyListeners();
  }

  Future<void> addNote(String txt) async {
    final newNote = NoteModel()..noteTxt = txt;
    await isar.writeTxn(() => isar.noteModels.put(newNote));
    fetchAllNotes();
  }

  Future<void> updateNote(int id, String newTxt) async {
    final note = await isar.noteModels.get(id);
    if (note != null) {
      note.noteTxt = newTxt;
      await isar.writeTxn(() => isar.noteModels.put(note));
      await fetchAllNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    await fetchAllNotes();
  }
}
