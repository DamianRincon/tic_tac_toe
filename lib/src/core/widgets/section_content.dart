import "package:flutter/material.dart";

import "../common/colors.dart";

///
class SectionContent extends StatelessWidget {
  ///
  const SectionContent({required this.content, super.key});

  ///
  final List<Widget> content;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MColors.primaryContainer.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
      );
}
