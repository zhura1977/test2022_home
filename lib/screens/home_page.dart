import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';
import '../cubit/countdown_cubit.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterCubit, CounterInitial>(
            builder: (context, state) {
              return Text(state.counterValue.toString());
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBtn("Sub", () => BlocProvider.of<CounterCubit>(context).decrement()),
              buildBtn("Add", () => BlocProvider.of<CounterCubit>(context).increment()),
              //buildBtn("Multiply2", () => BlocProvider.of<CounterCubit>(context).multiply2()),
              //buildBtn("Print", () => BlocProvider.of<CounterCubit>(context).printNum()), //print("AAA: " + BlocProvider.of<CounterCubit>(context).state.counterValue.toString())),
            ],
          ),
          const SizedBox(height: 50),
          BlocBuilder<CountdownCubit, CountdownInitial>(
            builder: (context, state) {
              return Text(state.countdownValue.toString());
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBtn("Start", () => BlocProvider.of<CountdownCubit>(context).start()),
              buildBtn("Stop", () => BlocProvider.of<CountdownCubit>(context).stop()),
              //buildBtn("Multiply2", () => BlocProvider.of<CounterCubit>(context).multiply2()),
              //buildBtn("Print", () => BlocProvider.of<CounterCubit>(context).printNum()), //print("AAA: " + BlocProvider.of<CounterCubit>(context).state.counterValue.toString())),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBtn(String text, Function myFunction) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: () => myFunction(), child: Text(text)),
      );
}
