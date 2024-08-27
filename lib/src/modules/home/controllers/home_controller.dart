import "dart:math";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:tic_tac_toe/src/core/common/constants_key.dart";
import "package:tic_tac_toe/src/core/data/preferences.dart";
import "package:tic_tac_toe/src/core/routes/routes.dart";
import "package:tic_tac_toe/src/modules/home/widgets/online/alone_leves.dart";
import "package:url_launcher/url_launcher.dart";
import 'package:loader_overlay/loader_overlay.dart';

import "../../../core/data/data_manager.dart";
import "../../game_alone/utils/game_utils.dart";

///
const String homeControllerTag = "home_controller_tag";

///
class HomeController extends GetxController {
  ///
  RxString user = "".obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString myRoom = "".obs;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final Preferences _preferences = Preferences();

  ///
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxString titlePage = "overview".tr.obs;
  RxString greetUser = "good_morning".tr.obs;
  RxInt playerSelected = GameUtil.PLAYER1.obs;
  RxInt step = 0.obs;
  RxBool joinToRoom = false.obs;
  RxString roomID = "".obs;

  /// Open Drawer
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  /// Close Drawer
  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  /// Cambiar el nombre de la vista
  void changeTitle(int page) {
    switch (page) {
      case 0:
        titlePage("overview".tr);
        break;
      default:
        titlePage("overview".tr);
    }
  }

  ///
  void sayHello() {
    final int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      greetUser("good_morning".tr);
    } else if (hour >= 12 && hour < 18) {
      greetUser("good_afternoon".tr);
    } else {
      greetUser("good_evening".tr);
    }
  }

  @override
  void onReady() {
    db();
    super.onReady();
  }

  Future<void> db() async {
    await SharedManager().init();
  }

  @override
  void onInit() {
    sayHello();

    super.onInit();
  }

  Future<void> payAloneGame() async {
    showDialog<void>(
      context: Get.context!,
      useSafeArea: false,
      builder: (BuildContext context) {
        return SelectLevel(
          selectLevel: (level) => Get.toNamed(Routes.gameAlone,
              arguments: {"multiplayer": false, "level": level}),
        );
      },
    );
  }

  Future<void> payWithFriends() async {
    Get.toNamed(Routes.gameAlone, arguments: {"multiplayer": true});
  }

  Future<void> payWithFriendsOnline() async {
    List<int> players = [GameUtil.PLAYER1, GameUtil.PLAYER2];
    playerSelected.value = players[Random().nextInt(players.length)];
    searchGame();
  }

  Future<void> searchGame() async {
    print("SEARCH GAME");
    Get.context!.loaderOverlay.show();

    final allResults = await firestore.collection(DATABASE).get();
    int index = 0;
    if (allResults.size > 0) {
      for (var doc in allResults.docs) {
        Map<String, dynamic> gameData = doc.data();
        index++;
        if (gameData["status"] == "waiting" &&
            validateTime(gameData["create_at"])) {
          isAvalidRoom(gameData, doc.id);
        }
      }
      if (index >= allResults.docs.length - 1) {
        await prepareGame();
      }
    } else {
      await prepareGame();
    }
  }

  void isAvalidRoom(Map<String, dynamic> gameData, String idRoom) {
    print("IS VALID ROOM");
    String userID = currentUser?.uid ?? "";

    if (gameData["create_for"] != userID) {
      int? player1 = gameData["player1_choose"];
      int? player2 = gameData["player2_choose"];

      if (player1 == null) {
        print("Usuario 1");
        Map<String, dynamic> joinData = {
          'player1': currentUser?.uid,
          'player1_choose': playerSelected.value,
          "player1_name": currentUser?.displayName,
          "player1_flag": _preferences.flagForUser,
          'status': 'online',
        };
        joinToGame(joinData, idRoom);
      }
      if (player2 == null) {
        print("Usuario 2");
        Map<String, dynamic> joinData = {
          'player2': currentUser?.uid,
          'player2_choose': playerSelected.value,
          "player2_name": currentUser?.displayName,
          "player2_flag": _preferences.flagForUser,
          'status': 'online',
        };
        joinToGame(joinData, idRoom);
      }
    } else {
      print("NO existe partida disponible 2");
      prepareGame();
    }
  }

  bool validateTime(String date) {
    print("VALIDATE TIME");
    DateTime createAt = DateTime.parse(date);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createAt);
    print("VALIDATE TIME ${difference.inSeconds}");
    return difference.inSeconds < 60;
  }

  Future<void> prepareGame() async {
    print("PREPARE GAME");
    final board = List.generate(9, (index) => 0);
    print("I'M SELECTED ${playerSelected.value}}");
    ;
    Map<String, dynamic> prepareGame = {};
    if (playerSelected.value == GameUtil.PLAYER1) {
      prepareGame = {
        'player1': currentUser?.uid,
        'player1_choose': playerSelected.value,
        "player1_name": currentUser?.displayName,
        "player1_flag": _preferences.flagForUser,
        'player2': null,
        'player2_choose': null,
        "player2_name": null,
        'board': board,
        'currentPlayer': GameUtil.PLAYER1,
        'status': 'waiting',
        'create_at': DateTime.now().toString(),
        'create_for': currentUser?.uid ?? "",
      };
    } else {
      prepareGame = {
        'player1': null,
        'player1_choose': null,
        "player1_name": null,
        "player1_flag": null,
        'player2': currentUser?.uid,
        'player2_choose': playerSelected.value,
        "player2_name": currentUser?.displayName,
        "player2_flag": _preferences.flagForUser,
        'board': board,
        'currentPlayer': GameUtil.PLAYER1,
        'status': 'waiting',
        'create_at': DateTime.now().toString(),
        'create_for': currentUser?.uid ?? "",
      };
    }

    print(prepareGame);

    DocumentReference roomRef =
        await firestore.collection(DATABASE).add(prepareGame);
    roomRef.id;
    myRoom(roomRef.id);
    await Get.toNamed(Routes.gameGroup, arguments: {
      "room": roomRef.id,
      "selectedPlayer": playerSelected.value,
    });
  }

  Future<void> joinToGame(Map<String, dynamic> data, String roomID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection(DATABASE).doc(roomID).update(data);

    await Get.toNamed(Routes.gameGroup, arguments: {
      "room": roomID,
      "selectedPlayer": playerSelected.value,
    });
  }

  ///
  Future<void> launcherURL(String url) async {
    final Uri uri = Uri.parse(url);
    final bool isValidURL = await canLaunchUrl(uri);
    if (isValidURL) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
