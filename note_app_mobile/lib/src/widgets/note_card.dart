import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';
import '../views/create_note_view.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CreateNoteView(note: note), // Truyền dữ liệu note qua đây
      ),
    );

    // Nếu sau khi Edit mà có lưu thành công, báo cho HomeView load lại
    if (result == true) {
      // Có thể dùng callback hoặc Provider để báo HomeView refresh
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
                // Bỏ maxLines hoặc để số lớn để card tự nở theo chiều dài văn bản
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.notelyText,
                  height: 1.3, // Tăng khoảng cách dòng cho thoáng
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
