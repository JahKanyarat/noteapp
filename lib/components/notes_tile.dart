import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hw5_noteapp/components/note_pop.dart';
import 'package:popover/popover.dart';

class NotesTile extends StatelessWidget {
  final String text;
  final void Function()? onEdtPressed;
  final void Function()? onDelPreesed;

  NotesTile({
    super.key,
    required this.text,
    required this.onEdtPressed,
    required this.onDelPreesed,
  });

  final List<Color> colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    // เลือกสีพื้นหลังแบบสุ่ม
    final backgroundColor = colors[Random().nextInt(colors.length)];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // ใช้สีพื้นหลังแบบสุ่ม
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            onPressed: () => showPopover(
              context: context,
              bodyBuilder: (context) => NotePop(
                onEditTap: onEdtPressed,
                onDelTap: onDelPreesed,
              ),
              width: 100,
              height: 100,
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
