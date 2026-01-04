import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../roadmap/domain/models/learning_module.dart';

class LearningState {
  final AsyncValue<LearningModule> module;
  final String currentCode;
  final String consoleOutput;
  final bool isExecuting;
  final bool isSuccess;
  final String? currentNodeId;

  const LearningState({
    required this.module,
    this.currentCode = '',
    this.consoleOutput = '',
    this.isExecuting = false,
    this.isSuccess = false,
    this.currentNodeId,
  });

  factory LearningState.initial() {
    return const LearningState(module: AsyncValue.loading());
  }

  LearningState copyWith({
    AsyncValue<LearningModule>? module,
    String? currentCode,
    String? consoleOutput,
    bool? isExecuting,
    bool? isSuccess,
    String? currentNodeId,
  }) {
    return LearningState(
      module: module ?? this.module,
      currentCode: currentCode ?? this.currentCode,
      consoleOutput: consoleOutput ?? this.consoleOutput,
      isExecuting: isExecuting ?? this.isExecuting,
      isSuccess: isSuccess ?? this.isSuccess,
      currentNodeId: currentNodeId ?? this.currentNodeId,
    );
  }
}
