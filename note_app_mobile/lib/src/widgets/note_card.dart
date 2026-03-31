import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../utils/app_colors.dart';
import '../services/note_service.dart';
import '../views/create_note_view.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onRefresh;
  final NoteService noteService;

  const NoteCard({super.key, required this.note, required this.onRefresh, required this.noteService});

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CreateNoteView(note: note), // Truyền dữ liệu note qua đây
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
        onLongPress: () => _showActionSheet(context),
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

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Để footer cao vừa đủ nội dung
            children: [
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Xóa ghi chú',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context); // Đóng footer trước
                  _confirmDelete(context); // Hiện hộp thoại xác nhận
                },
              ),
              // Phú có thể thêm các nút khác như "Chia sẻ", "Lưu trữ" ở đây
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận xóa?"),
        content: const Text("Ghi chú này sẽ bị xóa vĩnh viễn."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final success = await noteService.deleteNote(note.id);
              if (success && context.mounted) {
                Navigator.pop(context); // Đóng Dialog
                onRefresh(); // Gọi callback để HomeView load lại danh sách!
              }
            },
            child: const Text("Xóa", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
