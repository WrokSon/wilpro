import 'package:wilpro/model/enum/state_task_enum.dart';

class StateTask {
  final int index;
  final String idTask;
  StateTaskEnum state;
  StateTask({required this.index ,required this.idTask, required this.state});
}
