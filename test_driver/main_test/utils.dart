import 'package:flutter_driver/flutter_driver.dart';

enum TType {
  byText,
  byKey,
  byType,
  byToolTip,
  byFinder;
}

class TestUtils {
  static Future<void> clickKey(FlutterDriver? driver, String key) async {
    try {
      final seat = await findByKey(
        driver: driver,
        key: key,
      );

      await driver?.tap(seat);
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH KEY: $key; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> clickName(
    FlutterDriver? driver,
    String name,
  ) async {
    try {
      final seat = await findByText(
        driver: driver,
        text: name,
      );

      await driver?.tap(seat);
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH NAME: $name; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> clickTip(FlutterDriver? driver, String name) async {
    try {
      final seat = await findByTooltip(
        driver: driver,
        tooltip: name,
      );

      await driver?.tap(seat);
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH TOOL TIP: $name; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> clickType(FlutterDriver? driver, String type) async {
    try {
      final seat = await findByType(
        driver: driver,
        type: type,
      );

      await driver?.tap(seat);
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH TYPE: $type; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> clickDescendant({
    required final TType ofType,
    required final dynamic of,
    required final TType matcherType,
    required final dynamic matcher,
    required final FlutterDriver? driver,
  }) async {
    SerializableFinder ofFinder;
    switch (ofType) {
      case TType.byKey:
        ofFinder = await findByKey(driver: driver, key: of);
      case TType.byText:
        ofFinder = await findByText(driver: driver, text: of);
      case TType.byType:
        ofFinder = await findByType(driver: driver, type: of);
      case TType.byToolTip:
        ofFinder = await findByTooltip(driver: driver, tooltip: of);
      case TType.byFinder:
        ofFinder = of;
    }
    SerializableFinder matcherFinder;
    switch (matcherType) {
      case TType.byKey:
        matcherFinder = await findByKey(driver: driver, key: matcher);
      case TType.byText:
        matcherFinder = await findByText(driver: driver, text: matcher);
      case TType.byType:
        matcherFinder = await findByType(driver: driver, type: matcher);
      case TType.byToolTip:
        matcherFinder = await findByTooltip(driver: driver, tooltip: matcher);
      case TType.byFinder:
        matcherFinder = matcher;
    }

    final descendantFinder = await findDescendant(
      driver: driver,
      of: ofFinder,
      matcher: matcherFinder,
    );

    await driver?.tap(descendantFinder);
  }

  static Future<void> clickDescendantOfFinders({
    required final TType ofType,
    required final dynamic of,
    required final TType matcherType,
    required final dynamic matcher,
    required final FlutterDriver? driver,
  }) async {
    SerializableFinder ofFinder;
    switch (ofType) {
      case TType.byKey:
        ofFinder = await findByKey(driver: driver, key: of);
      case TType.byText:
        ofFinder = await findByText(driver: driver, text: of);
      case TType.byType:
        ofFinder = await findByType(driver: driver, type: of);
      case TType.byToolTip:
        ofFinder = await findByTooltip(driver: driver, tooltip: of);
      case TType.byFinder:
        ofFinder = of;
    }
    SerializableFinder matcherFinder;
    switch (matcherType) {
      case TType.byKey:
        matcherFinder = await findByKey(driver: driver, key: matcher);
      case TType.byText:
        matcherFinder = await findByText(driver: driver, text: matcher);
      case TType.byType:
        matcherFinder = await findByType(driver: driver, type: matcher);
      case TType.byToolTip:
        matcherFinder = await findByTooltip(driver: driver, tooltip: matcher);
      case TType.byFinder:
        matcherFinder = matcher;
    }

    final descendantFinder = await findDescendant(
      driver: driver,
      of: ofFinder,
      matcher: matcherFinder,
    );

    await driver?.tap(descendantFinder);
  }

  static Future<void> clickAncestor({
    required final TType ofType,
    required final dynamic of,
    required final TType matcherType,
    required final dynamic matcher,
    required final FlutterDriver? driver,
  }) async {
    SerializableFinder ofFinder;
    switch (ofType) {
      case TType.byKey:
        ofFinder = await findByKey(driver: driver, key: of);
      case TType.byText:
        ofFinder = await findByText(driver: driver, text: of);
      case TType.byType:
        ofFinder = await findByType(driver: driver, type: of);
      case TType.byToolTip:
        ofFinder = await findByTooltip(driver: driver, tooltip: of);
      case TType.byFinder:
        ofFinder = of;
    }
    SerializableFinder matcherFinder;
    switch (matcherType) {
      case TType.byKey:
        matcherFinder = await findByKey(driver: driver, key: matcher);
      case TType.byText:
        matcherFinder = await findByText(driver: driver, text: matcher);
      case TType.byType:
        matcherFinder = await findByType(driver: driver, type: matcher);
      case TType.byToolTip:
        matcherFinder = await findByTooltip(driver: driver, tooltip: matcher);
      case TType.byFinder:
        matcherFinder = matcher;
    }

    final descendantFinder = await findAncestor(
      driver: driver,
      of: ofFinder,
      matcher: matcherFinder,
    );

    await driver?.tap(descendantFinder);
  }

  static Future<void> multipleClick(
    FlutterDriver? driver,
    TType type,
    dynamic key,
    int times,
  ) async {
    try {
      SerializableFinder seat;
      switch (type) {
        case TType.byKey:
          seat = await findByKey(driver: driver, key: key);
        case TType.byText:
          seat = await findByText(driver: driver, text: key);
        case TType.byType:
          seat = await findByType(driver: driver, type: key);
        case TType.byToolTip:
          seat = await findByTooltip(driver: driver, tooltip: key);
        case TType.byFinder:
          seat = key;
      }

      for (int i = 0; i < times; i++) {
        await driver?.tap(seat);
      }
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH TYPE: $key; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> multipleClickWithList(
    FlutterDriver? driver,
    List<String> list,
  ) async {
    try {
      for (int i = 0; i < list.length; i++) {
        final seat = await findByText(
          driver: driver,
          text: list[i],
        );

        await driver?.tap(seat);
      }
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH TYPE: $list; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> check(
    FlutterDriver? driver,
    String key,
    String exept,
  ) async {
    try {
      final seat = await findByKey(
        driver: driver,
        key: key,
      );

      final text = await driver?.getText(seat);
      if (text != exept) {
        throw 'VALUE $text IS NOT EQUAL TO VALUE $exept';
      }
    } catch (err) {
      throw err;
    }
  }

  static Future<void> slide(
    FlutterDriver? driver,
    TType type,
    dynamic from,
    TType toType,
    dynamic to,
  ) async {
    try {
      SerializableFinder seat;
      switch (type) {
        case TType.byKey:
          seat = await findByKey(driver: driver, key: from);
        case TType.byText:
          seat = await findByText(driver: driver, text: from);
        case TType.byType:
          seat = await findByType(driver: driver, type: from);
        case TType.byToolTip:
          seat = await findByTooltip(driver: driver, tooltip: from);
        case TType.byFinder:
          seat = from;
      }
      SerializableFinder toSF;
      switch (toType) {
        case TType.byKey:
          toSF = await findByKey(driver: driver, key: to);
        case TType.byText:
          toSF = await findByText(driver: driver, text: to);
        case TType.byType:
          toSF = await findByType(driver: driver, type: to);
        case TType.byToolTip:
          toSF = await findByTooltip(driver: driver, tooltip: to);
        case TType.byFinder:
          toSF = to;
      }
      await driver?.scrollUntilVisible(
        seat,
        toSF,
        // dyScroll: 300,
        dxScroll: 1000,
      );
      // await driver!.scroll(seat, -300.0, 0.0, const Duration(milliseconds: 500));
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH TYPE: $from; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> scroll({
    required final FlutterDriver? driver,
    required final TType scrollableFinderType,
    required final dynamic scrollable,
    required final TType itemType,
    required final dynamic item,
    final double dyScroll = -100,
  }) async {
    try {
      SerializableFinder scrollableFinder;
      switch (scrollableFinderType) {
        case TType.byKey:
          scrollableFinder = await findByKey(driver: driver, key: scrollable);
        case TType.byText:
          scrollableFinder = await findByText(driver: driver, text: scrollable);
        case TType.byType:
          scrollableFinder = await findByType(driver: driver, type: scrollable);
        case TType.byToolTip:
          scrollableFinder = await findByTooltip(driver: driver, tooltip: scrollable);
        case TType.byFinder:
          scrollableFinder = scrollable;
      }
      SerializableFinder itemFinder;
      switch (itemType) {
        case TType.byKey:
          itemFinder = await findByKey(driver: driver, key: item);
        case TType.byText:
          itemFinder = await findByText(driver: driver, text: item);
        case TType.byType:
          itemFinder = await findByType(driver: driver, type: item);
        case TType.byToolTip:
          itemFinder = await findByTooltip(driver: driver, tooltip: item);
        case TType.byFinder:
          itemFinder = item;
      }
      await driver?.scrollUntilVisible(
        scrollableFinder,
        itemFinder,
        dyScroll: dyScroll,
      );
      // await driver!.scroll(seat, -300.0, 0.0, const Duration(milliseconds: 500));
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE SCROLLABLE: $scrollable OR ITEM: $item;');
      print(err);
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<void> enterText(
    FlutterDriver? driver,
    TType type,
    dynamic key,
    String text,
  ) async {
    try {
      SerializableFinder seat;
      switch (type) {
        case TType.byKey:
          seat = await findByKey(driver: driver, key: key);
        case TType.byText:
          seat = await findByText(driver: driver, text: key);
        case TType.byType:
          seat = await findByType(driver: driver, type: key);
        case TType.byToolTip:
          seat = await findByTooltip(driver: driver, tooltip: key);
        case TType.byFinder:
          seat = key;
      }
      await driver?.tap(seat);

      await driver?.enterText(text);
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND THE BUTTON WITH TYPE: $key; EXEPTION: $err');
      print('____________________________________________________________');
      throw err;
    }
  }

  @Deprecated('Use find() instead')
  static Future<void> findT(
    FlutterDriver? driver,
    TType type,
    dynamic key,
  ) async {
    try {
      switch (type) {
        case TType.byKey:
          await findByKey(driver: driver, key: key);
        case TType.byText:
          await findByText(driver: driver, text: key);
        case TType.byType:
          await findByType(driver: driver, type: key);
        case TType.byToolTip:
          await findByTooltip(driver: driver, tooltip: key);
        case TType.byFinder:
          await findByKey(driver: driver, key: key);
      }
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND KEY $key');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<SerializableFinder> findItem({
    required final FlutterDriver? driver,
    required final TType type,
    required final dynamic key,
  }) async {
    try {
      SerializableFinder itemFinder;
      switch (type) {
        case TType.byKey:
          itemFinder = await findByKey(driver: driver, key: key);
        case TType.byText:
          itemFinder = await findByText(driver: driver, text: key);
        case TType.byType:
          itemFinder = await findByType(driver: driver, type: key);
        case TType.byToolTip:
          itemFinder = await findByTooltip(driver: driver, tooltip: key);
        case TType.byFinder:
          itemFinder = key;
      }
      return itemFinder;
    } catch (err) {
      print('____________________________________________________________');
      print('CANT FIND KEY $key');
      print('____________________________________________________________');
      throw err;
    }
  }

  static Future<SerializableFinder> findAncestorOftext({
    required final FlutterDriver? driver,
    required final String text,
    required final String ancestorType,
  }) async {
    final textFinder = await findByText(
      driver: driver,
      text: text,
    );
    final ancestorFinder = await findByType(
      driver: driver,
      type: ancestorType,
    );
    return await findAncestor(
      driver: driver,
      of: textFinder,
      matcher: ancestorFinder,
    );
  }

  static Future<void> wait(int sec) async {
    return await Future.delayed(Duration(seconds: sec));
  }

  static Future<SerializableFinder> findByText({
    required final FlutterDriver? driver,
    required final String text,
  }) async {
    final finder = find.text(text);
    try {
      await waitForFinder(
        driver: driver,
        finder: finder,
      );
      return finder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE TEXT: $text');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<SerializableFinder> findByType({
    required final FlutterDriver? driver,
    required final String type,
  }) async {
    final finder = find.byType(type);
    try {
      await waitForFinder(
        driver: driver,
        finder: finder,
      );
      return finder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE TYPE: $type');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<SerializableFinder> findByKey({
    required final FlutterDriver? driver,
    required final String key,
  }) async {
    final finder = find.byValueKey(key);
    try {
      await waitForFinder(
        driver: driver,
        finder: finder,
      );
      return finder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE KEY: $key');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<SerializableFinder> findByTooltip({
    required final FlutterDriver? driver,
    required final String tooltip,
  }) async {
    final finder = find.byTooltip(tooltip);
    try {
      await waitForFinder(
        driver: driver,
        finder: finder,
      );
      return finder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE TOOLTIP: $tooltip');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<SerializableFinder> findAncestor({
    required final SerializableFinder of,
    required final SerializableFinder matcher,
    required final FlutterDriver? driver,
    bool firstMatchOnly = true,
  }) async {
    final registerInkWellFinder = find.ancestor(
      of: of,
      matching: matcher,
      firstMatchOnly: firstMatchOnly,
    );
    try {
      await waitForFinder(
        driver: driver,
        finder: registerInkWellFinder,
      );
      return registerInkWellFinder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE ANCESTOR OF: $of');
      print('MATCHER: $matcher');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<SerializableFinder> findTAncestor({
    required final TType ofType,
    required final dynamic of,
    required final TType matcherType,
    required final dynamic matcher,
    required final FlutterDriver? driver,
    bool firstMatchOnly = true,
  }) async {
    SerializableFinder ofFinder;
    switch (ofType) {
      case TType.byKey:
        ofFinder = await findByKey(driver: driver, key: of);
      case TType.byText:
        ofFinder = await findByText(driver: driver, text: of);
      case TType.byType:
        ofFinder = await findByType(driver: driver, type: of);
      case TType.byToolTip:
        ofFinder = await findByTooltip(driver: driver, tooltip: of);
      case TType.byFinder:
        ofFinder = of;
    }
    SerializableFinder matcherFinder;
    switch (matcherType) {
      case TType.byKey:
        matcherFinder = await findByKey(driver: driver, key: matcher);
      case TType.byText:
        matcherFinder = await findByText(driver: driver, text: matcher);
      case TType.byType:
        matcherFinder = await findByType(driver: driver, type: matcher);
      case TType.byToolTip:
        matcherFinder = await findByTooltip(driver: driver, tooltip: matcher);
      case TType.byFinder:
        matcherFinder = matcher;
    }

    try {
      final registerInkWellFinder = findAncestor(
        driver: driver,
        of: ofFinder,
        matcher: matcherFinder,
        firstMatchOnly: firstMatchOnly,
      );

      return registerInkWellFinder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE ANCESTOR OF: $of');
      print('MATCHER: $matcher');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<SerializableFinder> findDescendant({
    required final SerializableFinder of,
    required final SerializableFinder matcher,
    required final FlutterDriver? driver,
    bool firstMatchOnly = true,
  }) async {
    final registerInkWellFinder = find.descendant(
      of: of,
      matching: matcher,
      firstMatchOnly: firstMatchOnly,
    );
    try {
      await waitForFinder(
        driver: driver,
        finder: registerInkWellFinder,
      );
      return registerInkWellFinder;
    } catch (e) {
      print('____________________________________________________________');
      print('CANT FIND THE ANCESTOR OF: $of');
      print('MATCHER: $matcher');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<void> findByTextAndTapOnAncestorOfType({
    required final FlutterDriver? driver,
    required final String text,
    required final String ancestorType,
    final Duration? tapDuration,
  }) async {
    final registerTextFinder = await findByText(
      driver: driver,
      text: text,
    );
    final matchFinder = await findByType(
      driver: driver,
      type: ancestorType,
    );
    try {
      final registerInkWellFinder = await findAncestor(
        of: registerTextFinder,
        matcher: matchFinder,
        driver: driver,
      );

      await driver?.tap(registerInkWellFinder, timeout: tapDuration);
    } catch (e) {
      print('____________________________________________________________');
      print(
        'CANT FIND THE BUTTON WITH TEXT: $text AND ANCESTOR TYPE: $ancestorType',
      );
      print('EXEPTION: $e');
      print('____________________________________________________________');
      throw e;
    }
  }

  static Future<void> waitForFinder({
    required final FlutterDriver? driver,
    required final SerializableFinder finder,
  }) async {
    await driver?.waitFor(
      finder,
    );
  }

  static Future<bool> checkForText({
    required final FlutterDriver? driver,
    required final String text,
  }) async {
    try {
      await findByText(
        driver: driver,
        text: text,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForType({
    required final FlutterDriver? driver,
    required final String type,
  }) async {
    try {
      await findByType(
        driver: driver,
        type: type,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForKey({
    required final FlutterDriver? driver,
    required final String key,
  }) async {
    try {
      await findByKey(
        driver: driver,
        key: key,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForAncestorOfText({
    required final FlutterDriver? driver,
    required final String text,
    required final String ancestorType,
    final bool firstMatchOnly = true,
  }) async {
    final textFinder = await findByText(
      driver: driver,
      text: text,
    );

    final matchFinder = await findByType(
      driver: driver,
      type: ancestorType,
    );

    try {
      await findAncestor(
        of: textFinder,
        matcher: matchFinder,
        driver: driver,
        firstMatchOnly: firstMatchOnly,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForAncestorOfTextByKey({
    required final FlutterDriver? driver,
    required final String text,
    required final String key,
  }) async {
    try {
      final textFinder = await findByText(
        driver: driver,
        text: text,
      );
      final matchFinder = await findByKey(
        driver: driver,
        key: key,
      );

      await findAncestor(
        of: textFinder,
        matcher: matchFinder,
        driver: driver,
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForDescendantTextFromTheKey({
    required final FlutterDriver? driver,
    required final String text,
    required final String key,
  }) async {
    try {
      // Find the text element
      final keyFinder = await findByKey(
        driver: driver,
        key: key,
      );

      final matcherFinder = await findByText(
        driver: driver,
        text: text,
      );

      // Try to find an ancestor with the specified key
      final descendantFinder = await findDescendant(
        driver: driver,
        of: keyFinder,
        matcher: matcherFinder,
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForDescendantTextFromType({
    required final FlutterDriver? driver,
    required final String text,
    required final String type,
  }) async {
    try {
      // Find the text element
      final typeFinder = await findByType(
        driver: driver,
        type: type,
      );

      final matcherFinder = await findByText(
        driver: driver,
        text: text,
      );

      // Try to find an ancestor with the specified key
      final descendantFinder = await findDescendant(
        driver: driver,
        of: typeFinder,
        matcher: matcherFinder,
      );

      // If we can find the ancestor, return true
      await driver?.waitFor(
        descendantFinder,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForKeyTextValue({
    required final FlutterDriver? driver,
    required final String key,
    required final String text,
  }) async {
    try {
      final keyFinder = await findByKey(
        driver: driver,
        key: key,
      );
      final keyText = await driver?.getText(keyFinder);
      return keyText == text;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkForDescendant({
    required final TType ofType,
    required final dynamic of,
    required final TType matcherType,
    required final dynamic matcher,
    required final FlutterDriver? driver,
  }) async {
    SerializableFinder ofFinder;
    switch (ofType) {
      case TType.byKey:
        ofFinder = await findByKey(driver: driver, key: of);
      case TType.byText:
        ofFinder = await findByText(driver: driver, text: of);
      case TType.byType:
        ofFinder = await findByType(driver: driver, type: of);
      case TType.byToolTip:
        ofFinder = await findByTooltip(driver: driver, tooltip: of);
      case TType.byFinder:
        ofFinder = of;
    }
    SerializableFinder matcherFinder;
    switch (matcherType) {
      case TType.byKey:
        matcherFinder = await findByKey(driver: driver, key: matcher);
      case TType.byText:
        matcherFinder = await findByText(driver: driver, text: matcher);
      case TType.byType:
        matcherFinder = await findByType(driver: driver, type: matcher);
      case TType.byToolTip:
        matcherFinder = await findByTooltip(driver: driver, tooltip: matcher);
      case TType.byFinder:
        matcherFinder = matcher;
    }

    try {
      await findDescendant(
        driver: driver,
        of: ofFinder,
        matcher: matcherFinder,
      );
      return true;
    } catch (e) {
      print(e);
      print('____________________________________________________________');
      print('CANT FIND THE DESCENDANT OF: $of');
      print('MATCHER: $matcher');
      print('____________________________________________________________');
      return false;
    }
  }
}
