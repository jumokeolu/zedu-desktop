import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zedu/core/utils/validators.dart';

void main() {
  Future<BuildContext> getContext(WidgetTester tester) async {
    late BuildContext captured;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            captured = context;
            return const SizedBox();
          },
        ),
      ),
    );
    return captured;
  }

  group('Validators.validateEmail', () {
    testWidgets('accepts a normal email', (tester) async {
      final context = await getContext(tester);
      expect(Validators.validateEmail(context, 'name@example.com'), isNull);
    });

    testWidgets('accepts leading and trailing spaces', (tester) async {
      final context = await getContext(tester);
      expect(Validators.validateEmail(context, 'name@example.com '), isNull);
      expect(Validators.validateEmail(context, '  name@example.com'), isNull);
    });

    testWidgets('rejects empty or spaces-only value', (tester) async {
      final context = await getContext(tester);
      expect(Validators.validateEmail(context, ''), 'Email is required');
      expect(Validators.validateEmail(context, '   '), 'Email is required');
      expect(Validators.validateEmail(context, null), 'Email is required');
    });

    testWidgets('rejects a space in the middle or missing @', (tester) async {
      final context = await getContext(tester);
      expect(
        Validators.validateEmail(context, 'na me@example.com'),
        'Please enter a valid email',
      );
      expect(
        Validators.validateEmail(context, 'nameexample.com'),
        'Please enter a valid email',
      );
    });
  });
}
