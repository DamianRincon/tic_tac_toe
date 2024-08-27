import "package:flutter/material.dart";

///
class CustomButtonAO extends StatelessWidget {
  ///
  const CustomButtonAO({
    required this.title,
    required this.icon,
    this.width,
    this.onPressed,
    super.key,
  });

  ///
  final String title;

  ///
  final Widget icon;

  ///
  final double? width;

  ///
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                icon,
                const SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
