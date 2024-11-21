import 'package:flutter/material.dart';

class NotePop extends StatelessWidget {
  final Function()? onEditTap;
  final Function()? onDelTap;

  const NotePop({super.key,
  required this.onEditTap,
  required this.onDelTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onEditTap!();
          },
          child: Text("Edit",style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),),
        ),
        const SizedBox(
          height: 7,
        ),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onEditTap!();
          },
          child: Text("Delete",style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),),
        ),
      ],
    );
  }
}