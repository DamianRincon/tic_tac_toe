// ignore_for_file: constant_identifier_names

class GameUtil {
  static const PLAYER1 = 1;
  static const PLAYER2 = -1;

  static const DRAW = 2;
  static const NO_WINNER_YET = 0;
  static const EMPTY = 0;

  static const WIN_CONDITIONS_LIST = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  static int togglePlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }

  static bool isValidMove(List<int> board, int idx) => board[idx] == EMPTY;

  static int checkIfWinnerFound(List<int> board) {
    for (var list in WIN_CONDITIONS_LIST) {
      if (board[list[0]] != EMPTY &&
          board[list[0]] == board[list[1]] &&
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }
    if (isBoardFull(board)) {
      return DRAW;
    }
    return NO_WINNER_YET;
  }

  static bool checkWinner(List<int> board, int currentPlayer) {
    for (var pattern in WIN_CONDITIONS_LIST) {
      if (board[pattern[0]] == currentPlayer &&
          board[pattern[1]] == currentPlayer &&
          board[pattern[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  static bool isBoardFull(List<int> board) {
    for (var value in board) {
      if (value == EMPTY) return false;
    }
    return true;
  }
}
