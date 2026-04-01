import 'package:flutter/material.dart';
import '../services/note_service.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';
import '../widgets/home_list.dart';
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
    // 2. Gán giá trị cho biến ngay khi màn hình vừa khởi tạo
    // Lúc này API chỉ được gọi đúng 1 lần duy nhất
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

  Widget _buildActionBottomAppBar() {
    return BottomAppBar(
      color: AppColors.backgroundColor,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.notelyText),
            onPressed: () {
              // Gọi logic xác nhận xóa ở đây (Phú có thể mang hàm _confirmDelete sang HomeView)
              _handleDeleteNote();
            },
          ),
        ],
      ),
    );
  }

  void _handleDeleteNote() async {
    if (_selectedNote == null) return;

    // Phú có thể hiện AlertDialog xác nhận ở đây
    final success = await _noteService.deleteNote(_selectedNote!.id);
    if (success) {
      _cancelSelection(); // Thoát chế độ chọn
      _refreshNotes(); // Load lại danh sách
    }
  }

  // Widget _buildNoteList(List<Note> notes) {
  //   if (notes.isEmpty) {
  //     return const EmptyNotesWidget();
  //   }

  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       _refreshNotes();
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //       child: MasonryGridView.count(
  //         crossAxisCount: 2, // Chia làm 2 cột như hình mẫu của Phú
  //         mainAxisSpacing: 10, // Khoảng cách dọc giữa các card
  //         crossAxisSpacing: 10, // Khoảng cách ngang giữa các cột
  //         itemCount: notes.length,
  //         itemBuilder: (context, index) {
  //           return NoteCard(
  //             note: notes[index],
  //             onRefresh: _refreshNotes,
  //             noteService: _noteService,
  //             onLongPress: _onNoteLongPress,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNormalBottomAppBar() {
    return BottomAppBar(
      color: AppColors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.file_copy, color: AppColors.notelyText),
            onPressed: () {},
          ),
        ],
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
          ? _buildNormalBottomAppBar() // Footer bình thường của Phú
          : _buildActionBottomAppBar(), // Thanh tác vụ xóa

      floatingActionButton: FloatingActionButton(
        onPressed: _createNote,
        backgroundColor: AppColors.loginButtonColor,
        child: const Icon(Icons.add, color: AppColors.backgroundColor),
      ),
    );
  }
}
