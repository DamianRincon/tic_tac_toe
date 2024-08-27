import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:icons_plus/icons_plus.dart";
import 'package:country_picker/country_picker.dart';
import "package:tic_tac_toe/src/core/translate/suported.dart";
import "package:tic_tac_toe/src/modules/settings/view/profile_view.dart";

import "../../../core/utils/decode_emoji.dart";
import "../controllers/settings_controller.dart";
import "../widgets/menu_option.dart";
import "../../../core/widgets/section_content.dart";
import "../../../core/widgets/section_title.dart";

///
class SettingsView extends GetView<SettingsController> {
  ///
  const SettingsView({super.key});
  @override
  String? get tag => settingsControllerTag;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          width: Get.width,
          child: Center(
            child: InkWell(
              onTap: () async {
                FirebaseAuth.instance.signOut();
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "close_session".tr,
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(controller.title),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: controller.currentUser?.photoURL != null &&
                        controller.currentUser?.photoURL != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(controller.currentUser!.photoURL!),
                      )
                    : const SizedBox(width: 30, height: 30),
                title: Text("${controller.currentUser?.displayName}"),
                subtitle: Text("${controller.currentUser?.email}"),
              ),
              /*ListTile(
                onTap: () => Get.to(() => ProfileView()),
                title: Text("Cambiar mi nombre"),
                trailing: const Icon(BoxIcons.bx_chevron_right),
              ),
              ListTile(
                onTap: () => Get.to(() => ProfileView()),
                title: Text("Cambiar mi avatar"),
                trailing: const Icon(BoxIcons.bx_chevron_right),
              ),
              Divider(),*/
              SectionTitle(title: "sections_custom".tr),
              SectionContent(
                content: <Widget>[
                  Text("subtitle_custom".tr),
                  const Divider(),
                  Obx(
                    () => Center(
                      child: CupertinoSlidingSegmentedControl<String>(
                        groupValue: controller.theme.value,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.transparent,
                        children: <String, Widget>{
                          for (final MenuOptionsModel option
                              in controller.themeOptions())
                            option.key: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(option.icon),
                                const SizedBox(width: 6),
                                Text(option.value),
                              ],
                            )
                        },
                        onValueChanged: (String? v) =>
                            controller.changeTheme(v),
                      ),
                    ),
                  ),
                ],
              ),
              SectionTitle(title: "sections_general".tr),
              SectionContent(
                content: <Widget>[
                  Text("subtitle_general".tr),
                  const Divider(),
                  ListTile(
                      leading: Obx(
                        () => IconButton(
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              favorite: <String>['MX'],
                              showPhoneCode: false,
                              showWorldWide: true,
                              onSelect: (Country country) =>
                                  controller.changeFlag(
                                country.iswWorldWide
                                    ? Utils.defaultIcon
                                    : country.countryCode,
                              ),
                              moveAlongWithKeyboard: false,
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'search'.tr,
                                  hintText: 'search_hint'.tr,
                                  prefixIcon: const Icon(
                                    AntDesign.search_outline,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: Utils.emojiText(controller.flagUser.value),
                        ),
                      ),
                      title: Obx(() => dropDown()))
                ],
              ),
            ],
          ),
        ),
      );

  Widget dropDown() => DropdownButtonHideUnderline(
        child: DropdownButton(
          value: controller.languajeUser.value,
          icon: const Icon(Icons.arrow_drop_down_outlined),
          items: suportedLangajes.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items.tr),
            );
          }).toList(),
          onChanged: controller.changeLanguaje,
        ),
      );
}
