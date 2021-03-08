## Folders
```
lib/
----feature/
--------item/
------------*page1.dart
------------cubit1/
----------------*cubit.dart
----------------*states.dart
--------item2/
------------*page2.dart
------------cubit2/
----------------*cubit.dart
----------------*states.dart
--------shared/
------------*widget.dart
------------*cubit/
----------------*cubit.dart
----------------*states.dart
----utils/
--------constants.dart
----widgets/
--------*widget.dart
```


## Constants

utils/constants.dart
```
class FontSizes {
  static const double kVerySmall = 10;
  static const double kSmall = 12;
  static const double kMedium = 14;
  static const double kLarge = 16;
  static const double kVeryLarge = 18;
}

class Edges {
  static const double kVerySmall = 5;
  static const double kSmall = 10;
  static const double kMedium = 15;
  static const double kLarge = 20;
  static const double kVeryLarge = 25;
}

class Colors {
  static const Color kPrimaryColor = Color(0xff27253f);
  static const Color kAccentColor = Color(0xff2dafe6);
}
```
