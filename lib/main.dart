import 'package:blocapp/application/pages/posts/itemsbloc/items_bloc.dart';
import 'package:blocapp/application/pages/posts/loginbloc/login_bloc.dart';
import 'package:blocapp/application/pages/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/pages/widgets/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ItemsBloc(),
          child: const ItemsWrapper(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
          child: LoginScreen(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginScreen()),
    );
  }
}
