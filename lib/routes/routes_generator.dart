import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/countdown_cubit.dart';
import '../screens/home_page.dart';
import '../cubit/counter_cubit.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    //print("RouteSettings: ${settings.name}");

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<CounterCubit>(
                      create: (context) => CounterCubit(),
                    ),
                    BlocProvider<CountdownCubit>(
                      create: (context) => CountdownCubit(),
                    ),
                  ],
                  child: const MyHomePage(title: 'Flutter Bloc Test'),
                )

            //     BlocProvider<CounterCubit>(
            //   create: (context) => CounterCubit(),
            //   child: const MyHomePage(title: 'Flutter Bloc Test'),
            // ),
            );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
