import 'package:wilpro/model/enum/state_task_enum.dart';

class StateTask {
  final String idTask;
  final String idQuantiyActivity;
  StateTaskEnum state;
  StateTask({required this.idTask, required this.state, required this.idQuantiyActivity});
}
