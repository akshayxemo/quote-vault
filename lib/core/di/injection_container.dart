import 'package:get_it/get_it.dart';
import 'package:quote_vault/core/di/auth_injections.dart';
import 'package:quote_vault/core/di/quote_injections.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await authInit(sl);
  await initQuoteInjections();
}