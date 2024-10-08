import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final GetIt getIt = GetIt.instance;

// @InjectableInit()
// Future<void> configureInjection() async {
//   await $initGetIt(getIt);
// }

@InjectableInit(preferRelativeImports: false)
void configureInjection() => getIt.init();
