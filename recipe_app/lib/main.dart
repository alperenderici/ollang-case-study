import 'package:flutter/material.dart';
import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/recipe_detail_cubit.dart';
import 'package:recipe_app/ui/pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/cubit/homepage_cubit.dart';

void main() {
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
          create: (context) => RecipeDetailCubit(),
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
