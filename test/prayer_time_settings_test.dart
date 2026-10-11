import 'package:flutter_test/flutter_test.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomePageVM viewModel;

  setUp(() {
    viewModel = HomePageVM();
  });

  tearDown(() async {
    await viewModel.close();
  });

  test('keeps API local time without applying a second daylight-saving hour',
      () {
    expect(
      viewModel.displayPrayerTime({'Salat': 'الفجر', 'Time': '01:15 (EEST)'}),
      '01:15',
    );
  });

  test('applies saved minute adjustments across midnight', () {
    viewModel.prayerTimeOffsets['الفجر'] = -20;

    expect(
      viewModel.displayPrayerTime({'Salat': 'الفجر', 'Time': '00:10 (EET)'}),
      '23:50',
    );
  });
}
