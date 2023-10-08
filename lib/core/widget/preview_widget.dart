import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notes_snow/features/models/note_data.dart';
import 'package:provider/provider.dart';

class PreviewContainer extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  // final String content;
  final VoidCallback onTap;
  const PreviewContainer(
      {super.key,
      required this.title,
      // required this.content,
      required this.onTap,
      required this.color,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir',
              ),
            ),
            const Gap(8),
            Text(
              content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'Avenir',
              ),
            )
          ],
        ),
      ),
    );
  }
}
