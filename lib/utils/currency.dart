String format(String string) {
  // var decimal = '0010';
  if (string.contains('.')) {
    var split = string.split('.');
    string = split.first;
    // decimal = split.last;
  }

  fm(String string) {
    List<int> chars = string.runes.map((e) => e).toList();
    string = "";
    var k = 0;
    for (var i = chars.length - 1; i >= 0; i--) {
      string =
          "${String.fromCharCode(chars[i])}${k != 0 && k % 3 == 0 ? ',' : ''}$string";
      k++;
    }
    return string;
  }

  return fm(string);
}
