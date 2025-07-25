class AppConstants {
  static const String appName = 'Star Counter';
  static const String appVersion = '1.0.0';

  static const String userBoxName = 'users';
  static const String balanceBoxName = 'balance';
  static const String currentUserKey = 'current_user';
  static const String currentBalanceKey = 'current_balance';

  static const int phoneLength = 11;
  static const int smsCodeLength = 6;

  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double defaultBorderRadius = 12.0;

  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  static const int defaultStars = 0;
  static const List<int> starPackages = [10, 20, 50, 100];
  static const int purchaseDelaySeconds = 2;
}
