import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';
import '../services/note_service.dart';
import '../views/create_note_view.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onRefresh;
  final NoteService noteService;
  final Function(Note) onLongPress;

  const NoteCard({
    super.key,
    required this.note,
    required this.onRefresh,
    required this.noteService,
    required this.onLongPress,
  });

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CreateNoteView(note: note), 
      ),
    );

    if (result == true) {
      onRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bo góc mềm mại
      ),
      color: AppColors.appWhite,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          _navigateToEdit(context);
        },
        onLongPress: () => onLongPress(note),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.notelyText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.notelyText,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
