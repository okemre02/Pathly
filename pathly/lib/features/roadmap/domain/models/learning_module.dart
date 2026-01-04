class LearningModule {
  final String id;
  final String title;
  final String instructionText; // Supports Rich Text / Markdown
  final String initialCodeSnippet;
  final List<Map<String, dynamic>> testCases; // JSON structure for validation
  final List<Map<String, String>>
  externalResources; // [ { "title": "Docs", "url": "..." } ]

  const LearningModule({
    required this.id,
    required this.title,
    required this.instructionText,
    required this.initialCodeSnippet,
    required this.testCases,
    this.externalResources = const [],
  });
}
