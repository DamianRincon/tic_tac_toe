// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'game_utils.dart';

class GameAI {
  static const WIN_SCORE = 100;
  static const LOSE_SCORE = -100;
  static const DRAW_SCORE = 0;

  /*int play(List<int> board, int currentPlayer) {
    return _getAIMove(board, currentPlayer).move;
  }*/

  int makeComputerMove(List<int> board, int currentPlayer, String level) {
    switch (level) {
      case "easy":
        return getRandomMove(board);
      case "medium":
        return getMediumMove(board, currentPlayer);
      case "hard_core":
        return _getAIMove(board, currentPlayer).move;
      default:
        return _getAIMove(board, currentPlayer).move;
    }
  }

  Move _getAIMove(List<int> board, int currentPlayer) {
    List<int> _newBoard;
    Move _bestMove = Move(score: -10000, move: -1);

    for (int currentMove = 0; currentMove < board.length; currentMove++) {
      if (!GameUtil.isValidMove(board, currentMove)) continue;
      _newBoard = List.from(board);
      _newBoard[currentMove] = currentPlayer;
      int _newScore = -_getBestScore(
        _newBoard,
        GameUtil.togglePlayer(currentPlayer),
      );
      if (_newScore > _bestMove.score) {
        _bestMove.score = _newScore;
        _bestMove.move = currentMove;
      }
    }

    return _bestMove;
  }

  int _getBestScore(List<int> board, int currentPlayer) {
    final _winner = GameUtil.checkIfWinnerFound(board);
    if (_winner == currentPlayer) {
      return WIN_SCORE;
    } else if (_winner == GameUtil.togglePlayer(currentPlayer)) {
      return LOSE_SCORE;
    } else if (_winner == GameUtil.DRAW) {
      return DRAW_SCORE;
    }
    return _getAIMove(board, currentPlayer).score;
  }

  int getRandomMove(List<int> board) {
    print("XXX: GET RANDOM MOVE");
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == 0) {
        availableMoves.add(i);
      }
    }
    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  int getMediumMove(List<int> board, int currentPlayer) {
    // Intentar ganar
    for (int i = 0; i < 9; i++) {
      if (board[i] == 0) {
        board[i] = GameUtil.PLAYER2;
        if (GameUtil.checkWinner(board, GameUtil.PLAYER2)) {
          board[i] = 0;
          print("XXX: Intentar ganar");
          return i;
        }

        board[i] = 0;
      }
    }
    // Bloquear al jugador
    for (int i = 0; i < 9; i++) {
      if (board[i] == 0) {
        board[i] = GameUtil.PLAYER1;
        if (GameUtil.checkWinner(board, GameUtil.PLAYER1)) {
          board[i] = 0;
          print("XXX: Bloquear al jugador");
          return i;
        }

        board[i] = 0;
      }
    }
    return getRandomMove(board);
  }
}

class Move {
  int score;
  int move;

  Move({
    required this.score,
    required this.move,
  });
}
