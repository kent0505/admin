import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils.dart';
import '../../core/widgets/buttons/delete_button.dart';
import '../home/bloc/home/home_bloc.dart';
import 'bloc/logs_bloc.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  void initState() {
    super.initState();
    context.read<LogsBloc>().add(CheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<LogsBloc>().add(StopTimerEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Logs'),
          actions: [
            BlocBuilder<LogsBloc, LogsState>(
              builder: (context, state) {
                if (state is LogsLoadedState) {
                  return _LogCount(lines: state.lines);
                }
                return Container();
              },
            ),
            DeleteButton(
              title: 'Delete logs?',
              onPressed: () {
                context.read<LogsBloc>().add(DeleteLogsEvent());
              },
            ),
          ],
        ),
        body: BlocListener<LogsBloc, LogsState>(
          listener: (context, state) {
            if (state is LogsDeletedState) {
              context.pop();
              context
                  .read<HomeBloc>()
                  .add(LoadHomeEvent(state.message, state.status));
            }

            if (state is LogsErrorState) {
              Utils.showToast(context, state.message, state.status, true);
            }
          },
          child: BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              if (state is LogsLoadedState) {
                return ListView.builder(
                  padding: const EdgeInsets.all(6),
                  reverse: true,
                  itemCount: state.logs.length,
                  itemBuilder: (context, index) {
                    final log = state.logs[index];

                    if (log.contains('ERROR')) {
                      return _LogText(log: log, error: true);
                    } else {
                      return _LogText(log: log);
                    }
                  },
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class _LogText extends StatelessWidget {
  const _LogText({
    required this.log,
    this.error,
  });

  final String log;
  final bool? error;

  @override
  Widget build(BuildContext context) {
    return Text(
      log,
      style: TextStyle(
        fontSize: 10,
        color: error == null ? Colors.black : Colors.redAccent,
      ),
    );
  }
}

class _LogCount extends StatelessWidget {
  const _LogCount({required this.lines});

  final int lines;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        lines.toString(),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
