import 'package:artic/blocs/artwork/artwork_bloc.dart';
import 'package:artic/blocs/search/search_bloc.dart';
import 'package:artic/ui/pages/search_page.dart';
import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const TextStyle textStyle = TextStyle(
    color: AppColors.secondary,
    fontFamily: Fonts.Inter,
    fontSize: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => ArtworkBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Texts.app_name,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primary,
          fontFamily: Fonts.Inter,
          textTheme: TextTheme(
            headline4: textStyle.copyWith(fontSize: 20.0),
            headline5: textStyle.copyWith(fontSize: 18.0, color: AppColors.primary),
            subtitle1: textStyle.copyWith(fontSize: 16.0, color: AppColors.primary),
            subtitle2: textStyle.copyWith(fontSize: 16.0, color: AppColors.grey1),
            bodyText1: textStyle.copyWith(height: 1.6),
            bodyText2: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        home: const SearchPage(),
      ),
    );
  }
}
