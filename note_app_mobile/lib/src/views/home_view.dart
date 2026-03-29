import 'package:flutter/material.dart';
import '../widgets/note_card.dart';
import '../services/note_service.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NoteService _noteService = NoteService();
  final Color backgroundColor = AppColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80, 
        centerTitle: true, 
        leading: IconButton(
          icon: const Icon(Icons.menu), // Hoặc Icons.arrow_back nếu là trang con
          onPressed: () {
            // Mở Drawer hoặc quay lại
          },
        ),
        title: const Text(
          "All Notes",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("Mở tìm kiếm");
            },
          ),
          // Tạo khoảng trống sát mép phải
        ],
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.notelyText,
      ),

      body: FutureBuilder<List<Note>>(
        future: _noteService.featchMyNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Đã xảy ra lỗi: ${snapshot.error}"));
          }

          final notes = snapshot.data ?? [];
          if (notes.isEmpty) {
            return const Center(child: Text("Bạn chưa có ghi chú nào."));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(note: notes[index]); // Gọi widget đã tách riêng
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* Logic thêm Note */
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
