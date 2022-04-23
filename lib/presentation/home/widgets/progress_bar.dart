import 'package:flutter/material.dart';
import 'package:taskio/domain/entities/todo.dart';
import 'package:taskio/presentation/home/widgets/progress_bar_painter.dart';

class ProgressBar extends StatelessWidget {
  final List<Todo> todos;
  const ProgressBar({Key? key, required this.todos}) : super(key: key);

  double _getDoneTaskPercentage({required List<Todo> todos}) {
    int done = 0;
    for (var todo in todos) {
      if (todo.done) {
        done++;
      }
    }
    double percent = (1 / todos.length) * done;
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final _radius = BorderRadius.circular(10);
    return Material(
      elevation: 16,
      borderRadius: _radius,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your progress:",
                style: themeData.textTheme.headline1!.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: CustomPaint(
                        painter: ProgressPainter(
                          donePercent: _getDoneTaskPercentage(todos: todos),
                          defaultColor: Colors.grey,
                          percentageColor: const Color(0xff7ec9f5),
                          barHeight: 25,
                          maxBarWidth: constraints.maxWidth,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
