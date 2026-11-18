// Student: Missamou Mayembo Elbrice Gloirdy
// Reg no:  25982
const String regNo = '25982';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// ---------------------------------------------------------------
// B2 - count vowels (capital letters count too)
// ---------------------------------------------------------------
int countVowels(String text) {
  // by MMEG
  final String lower = text.toLowerCase(); // <- this line makes capital letters count
  int count = 0;
  int i = 0;
  while (i < lower.length) {
    final String ch = lower[i];
    if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u') {
      count++;
    }
    i++;
  }
  return count;
}

// ---------------------------------------------------------------
// B3 - initials (handles extra spaces, empty and blank strings)
// ---------------------------------------------------------------

// FIRST DRAFT (kept as a comment). It broke on ' ana uwase ' and on ' ':
// split(' ') creates empty pieces, and ''[0] crashes with a RangeError.
//
// String initials(String fullName) {
//   // by MMEG
//   final parts = fullName.split(' ');
//   String result = '';
//   int i = 0;
//   while (i < parts.length) {
//     result += parts[i][0].toUpperCase() + '.';
//     i++;
//   }
//   return result;
// }

String initials(String fullName) {
  // by MMEG
  final String trimmed = fullName.trim(); // removes leading/trailing spaces
  if (trimmed.isEmpty) return ''; // empty or only spaces
  final List<String> parts = trimmed.split(RegExp(r'\s+')); // one or many spaces
  String result = '';
  int i = 0;
  while (i < parts.length) {
    result += '${parts[i][0].toUpperCase()}.';
    i++;
  }
  return result;
}

// ---------------------------------------------------------------
// C5 - right-aligned triangle (odd rows '*', even rows '#')
// ---------------------------------------------------------------
void drawTriangle(int height) {
  // by MMEG
  int row = 1;
  while (row <= height) {
    final String symbol = row.isOdd ? '*' : '#';
    final int spaces = height - row; // the shorter the row, the more spaces before it
   print(List.filled(spaces, ' ').join() +
      List.filled(row, symbol).join());
    row++;
  }
}

// ---------------------------------------------------------------
// D2 - MoMo receipt printer
// ---------------------------------------------------------------
int momoFee(int amount) {
  // by MMEG
  if (amount <= 0) return -1; // invalid
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String maskPhone(String phone) {
  // by MMEG
  if (phone.length != 10) return 'INVALID';
  final String start = phone.substring(0, 3);
  final String end = phone.substring(phone.length - 2);
  return start +
    List.filled(phone.length - 5, '*').join() +
    end;
}

// ---------------------------------------------------------------
// Part E - fixed versions (see answers.pdf for the list of changes)
// ---------------------------------------------------------------
String grade(int mark) {
  // by MMEG
  if (mark >= 50 && mark < 70) { // changed (was: mark >= 50)
    return 'C';
  } else if (mark >= 70 && mark < 80) { // changed (was: mark >= 70)
    return 'B';
  } else if (mark >= 80) {
    return 'A';
  }
  return 'F';
}

// ORIGINAL VERSION (given in the assignment, kept as a comment). It crashes with a
// RangeError on isPalindrome('level'): at i = 0, word[word.length - i] is word[5],
// but the last valid index of a 5-letter word is 4.
//
// bool isPalindrome(String word) {
//   int i = 0;
//   while (i < word.length) {
//     if (word[i] != word[word.length - i]) return false;
//     i++;
//   }
//   return true;
// }

bool isPalindrome(String word) {
  // by MMEG
  final String w = word.toLowerCase(); // added: my choice, 'Level' is a palindrome
  int i = 0;
  while (i < w.length) {
    if (w[i] != w[w.length - 1 - i]) return false; // changed (was: word.length - i)
    i++;
  }
  return true;
}

void main() {
  // by MMEG
  print('Reg no: $regNo | D = $d | T = $t');

  // ----- B2 -----
  print('--- B2 ---');
  const String fullName = 'Missamou Mayembo Elbrice Gloirdy';
  print('$fullName has ${countVowels(fullName)} vowels');

  // ----- B3 -----
  print('--- B3 ---');
  print("initials('$fullName') = '${initials(fullName)}'");
  print("initials(' ana uwase ') = '${initials(' ana uwase ')}'");
  print("initials(' ') = '${initials(' ')}'");

  // ----- C5 -----
  print('--- C5 ---');
  print('height = D + 3 = ${d + 3}');
  drawTriangle(d + 3);
  print('height = 0 (nothing below)');
  drawTriangle(0);
  print('height = -2 (nothing below)');
  drawTriangle(-2);

  // ----- D2 -----
  print('--- D2 ---');
  const String phone = '0788123456';
  int i = 1;
  int totalFees = 0;
  while (i <= d + 3) {
    final int amount = i * 4000 + t * 100;
    final int fee = momoFee(amount);
    print('Receipt $i | $amount RWF | fee $fee RWF | to ${maskPhone(phone)}');
    totalFees += fee;
    i++;
  }
  print('Total fees: $totalFees RWF');

  // ----- Part E (checks of the fixed functions) -----
  print('--- E ---');
  print('grade(85) = ${grade(85)}');
  print('grade(75) = ${grade(75)}');
  print('grade(55) = ${grade(55)}');
  print('grade(30) = ${grade(30)}');
  print("isPalindrome('level') = ${isPalindrome('level')}");
  print("isPalindrome('Level') = ${isPalindrome('Level')}");
  print("isPalindrome('hello') = ${isPalindrome('hello')}");
}
