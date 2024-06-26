import 'package:LinguaQuest/core/data/DBdictionary.dart';
import 'package:LinguaQuest/pages/splashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'core/data/cubit/add_post_cubit.dart';
import 'core/data/cubit/dictionaries_cubit.dart';
import 'core/data/cubit/posts_public_cubit.dart';
import 'core/data/cubit/posts_user_cubit.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  // await getMyPosts(1);
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const SizedBox();
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostsPublicCubit()),
        BlocProvider(create: (context) => PostsUserCubit()),
        BlocProvider(create: (context) => AddPostCubit()),
        BlocProvider(
          create: (context) =>
              DictionariesCubit(DBDictionary())..fetchDictionaries(),
        )
      ],
      child: KeyboardDismissOnTap(
        child: GetMaterialApp(
          title: 'LinguaQuest',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // appBarTheme: AppBarTheme(
            //   backgroundColor: ColorScheme.fromSeed(seedColor: Colors.purpleAccent).primary,
            // ),
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff211547)),
            useMaterial3: false,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
