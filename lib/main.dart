import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Import flutter_bloc
import 'package:roqqu_test/core/theme/app_theme.dart';
import 'package:roqqu_test/features/home/data/datasources/coin_tinker_datasource.dart';
import 'package:roqqu_test/features/home/presentation/pages/home_page.dart';
// 2. Import all the new classes we created
import 'package:roqqu_test/features/home/data/repositories/coin_repository_impl.dart';
import 'package:roqqu_test/features/home/presentation/bloc/coin_list_bloc.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoinTickerDataSource>(
          create: (context) => CoinTickerDataSource(),
        ),
        RepositoryProvider<CoinRepository>(
          create: (context) => CoinRepository(
            context.read<CoinTickerDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CoinListBloc>(
            create: (context) => CoinListBloc(
              context.read<CoinRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Roqqu Test',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const HomePage(),
        ),
      ),
    );
  }
}