import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/widgets/alert_widget.dart';

import '../utils.dart';

void main() {
  const color = Colors.red;
  const text = 'Test';
  void testBaseInterface(
      {required WidgetTester tester, required BuildContext buildContext}) {
    final containerKeyFinder = find.byKey(const Key('AlertWidgetContainer'));
    expect(containerKeyFinder, findsOneWidget);

    final container = tester.widget<Container>(containerKeyFinder);
    expect(container.padding, const EdgeInsets.all(8));

    expect(find.byKey(const Key('AlertWidgetCenter')), findsOneWidget);

    final columnFinder = find.byKey(const Key('AlertWidgetColumn'));
    expect(columnFinder, findsOneWidget);

    final column = tester.widget<Column>(columnFinder);

    expect(column.mainAxisAlignment, MainAxisAlignment.center);

    final iconFinder = find.byIcon(Icons.warning_rounded);
    expect(iconFinder, findsOneWidget);

    final icon = tester.widget<Icon>(iconFinder);
    expect(icon.color, color);
    expect(icon.size, 120);

    final paddingFinder = find.byKey(const Key('AlertWidgetPadding'));
    expect(paddingFinder, findsOneWidget);

    final padding = tester.widget<Padding>(paddingFinder);
    expect(padding.padding, const EdgeInsets.only(top: 16.0, bottom: 8));

    final textFinder = find.text(text);
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);

    expect(textWidget.style, Theme.of(buildContext).textTheme.headline5);
    expect(textWidget.textAlign, TextAlign.center);
  }

  testWidgets('Alert widget base interface', (tester) async {
    late BuildContext buildContext;
    await tester.pumpWidget(
      defaultMaterialApp(
        Builder(
          builder: (context) {
            buildContext = context;
            return const AlertWidget(iconColor: color, text: text);
          },
        ),
      ),
    );

    testBaseInterface(tester: tester, buildContext: buildContext);

    expect(find.byType(TextButton), findsNothing);
  });

  testWidgets('Test with on tap', (tester) async {
    late BuildContext buildContext;
    var tapped = false;
    await tester.pumpWidget(
      defaultMaterialApp(
        Builder(
          builder: (context) {
            buildContext = context;
            return AlertWidget(
              iconColor: color,
              text: text,
              onTap: () => tapped = !tapped,
            );
          },
        ),
      ),
    );

    testBaseInterface(tester: tester, buildContext: buildContext);

    final textButtonFinder = find.byType(TextButton);
    expect(textButtonFinder, findsOneWidget);

    expect(
      find.text('Aperte aqui para tentar novamente'.toUpperCase()),
      findsOneWidget,
    );

    await tester.tap(textButtonFinder);

    expect(tapped, isTrue);
  });
}
