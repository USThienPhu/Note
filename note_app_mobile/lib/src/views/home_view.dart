import 'package:flutter/material.dart';
import '../widgets/note_card.dart';
import '../services/note_service.dart';
import '../models/note_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NoteService _noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ghi chú của Phú")),

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
