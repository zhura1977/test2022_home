// import 'package:flutter/material.dart';
// import 'routes/routes_generator.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter BLoC',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       onGenerateRoute: RouteGenerator.generateRoute,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: ThemeData(),
      home: MyHomePage(),
      // home: VibrateHomepage(),
    );
  }
}

late Timer tt; //= Timer(Duration(seconds: 1), () => {});
bool _isRunning = false;

class MyHomePage extends StatelessWidget {
  DataRepository dataRepository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<DataListCubit>(
        create: (context) => DataListCubit(dataRepository),
        child: Scaffold(
          body: BlocBuilder<DataListCubit, DataListState>(
            builder: (context, state) {
              print(state.data);
              if (state.data.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Pressed!!!");
                          tt?.cancel();
                        },
                        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                        style: ElevatedButton.styleFrom(elevation: 12.0, textStyle: const TextStyle(color: Colors.white)),
                        child: const Text('Elevated Button'),
                      ),

                      // TextButton(
                      //     onPressed: () {
                      //       print("Pressed!!!");
                      //
                      //       tt?.cancel();
                      //     },
                      //     child: Text("Stop!!!")),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          for (Map<String, dynamic> ff in state.data)
                            ListTile(
                              title: Text(ff['name']),
                              leading: Text(ff['id'].toString()),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('No Data'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DataRepository {
  DataRepository() {
    if (!_isRunning) {
      getData();
      _isRunning = true;
    }
  }

  DataApi dataApi = DataApi();
  List<Map<String, dynamic>> formattedData = [];
  final _controller = StreamController<List<Map<String, dynamic>>>();

  Future<void> getData() async {
    tt = Timer.periodic(const Duration(seconds: 5), (timer) async {
      Map<String, dynamic> el = dataApi.getNew();

      formattedData.add({'id': el['id'], 'name': el['name']});
      _controller.add(formattedData);
    });
  }

  Stream<List<Map<String, dynamic>>> data() async* {
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}

class DataApi {
  var rng = Random();
  Map<String, dynamic> getNew() {
    var rnd = rng.nextInt(100);
    return {"id": rnd, "name": "Person " + rnd.toString()};
  }
}

class DataListState {
  final List<Map<String, dynamic>> data;

  const DataListState(this.data);

  DataListState copyWith({List<Map<String, dynamic>>? data}) {
    return DataListState(data ?? this.data);
  }
}

class DataListCubit extends Cubit<DataListState> {
  final DataRepository dataRepository;

  DataListCubit(this.dataRepository) : super(DataListState([])) {
    loadList();
  }

  loadList() {
    dataRepository.data().listen((event) {
      if (event.isNotEmpty) {
        emit(state.copyWith(data: dataRepository.formattedData));
      }
    });
  }
}
