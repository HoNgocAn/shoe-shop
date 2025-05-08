import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_flutter/data/source/favorite_source.dart';
import 'package:shoe_shop_flutter/routes/app_routes.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/favorite_repository.dart';
import 'data/source/auth_source.dart';
import 'data/viewModel/auth_view_model.dart';
import 'data/viewModel/favorite_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth
        Provider<AuthSource>(create: (_) => AuthSource()),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(context.read<AuthSource>()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(context.read<AuthRepository>()),
        ),

        // Favorite
        Provider<FavoriteSource>(create: (_) => FavoriteSource()),
        Provider<FavoriteRepository>(
          create: (context) => FavoriteRepositoryImpl(context.read<FavoriteSource>()),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteViewModel(context.read<FavoriteRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.main,
        routes: AppRoutes.routes,
      ),
    );
  }
}
