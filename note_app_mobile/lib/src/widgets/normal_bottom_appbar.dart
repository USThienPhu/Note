import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class NormalBottomBar extends StatelessWidget {

  const NormalBottomBar({super.key, });


  @override
  Widget build(BuildContext context){
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
}
