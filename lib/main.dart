import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nano/globals.dart';
import 'package:nano/screens/app/auth.dart';
import 'package:nano/screens/products/detail.dart';
import 'package:nano/screens/products/list.dart';
import 'package:nano/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.instance.init();

  runApp(
    UncontrolledProviderScope(
      container: Globals.pc,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff2AB3C6),
          secondary: const Color(0xff188095),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              )),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x603C3C43),
              width: 10,
            ),
          ),
        ),
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(0xff2AB3C6),
            ),
            padding: MaterialStatePropertyAll(
              EdgeInsets.all(27),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) {
          if (Storage.instance.contains(StorageKeys.auth_data)) {
            return const ProductListScreen();
          }

          return const AuthScreen();
        },
        '/products': (context) => const ProductListScreen(),
        '/product-detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          return ProductDetailScreen(args as int);
        }
      },
    );
  }
}
