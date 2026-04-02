import 'package:flutter/material.dart';
import '../services/note_service.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';
import '../widgets/home_list.dart';
import '../widgets/action_bottom_appbar.dart';
import '../widgets/normal_bottom_appbar.dart';
import './create_note_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NoteService _noteService = NoteService();
  final Color backgroundColor = AppColors.backgroundColor;
  late Future<List<Note>> _notesFuture;
  Note? _selectedNote;
  @override
  void initState() {
    super.initState();
    _notesFuture = _noteService.fetchMyNote();
  }

  void _onNoteLongPress(Note note) {
    setState(() {
      _selectedNote = note;
    });
  }

  void _cancelSelection() {
    setState(() {
      _selectedNote = null;
    });
  }

  void _handleDeleteNote() async {
    if (_selectedNote == null) return;

    final success = await _noteService.deleteNote(_selectedNote!.id);
    if (success) {
      _cancelSelection();
      _refreshNotes();
    } else {
      print("DEBIG: deletion fail");
    }
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(String error) =>
      Center(child: Text("Đã xảy ra lỗi: $error"));

  void _refreshNotes() {
    setState(() {
      _notesFuture = _noteService.fetchMyNote();
    });
  }

  void _createNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNoteView()),
    );

    if (result == true) {
      _refreshNotes();
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
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
        title: const Text(
          "All Notes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              print("Mở tìm kiếm");
            },
          ),
        ],

        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.notelyText,
      ),

      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }

          if (snapshot.hasError) return _buildError(snapshot.error.toString());

          final notes = snapshot.data ?? [];
          return HomeList(
            notes: notes,
            onRefresh: _refreshNotes,
            noteService: _noteService,
            onLongPress: _onNoteLongPress,
          );
        },
      ),

      bottomNavigationBar: _selectedNote == null
          ? NormalBottomBar() // Footer bình thường của Phú
          : ActionBottomBar(
              handleDelete: _handleDeleteNote,
            ), // Thanh tác vụ xóa

      floatingActionButton: FloatingActionButton(
        onPressed: _createNote,
        backgroundColor: AppColors.loginButtonColor,
        child: const Icon(Icons.add, color: AppColors.backgroundColor),
      ),
    );
  }
}
