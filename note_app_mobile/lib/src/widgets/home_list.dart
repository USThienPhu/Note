import 'package:flutter/material.dart';
import '../services/note_service.dart';
import './empty_notes_widget.dart';
import './note_card.dart';
import '../models/note_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeList extends StatelessWidget {
  final List<Note> notes;
  final VoidCallback onRefresh;
  final Function(Note) onLongPress;
  final NoteService noteService;

  const HomeList({
    super.key,
    required this.notes,
    required this.onRefresh,
    required this.noteService,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const EmptyNotesWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: MasonryGridView.count(
          crossAxisCount: 2, 
          mainAxisSpacing: 10, 
          crossAxisSpacing: 10,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteCard(
              note: notes[index],
              onRefresh: onRefresh,
              noteService: noteService,
              onLongPress: onLongPress,
            );
          },
        ),
      ),
    );
  }
}
