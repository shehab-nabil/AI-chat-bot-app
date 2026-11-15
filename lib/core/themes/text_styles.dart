import 'package:flutter/material.dart';

import 'colors_manager.dart';

abstract final class TextStyles {
  static const TextStyle headerTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ColorsManager.primary,
  );

  static const TextStyle headerStatus = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: ColorsManager.online,
  );

  static const TextStyle userMessage = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: ColorsManager.white,
  );

  static const TextStyle botMessage = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: ColorsManager.botBubbleText,
  );

  static const TextStyle botMessageBody = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: ColorsManager.botBubbleBodyText,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: ColorsManager.hint,
  );
}
