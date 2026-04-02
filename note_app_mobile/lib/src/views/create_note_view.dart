import 'package:flutter/material.dart';
import '../services/note_service.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';

class CreateNoteView extends StatefulWidget {
  final Note? note;
  const CreateNoteView({super.key, this.note});
  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final NoteService _noteService = NoteService();
  final Color backgroundColor = AppColors.backgroundColor;
  bool _isSaving = false;
  Note? _currentNote;
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _currentNote = widget.note;
    }
  }

  Future<void> _routeBackHome() async {
    bool success = await _saveNote();
    if (success && mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<bool> _saveNote() async {
    if (_isSaving) return false;
    String title = _titleController.text;
    String content = _contentController.text;
    if (title.isEmpty || content.isEmpty) return false;
    setState(() => _isSaving = true);
    try {
      bool success = false;
      if (_currentNote == null) {
        final created = await _noteService.createNote(title, content);
        if (created != null) {
          _currentNote = created;
          success = true;
        }
      } else {
        success = await _noteService.updateNote(
          _currentNote!.id,
          title,
          content,
        );
      }

      return success;
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          onPressed: _routeBackHome,
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Edit Notes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.notelyText,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.greyText),
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.notelyText),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Start typing...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.greyText),
                ),
                style: const TextStyle(color: AppColors.notelyText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
