import 'package:flutter/material.dart';
import '../widgets/note_card.dart';
import '../services/note_service.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';
import '../widgets/empty_notes_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NoteService _noteService = NoteService();
  final Color backgroundColor = AppColors.backgroundColor;

  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    // 2. Gán giá trị cho biến ngay khi màn hình vừa khởi tạo
    // Lúc này API chỉ được gọi đúng 1 lần duy nhất
    _notesFuture = _noteService.fetchMyNote();
  }

  Widget _buildNoteList(List<Note> notes) {
    if (notes.isEmpty) {
      return const EmptyNotesWidget(); 
    }

    return RefreshIndicator(
      onRefresh: () async {
        _refreshNotes();
      },
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => NoteCard(note: notes[index]),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(String error) =>
      Center(child: Text("Đã xảy ra lỗi: $error"));

  void _refreshNotes() {
    setState(() {
      _notesFuture = _noteService.fetchMyNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
          ), // Hoặc Icons.arrow_back nếu là trang con
          onPressed: () {
            // Mở Drawer hoặc quay lại
          },
        ),
        title: const Text(
          "All Notes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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
          return _buildNoteList(notes);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.loginButtonColor,
          child: const Icon(Icons.add, color: AppColors.backgroundColor,),
      )
    );
  }
}
