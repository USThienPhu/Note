import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ActionBottomBar extends StatelessWidget {
  final VoidCallback handleDelete;

  const ActionBottomBar({
    super.key,
    required this.handleDelete,
  });


  @override
  Widget build(BuildContext context){
    return BottomAppBar(
      color: AppColors.backgroundColor,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.notelyText),
            onPressed: () {
              handleDelete();
            },
          ),
        ],
      ),
    );
  }
}
