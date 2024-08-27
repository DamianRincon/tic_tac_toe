import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tic_tac_toe/src/modules/rules/controller/rules_controller.dart';

import '../../../core/widgets/section_content.dart';
import '../../../core/widgets/section_title.dart';

class RulesView extends GetView<RulesController> {
  const RulesView({super.key});
  @override
  String? get tag => rulesControllerTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // SectionTitle(title: "normal_mode".tr),
            SectionContent(
              content: <Widget>[
                Text("rules_player".tr),
                const Divider(),
                Text("rules_player_description".tr)
              ],
            ),
            const SizedBox(height: 10),
            SectionContent(
              content: <Widget>[
                Text("rules_turns".tr),
                const Divider(),
                Text("rules_turns_descriptions".tr)
              ],
            ),
            const SizedBox(height: 10),
            SectionContent(
              content: <Widget>[
                Text("rules_objective".tr),
                const Divider(),
                Text("rules_objective_descriptions".tr)
              ],
            ),
            const SizedBox(height: 10),
            SectionContent(
              content: <Widget>[
                Text("rules_win".tr),
                const Divider(),
                Text("rules_win_descriptions".tr)
              ],
            ),
            const SizedBox(height: 10),
            SectionContent(
              content: <Widget>[
                Text("rules_game_over".tr),
                const Divider(),
                Text("rules_game_over_descriptions".tr)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
