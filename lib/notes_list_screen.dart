import 'package:flutter/material.dart';
import 'add_note_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  NotesListScreenState createState() => NotesListScreenState();
}

class NotesListScreenState extends State<NotesListScreen> {
  final List<String> _notes = [];

  void _addOrUpdateNote({
    required String note,
    int? index,
  }) {
    setState(() {
      if (index == null) {
        _notes.add(note);
      } else {
        _notes[index] = note;
      }
    });
  }

  void _deleteNote({
    required int index,
  }) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('No notes yet!'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes[index]),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNoteScreen(note: _notes[index]),
                      ),
                    );
                    if (result != null) {
                      _addOrUpdateNote(
                        note: result,
                        index: index,
                      );
                    }
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteNote(
                        index: index,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
          if (result != null) {
            _addOrUpdateNote(
              note: result,
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
