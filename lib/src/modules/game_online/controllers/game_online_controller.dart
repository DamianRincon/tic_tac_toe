import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/common/constants_key.dart';
import '../../../core/utils/app_info.dart';
import '../../game_alone/utils/game_utils.dart';

const String gameOnlineControllerTag = "home_controller_tag";

class GameOnlineController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;

  /// Tablero
  RxList<int> board = List.generate(9, (index) => 0).obs;
  bool isEnable(int idx) => board[idx] == GameUtil.EMPTY;
  int getDataAt(int idx) => board[idx];

  RxInt currentPlayer = GameUtil.PLAYER1.obs;

  RxInt mySelectionPlayer = 0.obs;

  String? get currentPlayerMove {
    if (currentPlayer.value == GameUtil.PLAYER1) {
      return (currentPlayer.value == mySelectionPlayer.value)
          ? "you_move".tr
          : player1Name.value;
    } else if (currentPlayer.value == GameUtil.PLAYER2) {
      return (currentPlayer.value == mySelectionPlayer.value)
          ? "you_move".tr
          : player2Name.value;
    }
    return null;
  }

  RxString myRoom = "".obs;

  RxInt player1SelectedGame = 0.obs;
  RxInt player2SelectedGame = 0.obs;
  RxInt currentPlayerGame = 0.obs;

  RxString player1Name = "".obs;
  RxString player2Name = "".obs;

  RxString player1Flag = "".obs;
  RxString player2Flag = "".obs;

  AdManagerBannerAd? bannerAd;

  /// DATA OF PLAY
  var player1Win = 0.obs;
  var player2Win = 0.obs;
  var draw = 0.obs;

  RxInt gameResult = GameUtil.NO_WINNER_YET.obs;
  late DocumentReference gameRef;
  RxInt imPlayer = 0.obs;
  Key boardKey = UniqueKey();

  @override
  void onInit() {
    myRoom(Get.arguments["room"]);
    mySelectionPlayer(Get.arguments["selectedPlayer"]);
    gameRef = firestore.collection(DATABASE).doc(myRoom.value);
    loadAdBanner();
    super.onInit();
  }

  @override
  void onReady() {
    bannerAd?.load();
    super.onReady();
  }

  ///
  Future<void> loadAdBanner() async {
    bannerAd = AdManagerBannerAd(
      // adUnitId: adUnitId,
      request: const AdManagerAdRequest(),
      sizes: <AdSize>[AdSize.banner],
      listener: AdManagerBannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          //debugPrint("$ad loaded.");
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          //debugPrint("AdManagerBannerAd failed to load: $err");
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
      adUnitId: AppInfo.keyBanner!,
      // ignore: unawaited_futures
    )..load();
  }

  void validateData(Map<String, dynamic> gameData) {
    currentPlayer.value = gameData["currentPlayer"];
    player1SelectedGame.value = gameData["player1_choose"] ?? 0;
    player2SelectedGame.value = gameData["player2_choose"] ?? 0;

    player1Name.value = gameData["player1_name"].toString().split(" ")[0];
    player2Name.value = gameData["player2_name"].toString().split(" ")[0];

    player1Flag.value = gameData["player1_flag"] ?? "\uD83C\uDF0D";
    player2Flag.value = gameData["player2_flag"] ?? "\uD83C\uDF0D";
  }

  bool myTourn() {
    return currentPlayer.value == mySelectionPlayer.value;
  }

  void reinitialize() async {
    gameResult.value = GameUtil.NO_WINNER_YET;
    boardKey = UniqueKey();
    DocumentSnapshot gameSnapshot = await gameRef.get();
    if (gameSnapshot.exists) {
      await gameRef.update({
        'board': List.generate(9, (index) => 0),
        'currentPlayer': GameUtil.PLAYER1,
      });
    }
  }

  String? get gameResultStatus {
    if (gameResult.value != GameUtil.NO_WINNER_YET) {
      if (gameResult.value == GameUtil.PLAYER1) {
        return "${'won'.tr}\n${player1Name.value}";
      } else if (gameResult.value == GameUtil.PLAYER2) {
        return "${'won'.tr}\n${player2Name.value}";
      } else if (gameResult.value == GameUtil.DRAW) {
        return "draws".tr;
      }
    }
    return null;
  }

  void makeMove(int idx) async {
    print("PREPARE makeMove $idx");
    DocumentSnapshot gameSnapshot = await gameRef.get();

    if (gameSnapshot.exists) {
      print("PREPARE makeMove XXXX");
      if (myTourn() && isEnable(idx) && getDataAt(idx) == 0) {
        print("PREPARE makeMove XXX");
        board[idx] = currentPlayer.value;
        togglePlayer();
        await gameRef.update({
          'board': board,
        });
      }
    }
  }

  void togglePlayer() async {
    currentPlayer.value = GameUtil.togglePlayer(currentPlayer.value);
    await gameRef.update({
      'currentPlayer': currentPlayer.value,
    });
  }

  void gameOver() async {
    print("GAME OVER");
    gameResult.value = GameUtil.NO_WINNER_YET;
    DocumentSnapshot gameSnapshot = await gameRef.get();
    if (gameSnapshot.exists) {
      await gameRef.update({
        'board': List.generate(9, (index) => 0),
        'currentPlayer': GameUtil.PLAYER1,
        'status': 'game_over',
        'wins_player1': player1Win.value,
        'wins_player2': player2Win.value,
        'draws': draw.value,
      });
      Get.back();
    }
  }

  void exit() async {
    await gameRef.update({'status': 'game_over'});
    Get.back();
  }

  void checkGameWinner() async {
    gameResult.value = GameUtil.checkIfWinnerFound(board);
    switch (gameResult.value) {
      case GameUtil.PLAYER1:
        player1Win++;
        break;
      case GameUtil.PLAYER2:
        player2Win++;
        break;
      case GameUtil.DRAW:
        draw++;
        break;
    }
  }
}
