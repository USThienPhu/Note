import 'package:flutter/material.dart';
import '../widgets/auth_header.dart';

class EmptyNotesWidget extends StatelessWidget {
  const EmptyNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Hình ảnh minh họa
            Image.asset(
              'assets/images/emty_note.png',
              width: 250,
            ),
            const SizedBox(height: 40),

            AuthHeader(
                title: "Create Your First Note",
                subtitle: "Add a note about anything (your thoughts on climate change, or your history essay) and share it with the world.",
              ),
          ],
        ),
      ),
    );
  }
}