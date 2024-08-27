import "package:flutter/widgets.dart";

///
class SectionTitle extends StatelessWidget {
  ///
  const SectionTitle({super.key, this.title = "Section Title"});

  ///
  final String title;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
