import "dart:io";
import "dart:math" as math;

import "package:flutter/material.dart";

import "../../../core/common/colors.dart";

///
class CustomNavigatorBar extends StatelessWidget {
  ///
  const CustomNavigatorBar({
    required this.itemIcons,
    required this.centerIcon,
    required this.selectedIndex,
    required this.onItemPressed,
    required this.selectedIcons,
    Key? key,
    this.height,
    this.selectedColor = const Color(0xff46BDFA),
    this.unselectedColor = const Color(0xffB5C8E7),
    this.selectedLightColor = const Color(0xff77E2FE),
  })  : assert(itemIcons.length == 4 || itemIcons.length == 2,
            "Item must equal 4 or 2"),
        super(key: key);

  ///
  final List<IconData> itemIcons;

  ///
  final List<IconData> selectedIcons;

  ///
  final IconData centerIcon;

  ///
  final int selectedIndex;

  ///
  final Function(int) onItemPressed;

  ///
  final double? height;

  ///
  final Color selectedColor;

  ///
  final Color selectedLightColor;

  ///
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    final double height = this.height ?? getRelativeHeight(0.076);

    return Container(
      color: Colors.transparent,
      height: height + getRelativeHeight(0.025),
      child: Stack(
        children: <Widget>[
          Align(
            alignment:
                Platform.isAndroid ? Alignment.bottomCenter : Alignment.center,
            child: Container(
              height: height,
              color: Colors.transparent,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getRelativeWidth(0.07)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  selectedIndex == 0
                                      ? selectedIcons[0]
                                      : itemIcons[0],
                                  color: selectedIndex == 0
                                      ? selectedColor
                                      : unselectedColor,
                                ),
                              ),
                            ),
                          ),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    itemIcons[1],
                                    color: selectedIndex == 1
                                        ? selectedColor
                                        : unselectedColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(itemIcons.length == 4 ? 3 : 2);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  itemIcons[itemIcons.length == 4 ? 2 : 1],
                                  color: selectedIndex ==
                                          (itemIcons.length == 4 ? 3 : 2)
                                      ? selectedColor
                                      : unselectedColor,
                                ),
                              ),
                            ),
                          ),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(4);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    itemIcons[3],
                                    color: selectedIndex == 4
                                        ? selectedColor
                                        : unselectedColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      onItemPressed(itemIcons.length == 4 ? 2 : 1);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 25,
                            offset: Offset(0, 5),
                            color: MColors.secondary,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            MColors.primary,
                            MColors.primaryContainer,
                          ],
                        ),
                      ),
                      height: getDiamondSize(),
                      width: getDiamondSize(),
                      child: Center(
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Icon(
                            centerIcon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: avoid_classes_with_only_static_members
///
class SizeConfig {
  ///
  static double screenWidth = 0;

  ///
  static double screenHeight = 0;

  ///
  static void initSize(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

///
double getRelativeHeight(double percentage) =>
    percentage * SizeConfig.screenHeight;

///
double getRelativeWidth(double percentage) =>
    percentage * SizeConfig.screenWidth;

///
double getDiamondSize() {
  final double width = SizeConfig.screenWidth;
  if (width > 1000) {
    return 0.045 * SizeConfig.screenWidth;
  } else if (width > 900) {
    return 0.055 * SizeConfig.screenWidth;
  } else if (width > 700) {
    return 0.065 * SizeConfig.screenWidth;
  } else if (width > 500) {
    return 0.075 * SizeConfig.screenWidth;
  } else {
    return 0.135 * SizeConfig.screenWidth;
  }
}
