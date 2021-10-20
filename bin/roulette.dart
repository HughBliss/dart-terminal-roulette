import 'dart:io';

import 'constants.dart';

class Roulette {
  int _selected = 1;

  void _moveTop() {
    if (_selected == POSITIONS_COUNT) return;
    clear();
    _selected += 1;
    drawTable();
  }

  void _moveDown() {
    if (_selected == 1) return;
    clear();
    _selected -= 1;
    drawTable();
  }

  Future<void> init() async {
    drawTable();
    stdin.echoMode = false;
    stdin.lineMode = false;

    stdin.listen((data) {
      if (data[2] != null) {
        switch (data[2]) {
          case 65:
            _moveTop();
            break;
          case 66:
            _moveDown();
        }
      }
    });
  }

  void clear() {
    print(Process.runSync('clear', [], runInShell: true).stdout);
  }

  void drawTable() {
    _drawTopBorder();
    _drawRow(0);
    _drawTableSeparator();
    _drawRow(1);
    _drawTableSeparator();
    _drawRow(2);
    _drawBottomBorder();
    _drawTwelves();
  }

  void _drawTableSeparator() {
    var sep = '╟──';
    for (var i = 0; i < POSITIONS_COUNT ~/ 3 - 1; i++) {
      sep += '──┼──';
    }
    sep += '──╢';
    print(sep);
  }

  void _drawRow(int arg) {
    var row = '║';
    for (var i = 1; i <= POSITIONS_COUNT ~/ 3; i++) {
      final n = i * 3 - arg;
      row += (BLACK_LIST.contains(n) ? 'b' : 'w') +
          (_selected == n ? '▚' : ' ') +
          (n < 10 ? ' ' : '') +
          n.toString() +
          ((i != POSITIONS_COUNT ~/ 3) ? '│' : '');
    }
    row += '║';
    print(row);
  }

  void _drawTopBorder() {
    var topBorder = '╔══';

    for (var i = 0; i < POSITIONS_COUNT ~/ 3 - 1; i++) {
      topBorder += '══╤══';
    }

    topBorder += '══╗';

    print(topBorder);
  }

  void _drawBottomBorder() {
    var topBorder = '╠══';

    for (var i = 0; i < POSITIONS_COUNT ~/ 3 - 1; i++) {
      topBorder += (i + 1) % 4 == 0 ? '══╪══' : '══╧══';
    }

    topBorder += '══╣';

    print(topBorder);
  }

  void _drawTwelves() {
    var row = '║';
    row += ' first 12          ';
    row += '│';
    row += ' second 12         ';
    row += '│';
    row += ' third 12          ';
    row += '║';
    print(row);
  }
}
