// Student: Missamou Mayembo Elbrice Gloirdy
// Reg no:  25982
const String regNo = '25982';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// ---------------------------------------------------------------
// momoFee (copied from D2)
// ---------------------------------------------------------------
int momoFee(int amount) {
  // by MMEG
  if (amount <= 0) return -1; // invalid
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

// ---------------------------------------------------------------
// F1 - formatRwf: comma every 3 digits, ends with ' RWF'
// ---------------------------------------------------------------

// FIRST DRAFT (kept as a comment). It worked on 1250000 but gave
// '-,100 RWF' for -100: the '-' was counted as a digit, so a comma
// was inserted right after it.
//
// String formatRwf(int amount) {
//   // by MMEG
//   final String s = amount.toString();
//   String out = '';
//   int count = 0;
//   int i = s.length - 1;
//   while (i >= 0) {
//     if (count > 0 && count % 3 == 0) out = ',' + out;
//     out = s[i] + out;
//     count++;
//     i--;
//   }
//   return out + ' RWF';
// }

String formatRwf(int amount) {
  // by MMEG
  final String sign = amount < 0 ? '-' : '';
  final String digits = amount.abs().toString(); // only digits, no '-'
  String out = '';
  int count = 0;
  int i = digits.length - 1;
  while (i >= 0) {
    if (count > 0 && count % 3 == 0) out = ',$out';
    out = digits[i] + out;
    count++;
    i--;
  }
  return '$sign$out RWF';
}

// ---------------------------------------------------------------
// F2 - isValidPin
// ---------------------------------------------------------------
bool isValidPin(String pin) {
  // by MMEG
  if (pin.length != 5) return false; // exactly 5 characters

  int i = 0;
  while (i < pin.length) {
    final int code = pin.codeUnitAt(i);
    if (code < 48 || code > 57) return false; // not '0'..'9'
    i++;
  }

  if (pin == '12345') return false; // forbidden PIN

  bool allSame = true;
  int j = 1;
  while (j < pin.length) {
    if (pin[j] != pin[0]) allSame = false;
    j++;
  }
  if (allSame) return false; // 00000, 11111, ... 99999

  return true;
}

// ---------------------------------------------------------------
// F3 - sendMoney
// ---------------------------------------------------------------
int sendMoney(int balance, int amount) {
  // by MMEG
  final int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  final int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

// ---------------------------------------------------------------
// F4 - buyAirtime (no fee)
// ---------------------------------------------------------------
int buyAirtime(int balance, int amount) {
  // by MMEG
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime must be from 100 to 50,000 RWF');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  final int newBalance = balance - amount;
  print('Airtime bought: ${formatRwf(amount)}. '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by MMEG
  print('Reg no: $regNo | D = $d | T = $t');

  // 1. PIN checks
  print('--- PIN checks ---');
  final String pinWithD = '4821$d'; // my own D in place of the last character
  print("isValidPin('12345') = ${isValidPin('12345')}");
  print("isValidPin('$pinWithD') = ${isValidPin(pinWithD)}");
  print("isValidPin('77777') = ${isValidPin('77777')}");
  print("isValidPin('4821') = ${isValidPin('4821')}");
  print("isValidPin('48a21') = ${isValidPin('48a21')}");

  // 2. Starting balance
  print('--- Transactions ---');
  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');

  // 3. In order: send (D + 1) * 3000 three times, buy 1,000 airtime, send 200000
  final int sendAmount = (d + 1) * 3000;
  int n = 0;
  while (n < 3) {
    balance = sendMoney(balance, sendAmount);
    n++;
  }
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 200000);

  // 4. Final balance
  print('Final balance: ${formatRwf(balance)}');

  // 5. My own tests (expected output written next to each call)
  print('--- My own tests ---');
  print(formatRwf(0)); // expected: 0 RWF
  print(formatRwf(100)); // expected: 100 RWF
  print(formatRwf(-100)); // expected: -100 RWF   <- the case I thought could break
  print(formatRwf(1000000)); // expected: 1,000,000 RWF
  print(isValidPin('00000')); // expected: false (same digit five times)
  print(isValidPin('')); // expected: false (empty, length is not 5)
  print(isValidPin(' 1234')); // expected: false (a space is not a digit)
  print(isValidPin('13579')); // expected: true
}
