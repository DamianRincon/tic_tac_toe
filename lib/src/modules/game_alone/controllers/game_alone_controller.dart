import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/src/core/data/preferences.dart';
import 'package:tic_tac_toe/src/core/utils/app_info.dart';

import '../utils/game_ia.dart';
import '../utils/game_utils.dart';

const String gameAloneControllerTag = "home_controller_tag";

class GameAloneController extends GetxController {
  var player1Win = 0.obs;
  var player2Win = 0.obs;
  var draw = 0.obs;

  RxBool isMultiPlayer = false.obs;
  RxList<int> board = List.generate(9, (index) => 0).obs;
  RxInt currentPlayer = GameUtil.PLAYER1.obs;
  RxInt gameResult = GameUtil.NO_WINNER_YET.obs;
  RxBool isAiPlaying = false.obs;
  GameAI ai = GameAI();
  AdManagerBannerAd? bannerAd;
  Key boardKey = UniqueKey();
  Preferences preferences = Preferences();
  User? currentUser = FirebaseAuth.instance.currentUser;
  RxString level = "".obs;

  @override
  void onInit() {
    isMultiPlayer(Get.arguments["multiplayer"]);
    level(Get.arguments["level"]);
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

  void reinitialize() {
    boardKey = UniqueKey();
    board.value = List.generate(9, (index) => 0);
    gameResult.value = GameUtil.NO_WINNER_YET;
    currentPlayer.value = GameUtil.PLAYER1;
  }

  Future<void> move(int idx) async {
    board[idx] = currentPlayer.value;

    checkGameWinner();
    togglePlayer();
    if (!isMultiPlayer.value && gameResult.value == GameUtil.NO_WINNER_YET) {
      isAiPlaying.value = true;
      await Future.delayed(const Duration(milliseconds: 600));

      final aiMove = await Future(
        () => ai.makeComputerMove(
          board,
          currentPlayer.value,
          level.value,
        ),
      );

      board[aiMove] = currentPlayer.value;
      isAiPlaying.value = false;
      checkGameWinner();
      togglePlayer();
    }
  }

  bool isEnable(int idx) => board[idx] == GameUtil.EMPTY;

  int getDataAt(int idx) => board[idx];

  void togglePlayer() {
    currentPlayer.value = GameUtil.togglePlayer(currentPlayer.value);
  }

  void checkGameWinner() {
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

  String? get currentPlayerMove {
    if (currentPlayer.value == GameUtil.PLAYER1) {
      return isMultiPlayer.value ? "player1".tr : "you_move".tr;
    } else if (currentPlayer.value == GameUtil.PLAYER2) {
      return isMultiPlayer.value ? "player2".tr : "player_bot".tr;
    }
    return null;
  }

  String? get gameResultStatus {
    final _gameResult = gameResult.value;
    if (_gameResult != GameUtil.NO_WINNER_YET) {
      if (_gameResult == GameUtil.PLAYER1) {
        return "player1".tr;
      } else if (_gameResult == GameUtil.PLAYER2) {
        return isMultiPlayer.value ? "player2".tr : "bot".tr;
      } else if (_gameResult == GameUtil.DRAW) {
        return "draws".tr;
      }
    }
    return null;
  }
}
