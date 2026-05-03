import 'package:flutter/material.dart';

enum ActivityIntent {
  chill,
  explore,
  date,
  deepChat,
  party,
  firstMeet,
}

extension ActivityIntentX on ActivityIntent {
  String get label => switch (this) {
        ActivityIntent.chill => '放松',
        ActivityIntent.explore => '探索',
        ActivityIntent.date => '约会',
        ActivityIntent.deepChat => '深聊',
        ActivityIntent.party => '派对',
        ActivityIntent.firstMeet => '初次见面',
      };

  IconData get icon => switch (this) {
        ActivityIntent.chill => Icons.self_improvement_outlined,
        ActivityIntent.explore => Icons.explore_outlined,
        ActivityIntent.date => Icons.favorite_border,
        ActivityIntent.deepChat => Icons.chat_bubble_outline,
        ActivityIntent.party => Icons.celebration_outlined,
        ActivityIntent.firstMeet => Icons.waving_hand_outlined,
      };

  Color get color => switch (this) {
        ActivityIntent.chill => Colors.teal,
        ActivityIntent.explore => Colors.orange,
        ActivityIntent.date => Colors.pink,
        ActivityIntent.deepChat => Colors.indigo,
        ActivityIntent.party => Colors.purple,
        ActivityIntent.firstMeet => Colors.green,
      };
}
