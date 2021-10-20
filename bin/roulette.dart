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
    if (_selected == -7) return;
    clear();
    _selected -= 1;
    drawTable();
  }

  Future<void> init() async {
    clear();
    drawTable();
    stdin.echoMode = false;
    stdin.lineMode = false;

    stdin.listen((data) {
      if (data.length > 2) {
        switch (data[2]) {
          case 65:
            _moveTop();
            break;
          case 66:
            _moveDown();
            break;
          default:
            break;
        }
      }
      print(String.fromCharCodes(data));
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
    _drawTableBorder();
    _drawTwelves();
    _drawTwelvesBorder();
    _drawAdditional();
    _drawAdditionalBorder();
    _drawZero();
    _drawBottomBorder();
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
      row += (BLACK_LIST.contains(n) ? 'b' : 'r') +
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

  void _drawTableBorder() {
    var topBorder = '╠══';

    for (var i = 0; i < POSITIONS_COUNT ~/ 3 - 1; i++) {
      topBorder += (i + 1) % 4 == 0 ? '══╪══' : '══╧══';
    }

    topBorder += '══╣';

    print(topBorder);
  }

  void _drawTwelves() {
    var row = '║';
    row += ' first 12        ' + (_selected == -1 ? '▚ ' : '  ');
    row += '│';
    row += ' second 12       ' + (_selected == -2 ? '▚ ' : '  ');
    row += '│';
    row += ' third 12        ' + (_selected == -3 ? '▚ ' : '  ');
    row += '║';
    print(row);
  }

  void _drawAdditional() {
    var row = '║';
    row += ' Odd        ' + (_selected == -4 ? '▚ ' : '  ');
    row += '│';
    row += ' Even       ' + (_selected == -5 ? '▚ ' : '  ');
    row += '│';
    row += ' Black      ' + (_selected == -6 ? '▚ ' : '  ');
    row += '│';
    row += ' Red        ' + (_selected == -7 ? '▚ ' : '  ');
    row += '║';
    print(row);
  }

  void _drawTwelvesBorder() {
    var border = '╠══';

    for (var i = 0; i < POSITIONS_COUNT ~/ 3 - 1; i++) {
      border += (i + 1) % 4 == 0
          ? '══╧══'
          : (i + 1) % 3 == 0
              ? '══╤══'
              : '═════';
    }

    border += '══╣';

    print(border);
  }

  void _drawAdditionalBorder() {
    var border = '╠══';

    for (var i = 0; i < POSITIONS_COUNT ~/ 3 - 1; i++) {
      border += (i + 1) % 3 == 0 ? '══╧══' : '═════';
    }

    border += '══╣';

    print(border);
  }

  void _drawZero() {
    print('║ ZERO BLYAT                  0 (nolik)                   ' +
        (_selected == 0 ? '▚ ║' : '  ║'));
  }

  void _drawBottomBorder() {
    print('╚═══════════════════════════════════════════════════════════╝');
  }
}
