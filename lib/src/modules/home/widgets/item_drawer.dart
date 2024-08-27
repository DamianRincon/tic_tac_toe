import "package:flutter/material.dart";

///
class ItemDrawer extends StatelessWidget {
  ///
  const ItemDrawer({
    required this.title,
    required this.icon,
    required this.isSelected,
    super.key,
    this.onPress,
  });

  ///
  final String title;

  ///
  final Widget icon;

  ///
  final bool isSelected;

  ///
  final Function()? onPress;

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black.withOpacity(0.2)
                      : Colors.white.withOpacity(0.2),
                )
              : null,
        ),
        child: ListTile(
          onTap: onPress,
          leading: icon,
          title: Text(title),
        ),
      );
}
