import 'package:get_it/get_it.dart';
import 'src/package_injection.dart';

final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  await packageInjection();
}

