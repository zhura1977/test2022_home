import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownInitial> {
  CountdownCubit() : super(CountdownInitial(countdownValue: 0));

  void start() => emit(CountdownInitial(countdownValue: state.countdownValue + 1));
  void stop() => emit(CountdownInitial(countdownValue: state.countdownValue - 1));
}
