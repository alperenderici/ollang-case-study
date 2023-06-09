import 'package:flutter/material.dart';
import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_cubit.dart';
import 'package:recipe_app/ui/cubit/recipe_detail_cubit.dart';
import 'package:recipe_app/ui/pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/cubit/homepage_cubit.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ensure that the binding is initialized
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageCubit>(
          create: (context) => HomePageCubit(RecipeRepository()),
        ),
        BlocProvider<RecipeDetailCubit>(
          create: (context) => RecipeDetailCubit(RecipeRepository()),
        ),
        BlocProvider<FavoriteRecipesCubit>(
          create: (context) => FavoriteRecipesCubit(RecipeRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const Homepage(),
      ),
    );
  }
}
