import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskState());
}
