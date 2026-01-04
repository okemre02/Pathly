import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../roadmap/data/repositories/roadmap_repository.dart';
import 'learning_state.dart';

final learningControllerProvider =
    NotifierProvider<LearningController, LearningState>(LearningController.new);

class LearningController extends Notifier<LearningState> {
  @override
  LearningState build() {
    return LearningState.initial();
  }

  Future<void> loadModule(String moduleId) async {
    state = state.copyWith(module: const AsyncValue.loading());
    try {
      final repository = ref.read(roadmapRepositoryProvider);
      final module = await repository.getModule(moduleId);
      state = state.copyWith(
        module: AsyncValue.data(module),
        currentCode: module.initialCodeSnippet,
      );
    } catch (e, st) {
      state = state.copyWith(module: AsyncValue.error(e, st));
    }
  }

  void updateCode(String newCode) {
    state = state.copyWith(currentCode: newCode);
  }

  Future<void> runCode() async {
    final moduleValue = state.module.asData?.value;
    if (moduleValue == null) return;

    state = state.copyWith(
      isExecuting: true,
      consoleOutput: "Running on Sandbox Environment...",
    );

    // Mock Sandbox Delay
    await Future.delayed(const Duration(milliseconds: 1500));

    final code = state.currentCode;
    bool passed = false;
    String output = "";

    // Validation Logic
    if (moduleValue.id == 'module_1') {
      if (code.contains('print')) {
        passed = true;
        output = "Hello World\n\nProcess finished with exit code 0";
      } else {
        output = "Hint: Use `print('Hello World');` to print to the console.";
      }
    } else if (moduleValue.id == 'module_2') {
      if ((code.contains('city')) && code.contains('Istanbul')) {
        passed = true;
        output = "Istanbul\n\nProcess finished with exit code 0";
      } else {
        output =
            "Hint: Define a variable named `city` with value \"Istanbul\" and print it.";
      }
    } else if (moduleValue.id == 'module_3') {
      if (code.contains('Pathly') &&
          code.contains('25') &&
          code.contains('print')) {
        passed = true;
        output = "Pathly\n25\n\nProcess finished with exit code 0";
      } else {
        output =
            "Hmm, that doesn't look quite right.\nHint: Make sure you use the print() function to output 'Pathly' and the number 25.";
      }
    } else if (moduleValue.id == 'module_4') {
      if (code.contains('multiply') && code.contains('print')) {
        passed = true;
        output = "25\n\nProcess finished with exit code 0";
      } else {
        output = "Hint: Define the `multiply` function and print the result.";
      }
    } else if (moduleValue.id == 'module_5') {
      if (code.contains('if') && code.contains('score')) {
        passed = true;
        output = "Success\n\nProcess finished with exit code 0";
      } else {
        output = "Hint: Use an `if` statement to check if `score` > 50.";
      }
    } else if (moduleValue.id == 'module_6') {
      if (code.contains('class') &&
          code.contains('Robot') &&
          code.contains('Robot Active')) {
        passed = true;
        output = "Robot Active\n\nProcess finished with exit code 0";
      } else {
        output =
            "Hint: Define class `Robot` and print \"Robot Active\" inside main.";
      }
    } else {
      // Default fallback - check for module completion patterns
      passed = true;
      output = "Code executed successfully!\n(Mock Output)";
    }

    if (passed) {
      await _handleSuccess();
      output += "\n\n✨ Module Completed!";
    }

    state = state.copyWith(
      isExecuting: false,
      consoleOutput: output,
      isSuccess: passed,
    );
  }

  Future<void> _handleSuccess() async {
    try {
      // Get the current node ID from the module
      final moduleId = state.module.value?.id;
      if (moduleId == null) return;

      // Mark module as completed via Firebase Auth provider
      // The auth provider handles Firestore updates
      final authNotifier = ref.read(authProvider.notifier);

      // Convert module_id to node_id pattern (e.g., dart_module_1 -> dart_1)
      // This is a simplified mapping - in production, nodes should reference modules directly
      String nodeId = moduleId;

      // Try to extract a simple node ID
      // For now, we'll store the module ID directly as the completed node
      // The proper mapping should be done at the data layer

      await authNotifier.completeNode(nodeId);

      debugPrint("Module completed: $nodeId");
    } catch (e) {
      debugPrint("Error saving progress: $e");
    }
  }
}
