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
  // 4. Find and initialize the default locale for intl
  await findSystemLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Wrap your MaterialApp with the providers
    return MultiRepositoryProvider(
      providers: [
        // Provider for the WebSocket DataSource. It will be created once.
        RepositoryProvider<CoinTickerDataSource>(
          create: (context) => CoinTickerDataSource(),
        ),
        // Provider for the Repository. It depends on the DataSource.
        RepositoryProvider<CoinRepository>(
          create: (context) => CoinRepository(
            // Use context.read() to get the DataSource we just provided.
            context.read<CoinTickerDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Provider for our BLoC. It depends on the Repository.
          BlocProvider<CoinListBloc>(
            create: (context) => CoinListBloc(
              // Use context.read() to get the Repository.
              context.read<CoinRepository>(),
            ),
          ),
          // You can add other BLoCs here in the future
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