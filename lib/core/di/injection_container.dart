import 'package:quote_vault/core/di/auth_injections.dart';

Future<void> init() async {
  await authInit();
}