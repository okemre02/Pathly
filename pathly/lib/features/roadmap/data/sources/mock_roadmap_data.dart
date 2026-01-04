import '../../domain/models/roadmap_node.dart';
import '../../domain/models/roadmap_enums.dart';
import '../../domain/models/learning_module.dart';
import '../../domain/models/career_goal.dart';
import '../../domain/models/quick_start_path.dart';

class MockData {
  // ============ CAREER GOALS ============
  static const List<CareerGoal> careerGoals = [
    CareerGoal(
      id: 'mobile_dev',
      title: 'Mobile App Developer',
      description: 'Build iOS & Android apps with Flutter',
      iconName: 'phone_android',
      pathIds: ['dart', 'flutter', 'state_management'],
    ),
    CareerGoal(
      id: 'game_dev',
      title: 'Game Developer',
      description: 'Create games with Unity or Unreal',
      iconName: 'sports_esports',
      pathIds: ['csharp', 'unity', 'game_physics'],
    ),
    CareerGoal(
      id: 'data_scientist',
      title: 'Data Scientist',
      description: 'Analyze data and build ML models',
      iconName: 'analytics',
      pathIds: ['python', 'pandas', 'machine_learning'],
    ),
  ];

  // ============ QUICK START PATHS ============
  static const List<QuickStartPath> quickStartPaths = [
    QuickStartPath(
      id: 'quick_dart',
      title: 'Learn Dart',
      description: 'Modern language for Flutter apps',
      iconName: 'code',
      techId: 'dart',
    ),
    QuickStartPath(
      id: 'quick_python',
      title: 'Learn Python',
      description: 'Versatile language for any project',
      iconName: 'terminal',
      techId: 'python',
    ),
    QuickStartPath(
      id: 'quick_javascript',
      title: 'Learn JavaScript',
      description: 'The language of the web',
      iconName: 'web',
      techId: 'javascript',
    ),
    QuickStartPath(
      id: 'quick_cpp',
      title: 'Learn C++',
      description: 'High-performance systems programming',
      iconName: 'memory',
      techId: 'cpp',
    ),
    QuickStartPath(
      id: 'quick_csharp',
      title: 'Learn C#',
      description: 'Build games with Unity & Windows apps',
      iconName: 'sports_esports',
      techId: 'csharp',
    ),
    QuickStartPath(
      id: 'quick_java',
      title: 'Learn Java',
      description: 'Enterprise apps & Android development',
      iconName: 'android',
      techId: 'java',
    ),
  ];

  // ============ ROADMAPS BY TECH ID ============
  static Map<String, List<RoadmapNode>> get roadmapsByTechId => {
    'dart': dartRoadmap,
    'python': pythonRoadmap,
    'javascript': javascriptRoadmap,
    'cpp': cppRoadmap,
    'csharp': csharpRoadmap,
    'java': javaRoadmap,
  };

  /// ============ DART ROADMAP ============
  static final List<RoadmapNode> dartRoadmap = [
    RoadmapNode(
      id: "dart_1",
      title: "Dart Basics",
      description: "Introduction to Dart syntax and main function.",
      prerequisites: [],
      tutorialRefId: "dart_module_1",
      languageType: LanguageType.dart,
      status: NodeStatus.available,
      x: 0,
      y: 0,
    ),
    RoadmapNode(
      id: "dart_2",
      title: "Variables",
      description: "Understanding var, final, and const.",
      prerequisites: ["dart_1"],
      tutorialRefId: "dart_module_2",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 0,
      y: 150,
    ),
    RoadmapNode(
      id: "dart_3",
      title: "Data Types",
      description: "Int, Double, String, and Boolean.",
      prerequisites: ["dart_2"],
      tutorialRefId: "dart_module_3",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: -100,
      y: 300,
    ),
    RoadmapNode(
      id: "dart_4",
      title: "Functions",
      description: "Defining and calling functions.",
      prerequisites: ["dart_2"],
      tutorialRefId: "dart_module_4",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 100,
      y: 300,
    ),
    RoadmapNode(
      id: "dart_5",
      title: "Control Flow",
      description: "If-else, switch, and loops.",
      prerequisites: ["dart_3", "dart_4"],
      tutorialRefId: "dart_module_5",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 0,
      y: 450,
    ),
    RoadmapNode(
      id: "dart_6",
      title: "Classes & Objects",
      description: "Basics of Object Oriented Programming.",
      prerequisites: ["dart_5"],
      tutorialRefId: "dart_module_6",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 0,
      y: 600,
    ),
    // === ADVANCED DART ===
    RoadmapNode(
      id: "dart_7",
      title: "Lists & Collections",
      description: "Working with List, Set, and Map.",
      prerequisites: ["dart_6"],
      tutorialRefId: "dart_module_7",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: -100,
      y: 750,
    ),
    RoadmapNode(
      id: "dart_8",
      title: "Loops",
      description: "for, while, and for-in loops.",
      prerequisites: ["dart_6"],
      tutorialRefId: "dart_module_8",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 100,
      y: 750,
    ),
    RoadmapNode(
      id: "dart_9",
      title: "Error Handling",
      description: "try-catch and exceptions.",
      prerequisites: ["dart_7", "dart_8"],
      tutorialRefId: "dart_module_9",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 0,
      y: 900,
    ),
    RoadmapNode(
      id: "dart_10",
      title: "Async/Await",
      description: "Futures and asynchronous programming.",
      prerequisites: ["dart_9"],
      tutorialRefId: "dart_module_10",
      languageType: LanguageType.dart,
      status: NodeStatus.locked,
      x: 0,
      y: 1050,
    ),
  ];

  /// ============ PYTHON ROADMAP ============
  static final List<RoadmapNode> pythonRoadmap = [
    RoadmapNode(
      id: "py_1",
      title: "Python Basics",
      description: "Introduction to Python syntax.",
      prerequisites: [],
      tutorialRefId: "py_module_1",
      languageType: LanguageType.python,
      status: NodeStatus.available,
      x: 0,
      y: 0,
    ),
    RoadmapNode(
      id: "py_2",
      title: "Variables",
      description: "Creating and using variables.",
      prerequisites: ["py_1"],
      tutorialRefId: "py_module_2",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 0,
      y: 150,
    ),
    RoadmapNode(
      id: "py_3",
      title: "Data Types",
      description: "int, float, str, and bool.",
      prerequisites: ["py_2"],
      tutorialRefId: "py_module_3",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: -100,
      y: 300,
    ),
    RoadmapNode(
      id: "py_4",
      title: "Functions",
      description: "def keyword and function calls.",
      prerequisites: ["py_2"],
      tutorialRefId: "py_module_4",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 100,
      y: 300,
    ),
    RoadmapNode(
      id: "py_5",
      title: "Control Flow",
      description: "if, elif, else, and loops.",
      prerequisites: ["py_3", "py_4"],
      tutorialRefId: "py_module_5",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 0,
      y: 450,
    ),
    RoadmapNode(
      id: "py_6",
      title: "Classes",
      description: "Object-Oriented Programming in Python.",
      prerequisites: ["py_5"],
      tutorialRefId: "py_module_6",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 0,
      y: 600,
    ),
    // === ADVANCED PYTHON ===
    RoadmapNode(
      id: "py_7",
      title: "Lists & Tuples",
      description: "Working with sequences.",
      prerequisites: ["py_6"],
      tutorialRefId: "py_module_7",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: -100,
      y: 750,
    ),
    RoadmapNode(
      id: "py_8",
      title: "Dictionaries",
      description: "Key-value pairs and dict operations.",
      prerequisites: ["py_6"],
      tutorialRefId: "py_module_8",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 100,
      y: 750,
    ),
    RoadmapNode(
      id: "py_9",
      title: "Loops",
      description: "for, while, and list comprehensions.",
      prerequisites: ["py_7", "py_8"],
      tutorialRefId: "py_module_9",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 0,
      y: 900,
    ),
    RoadmapNode(
      id: "py_10",
      title: "File I/O",
      description: "Reading and writing files.",
      prerequisites: ["py_9"],
      tutorialRefId: "py_module_10",
      languageType: LanguageType.python,
      status: NodeStatus.locked,
      x: 0,
      y: 1050,
    ),
  ];

  /// ============ JAVASCRIPT ROADMAP ============
  static final List<RoadmapNode> javascriptRoadmap = [
    RoadmapNode(
      id: "js_1",
      title: "JS Basics",
      description: "Introduction to JavaScript.",
      prerequisites: [],
      tutorialRefId: "js_module_1",
      languageType: LanguageType.javascript,
      status: NodeStatus.available,
      x: 0,
      y: 0,
    ),
    RoadmapNode(
      id: "js_2",
      title: "Variables",
      description: "let, const, and var.",
      prerequisites: ["js_1"],
      tutorialRefId: "js_module_2",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 0,
      y: 150,
    ),
    RoadmapNode(
      id: "js_3",
      title: "Data Types",
      description: "Number, String, Boolean, and more.",
      prerequisites: ["js_2"],
      tutorialRefId: "js_module_3",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: -100,
      y: 300,
    ),
    RoadmapNode(
      id: "js_4",
      title: "Functions",
      description: "Function declarations and arrows.",
      prerequisites: ["js_2"],
      tutorialRefId: "js_module_4",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 100,
      y: 300,
    ),
    RoadmapNode(
      id: "js_5",
      title: "Control Flow",
      description: "if-else, switch, and loops.",
      prerequisites: ["js_3", "js_4"],
      tutorialRefId: "js_module_5",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 0,
      y: 450,
    ),
    RoadmapNode(
      id: "js_6",
      title: "Classes",
      description: "ES6 Classes and OOP.",
      prerequisites: ["js_5"],
      tutorialRefId: "js_module_6",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 0,
      y: 600,
    ),
    // === ADVANCED JAVASCRIPT ===
    RoadmapNode(
      id: "js_7",
      title: "Arrays",
      description: "Array methods: map, filter, reduce.",
      prerequisites: ["js_6"],
      tutorialRefId: "js_module_7",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: -100,
      y: 750,
    ),
    RoadmapNode(
      id: "js_8",
      title: "DOM Manipulation",
      description: "Selecting and modifying HTML elements.",
      prerequisites: ["js_6"],
      tutorialRefId: "js_module_8",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 100,
      y: 750,
    ),
    RoadmapNode(
      id: "js_9",
      title: "Promises",
      description: "Handling async operations with Promises.",
      prerequisites: ["js_7", "js_8"],
      tutorialRefId: "js_module_9",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 0,
      y: 900,
    ),
    RoadmapNode(
      id: "js_10",
      title: "Async/Await",
      description: "Modern async syntax in JavaScript.",
      prerequisites: ["js_9"],
      tutorialRefId: "js_module_10",
      languageType: LanguageType.javascript,
      status: NodeStatus.locked,
      x: 0,
      y: 1050,
    ),
  ];

  /// ============ C++ ROADMAP ============
  static final List<RoadmapNode> cppRoadmap = [
    RoadmapNode(
      id: "cpp_1",
      title: "C++ Basics",
      description: "Introduction to C++ and iostream.",
      prerequisites: [],
      tutorialRefId: "cpp_module_1",
      languageType: LanguageType.cpp,
      status: NodeStatus.available,
      x: 0,
      y: 0,
    ),
    RoadmapNode(
      id: "cpp_2",
      title: "Variables",
      description: "Declaring and initializing variables.",
      prerequisites: ["cpp_1"],
      tutorialRefId: "cpp_module_2",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 0,
      y: 150,
    ),
    RoadmapNode(
      id: "cpp_3",
      title: "Data Types",
      description: "int, double, char, and string.",
      prerequisites: ["cpp_2"],
      tutorialRefId: "cpp_module_3",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: -100,
      y: 300,
    ),
    RoadmapNode(
      id: "cpp_4",
      title: "Functions",
      description: "Function prototypes and definitions.",
      prerequisites: ["cpp_2"],
      tutorialRefId: "cpp_module_4",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 100,
      y: 300,
    ),
    RoadmapNode(
      id: "cpp_5",
      title: "Control Flow",
      description: "if-else, switch, for, and while.",
      prerequisites: ["cpp_3", "cpp_4"],
      tutorialRefId: "cpp_module_5",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 0,
      y: 450,
    ),
    RoadmapNode(
      id: "cpp_6",
      title: "Classes",
      description: "OOP fundamentals in C++.",
      prerequisites: ["cpp_5"],
      tutorialRefId: "cpp_module_6",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 0,
      y: 600,
    ),
    // === ADVANCED C++ ===
    RoadmapNode(
      id: "cpp_7",
      title: "Pointers",
      description: "Memory addresses and pointer operations.",
      prerequisites: ["cpp_6"],
      tutorialRefId: "cpp_module_7",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: -100,
      y: 750,
    ),
    RoadmapNode(
      id: "cpp_8",
      title: "Arrays",
      description: "Static and dynamic arrays.",
      prerequisites: ["cpp_6"],
      tutorialRefId: "cpp_module_8",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 100,
      y: 750,
    ),
    RoadmapNode(
      id: "cpp_9",
      title: "Loops",
      description: "for, while, do-while loops.",
      prerequisites: ["cpp_7", "cpp_8"],
      tutorialRefId: "cpp_module_9",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 0,
      y: 900,
    ),
    RoadmapNode(
      id: "cpp_10",
      title: "Templates",
      description: "Generic programming in C++.",
      prerequisites: ["cpp_9"],
      tutorialRefId: "cpp_module_10",
      languageType: LanguageType.cpp,
      status: NodeStatus.locked,
      x: 0,
      y: 1050,
    ),
  ];

  /// ============ C# ROADMAP ============
  static final List<RoadmapNode> csharpRoadmap = [
    RoadmapNode(
      id: "cs_1",
      title: "C# Basics",
      description: "Introduction to C# and Console.",
      prerequisites: [],
      tutorialRefId: "cs_module_1",
      languageType: LanguageType.csharp,
      status: NodeStatus.available,
      x: 0,
      y: 0,
    ),
    RoadmapNode(
      id: "cs_2",
      title: "Variables",
      description: "Declaring variables with types.",
      prerequisites: ["cs_1"],
      tutorialRefId: "cs_module_2",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 0,
      y: 150,
    ),
    RoadmapNode(
      id: "cs_3",
      title: "Data Types",
      description: "int, double, string, and bool.",
      prerequisites: ["cs_2"],
      tutorialRefId: "cs_module_3",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: -100,
      y: 300,
    ),
    RoadmapNode(
      id: "cs_4",
      title: "Methods",
      description: "Defining and calling methods.",
      prerequisites: ["cs_2"],
      tutorialRefId: "cs_module_4",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 100,
      y: 300,
    ),
    RoadmapNode(
      id: "cs_5",
      title: "Control Flow",
      description: "if-else, switch, and loops.",
      prerequisites: ["cs_3", "cs_4"],
      tutorialRefId: "cs_module_5",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 0,
      y: 450,
    ),
    RoadmapNode(
      id: "cs_6",
      title: "Classes",
      description: "OOP with C# classes.",
      prerequisites: ["cs_5"],
      tutorialRefId: "cs_module_6",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 0,
      y: 600,
    ),
    // === ADVANCED C# ===
    RoadmapNode(
      id: "cs_7",
      title: "Lists & Collections",
      description: "Working with List<T> and arrays.",
      prerequisites: ["cs_6"],
      tutorialRefId: "cs_module_7",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: -100,
      y: 750,
    ),
    RoadmapNode(
      id: "cs_8",
      title: "LINQ",
      description: "Query syntax and lambda expressions.",
      prerequisites: ["cs_6"],
      tutorialRefId: "cs_module_8",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 100,
      y: 750,
    ),
    RoadmapNode(
      id: "cs_9",
      title: "Exceptions",
      description: "try-catch and error handling.",
      prerequisites: ["cs_7", "cs_8"],
      tutorialRefId: "cs_module_9",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 0,
      y: 900,
    ),
    RoadmapNode(
      id: "cs_10",
      title: "Events & Delegates",
      description: "Event-driven programming in C#.",
      prerequisites: ["cs_9"],
      tutorialRefId: "cs_module_10",
      languageType: LanguageType.csharp,
      status: NodeStatus.locked,
      x: 0,
      y: 1050,
    ),
  ];

  /// ============ JAVA ROADMAP ============
  static final List<RoadmapNode> javaRoadmap = [
    RoadmapNode(
      id: "java_1",
      title: "Java Basics",
      description: "Introduction to Java and main method.",
      prerequisites: [],
      tutorialRefId: "java_module_1",
      languageType: LanguageType.java,
      status: NodeStatus.available,
      x: 0,
      y: 0,
    ),
    RoadmapNode(
      id: "java_2",
      title: "Variables",
      description: "Primitive types and declaration.",
      prerequisites: ["java_1"],
      tutorialRefId: "java_module_2",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 0,
      y: 150,
    ),
    RoadmapNode(
      id: "java_3",
      title: "Data Types",
      description: "int, double, String, and boolean.",
      prerequisites: ["java_2"],
      tutorialRefId: "java_module_3",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: -100,
      y: 300,
    ),
    RoadmapNode(
      id: "java_4",
      title: "Methods",
      description: "Defining and calling methods.",
      prerequisites: ["java_2"],
      tutorialRefId: "java_module_4",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 100,
      y: 300,
    ),
    RoadmapNode(
      id: "java_5",
      title: "Control Flow",
      description: "if-else, switch, for, and while.",
      prerequisites: ["java_3", "java_4"],
      tutorialRefId: "java_module_5",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 0,
      y: 450,
    ),
    RoadmapNode(
      id: "java_6",
      title: "Classes",
      description: "OOP fundamentals in Java.",
      prerequisites: ["java_5"],
      tutorialRefId: "java_module_6",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 0,
      y: 600,
    ),
    // === ADVANCED JAVA ===
    RoadmapNode(
      id: "java_7",
      title: "ArrayList",
      description: "Dynamic arrays with ArrayList.",
      prerequisites: ["java_6"],
      tutorialRefId: "java_module_7",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: -100,
      y: 750,
    ),
    RoadmapNode(
      id: "java_8",
      title: "Loops",
      description: "for, while, and enhanced for loops.",
      prerequisites: ["java_6"],
      tutorialRefId: "java_module_8",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 100,
      y: 750,
    ),
    RoadmapNode(
      id: "java_9",
      title: "Exceptions",
      description: "try-catch and custom exceptions.",
      prerequisites: ["java_7", "java_8"],
      tutorialRefId: "java_module_9",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 0,
      y: 900,
    ),
    RoadmapNode(
      id: "java_10",
      title: "Interfaces",
      description: "Contracts and polymorphism.",
      prerequisites: ["java_9"],
      tutorialRefId: "java_module_10",
      languageType: LanguageType.java,
      status: NodeStatus.locked,
      x: 0,
      y: 1050,
    ),
  ];

  /// Defines the Content for a specific module
  static List<LearningModule> get learningModules => modules.values.toList();

  /// ============ LEARNING MODULES ============
  static final Map<String, LearningModule> modules = {
    // ========== DART MODULES ==========
    "dart_module_1": const LearningModule(
      id: "dart_module_1",
      title: "Dart Basics",
      instructionText:
          "# Dart Basics\n\nWelcome to Dart! Dart is a modern, object-oriented language.\n\n**Task:**\nPrint 'Hello World' to the console.",
      initialCodeSnippet: "void main() {\n  // Print Hello World here\n}",
      testCases: [
        {"input": "", "output": "Hello World", "type": "exact_match"},
      ],
    ),
    "dart_module_2": const LearningModule(
      id: "dart_module_2",
      title: "Variables",
      instructionText:
          "# Variables\n\n- `var`: Type inferred\n- `final`: Set once\n- `const`: Compile-time constant\n\n**Task:**\nDeclare a variable `city` with value \"Istanbul\" and print it.",
      initialCodeSnippet:
          "void main() {\n  // Declare city here\n  \n  print(city);\n}",
      testCases: [
        {"input": "", "output": "Istanbul", "type": "exact_match"},
      ],
    ),
    "dart_module_3": const LearningModule(
      id: "dart_module_3",
      title: "Data Types",
      instructionText:
          "# Data Types\n\n- `int`: Integers\n- `double`: Decimals\n- `String`: Text\n- `bool`: true/false\n\n**Task:**\nCreate `age = 25` (int) and `name = \"Pathly\"` (String), then print them.",
      initialCodeSnippet:
          "void main() {\n  // Create variables\n  \n  print(name);\n  print(age);\n}",
      testCases: [
        {"input": "", "output": "Pathly\n25", "type": "exact_match"},
      ],
    ),
    "dart_module_4": const LearningModule(
      id: "dart_module_4",
      title: "Functions",
      instructionText:
          "# Functions\n\nFunctions wrap reusable logic.\n\n```dart\nvoid greet() {\n  print(\"Hi!\");\n}\n```\n\n**Task:**\nDefine `multiply()` that prints 5 * 5. Call it in main.",
      initialCodeSnippet:
          "void main() {\n  // Call multiply\n}\n\n// Define multiply here",
      testCases: [
        {"input": "", "output": "25", "type": "exact_match"},
      ],
    ),
    "dart_module_5": const LearningModule(
      id: "dart_module_5",
      title: "Control Flow",
      instructionText:
          "# Control Flow\n\n```dart\nif (x > 10) {\n  print(\"Big\");\n}\n```\n\n**Task:**\nIf `score` (80) > 50, print \"Success\".",
      initialCodeSnippet:
          "void main() {\n  int score = 80;\n  // Write if statement\n}",
      testCases: [
        {"input": "", "output": "Success", "type": "exact_match"},
      ],
    ),
    "dart_module_6": const LearningModule(
      id: "dart_module_6",
      title: "Classes",
      instructionText:
          "# Classes\n\nDart is object-oriented.\n\n**Task:**\nCreate a `Robot` class and print \"Robot Active\".",
      initialCodeSnippet:
          "class Robot {\n  // ...\n}\n\nvoid main() {\n  print(\"Robot Active\");\n}",
      testCases: [
        {"input": "", "output": "Robot Active", "type": "exact_match"},
      ],
    ),

    // ========== FLUTTER MODULES ==========
    "flutter_widgets": const LearningModule(
      id: "flutter_widgets",
      title: "Widget Fundamentals",
      instructionText:
          "# Flutter Widgets\n\nEverything in Flutter is a Widget.\n\n- `StatelessWidget`: Immutable\n- `StatefulWidget`: Mutable state\n\n**Task:**\nPrint 'Widget Built' to simulate a build method.",
      initialCodeSnippet:
          "void main() {\n  // Simulate build\n  print(\"Widget Built\");\n}",
      testCases: [
        {"input": "", "output": "Widget Built", "type": "exact_match"},
      ],
    ),
    "flutter_layouts": const LearningModule(
      id: "flutter_layouts",
      title: "Layouts & UI",
      instructionText:
          "# Layouts\n\nCommon layout widgets:\n- `Column`: Vertical\n- `Row`: Horizontal\n- `Stack`: Z-index layering\n\n**Task:**\nPrint 'Column Created' to simulated layout.",
      initialCodeSnippet: "void main() {\n  print(\"Column Created\");\n}",
      testCases: [
        {"input": "", "output": "Column Created", "type": "exact_match"},
      ],
    ),
    "flutter_nav": const LearningModule(
      id: "flutter_nav",
      title: "Navigation",
      instructionText:
          "# Navigation\n\nMoving between screens.\n\n```dart\nNavigator.push(context, route);\n```\n\n**Task:**\nPrint 'Navigated to Details'.",
      initialCodeSnippet:
          "void main() {\n  print(\"Navigated to Details\");\n}",
      testCases: [
        {"input": "", "output": "Navigated to Details", "type": "exact_match"},
      ],
    ),
    "flutter_state": const LearningModule(
      id: "flutter_state",
      title: "State Management",
      instructionText:
          "# State Management\n\nManaging app state effectively.\n\n- Riverpod\n- Provider\n- Bloc\n\n**Task:**\nPrint 'State Updated: 5'.",
      initialCodeSnippet:
          "void main() {\n  int count = 5;\n  print(\"State Updated: \$count\");\n}",
      testCases: [
        {"input": "", "output": "State Updated: 5", "type": "exact_match"},
      ],
    ),
    "flutter_api": const LearningModule(
      id: "flutter_api",
      title: "API Integration",
      instructionText:
          "# REST APIs\n\nFetching data from the internet using `http`.\n\n**Task:**\nPrint 'Data Fetched'.",
      initialCodeSnippet: "void main() {\n  print(\"Data Fetched\");\n}",
      testCases: [
        {"input": "", "output": "Data Fetched", "type": "exact_match"},
      ],
    ),
    "flutter_storage": const LearningModule(
      id: "flutter_storage",
      title: "Local Storage",
      instructionText:
          "# Local Storage\n\nSaving data on device.\n\n- SharedPreferences\n- Hive\n- SQLite\n\n**Task:**\nPrint 'Data Saved'.",
      initialCodeSnippet: "void main() {\n  print(\"Data Saved\");\n}",
      testCases: [
        {"input": "", "output": "Data Saved", "type": "exact_match"},
      ],
    ),
    "flutter_firebase": const LearningModule(
      id: "flutter_firebase",
      title: "Firebase Integration",
      instructionText:
          "# Firebase\n\nBackend as a Service.\n\n- Auth\n- Firestore\n- Storage\n\n**Task:**\nPrint 'Firebase Initialized'.",
      initialCodeSnippet:
          "void main() {\n  print(\"Firebase Initialized\");\n}",
      testCases: [
        {"input": "", "output": "Firebase Initialized", "type": "exact_match"},
      ],
    ),
    "py_module_1": const LearningModule(
      id: "py_module_1",
      title: "Python Basics",
      instructionText:
          "# Python Basics\n\nPython is simple and powerful!\n\n**Task:**\nPrint 'Hello World'.",
      initialCodeSnippet: "# Print Hello World here",
      testCases: [
        {"input": "", "output": "Hello World", "type": "exact_match"},
      ],
    ),
    "py_module_2": const LearningModule(
      id: "py_module_2",
      title: "Variables",
      instructionText:
          "# Variables\n\nNo type declaration needed!\n\n**Task:**\nCreate `city = \"Istanbul\"` and print it.",
      initialCodeSnippet: "# Create city variable\n\nprint(city)",
      testCases: [
        {"input": "", "output": "Istanbul", "type": "exact_match"},
      ],
    ),
    "py_module_3": const LearningModule(
      id: "py_module_3",
      title: "Data Types",
      instructionText:
          "# Data Types\n\n- `int`, `float`, `str`, `bool`\n\n**Task:**\nCreate `age = 25` and `name = \"Pathly\"`, print them.",
      initialCodeSnippet: "# Create variables\n\nprint(name)\nprint(age)",
      testCases: [
        {"input": "", "output": "Pathly\n25", "type": "exact_match"},
      ],
    ),
    "py_module_4": const LearningModule(
      id: "py_module_4",
      title: "Functions",
      instructionText:
          "# Functions\n\n```python\ndef greet():\n    print(\"Hi!\")\n```\n\n**Task:**\nDefine `multiply()` that prints 5 * 5.",
      initialCodeSnippet: "# Define function\n\nmultiply()",
      testCases: [
        {"input": "", "output": "25", "type": "exact_match"},
      ],
    ),
    "py_module_5": const LearningModule(
      id: "py_module_5",
      title: "Control Flow",
      instructionText:
          "# Control Flow\n\n```python\nif x > 10:\n    print(\"Big\")\n```\n\n**Task:**\nIf `score` (80) > 50, print \"Success\".",
      initialCodeSnippet: "score = 80\n# Write if statement",
      testCases: [
        {"input": "", "output": "Success", "type": "exact_match"},
      ],
    ),
    "py_module_6": const LearningModule(
      id: "py_module_6",
      title: "Classes",
      instructionText:
          "# Classes\n\n```python\nclass Car:\n    pass\n```\n\n**Task:**\nCreate `Robot` class, print \"Robot Active\".",
      initialCodeSnippet: "class Robot:\n    pass\n\nprint(\"Robot Active\")",
      testCases: [
        {"input": "", "output": "Robot Active", "type": "exact_match"},
      ],
    ),

    // ========== JAVASCRIPT MODULES ==========
    "js_module_1": const LearningModule(
      id: "js_module_1",
      title: "JS Basics",
      instructionText:
          "# JavaScript Basics\n\nThe language of the web!\n\n**Task:**\nPrint 'Hello World' using console.log.",
      initialCodeSnippet: "// Print Hello World",
      testCases: [
        {"input": "", "output": "Hello World", "type": "exact_match"},
      ],
    ),
    "js_module_2": const LearningModule(
      id: "js_module_2",
      title: "Variables",
      instructionText:
          "# Variables\n\n- `let`: Mutable\n- `const`: Immutable\n\n**Task:**\nCreate `city = \"Istanbul\"` and log it.",
      initialCodeSnippet: "// Create city\n\nconsole.log(city);",
      testCases: [
        {"input": "", "output": "Istanbul", "type": "exact_match"},
      ],
    ),
    "js_module_3": const LearningModule(
      id: "js_module_3",
      title: "Data Types",
      instructionText:
          "# Data Types\n\n- Number, String, Boolean\n\n**Task:**\nCreate `age = 25` and `name = \"Pathly\"`, log them.",
      initialCodeSnippet:
          "// Create variables\n\nconsole.log(name);\nconsole.log(age);",
      testCases: [
        {"input": "", "output": "Pathly\n25", "type": "exact_match"},
      ],
    ),
    "js_module_4": const LearningModule(
      id: "js_module_4",
      title: "Functions",
      instructionText:
          "# Functions\n\n```javascript\nfunction greet() {\n  console.log(\"Hi!\");\n}\n```\n\n**Task:**\nDefine `multiply()` that logs 5 * 5.",
      initialCodeSnippet: "// Define function\n\nmultiply();",
      testCases: [
        {"input": "", "output": "25", "type": "exact_match"},
      ],
    ),
    "js_module_5": const LearningModule(
      id: "js_module_5",
      title: "Control Flow",
      instructionText:
          "# Control Flow\n\n```javascript\nif (x > 10) {\n  console.log(\"Big\");\n}\n```\n\n**Task:**\nIf `score` (80) > 50, log \"Success\".",
      initialCodeSnippet: "let score = 80;\n// Write if statement",
      testCases: [
        {"input": "", "output": "Success", "type": "exact_match"},
      ],
    ),
    "js_module_6": const LearningModule(
      id: "js_module_6",
      title: "Classes",
      instructionText:
          "# ES6 Classes\n\n```javascript\nclass Car {}\n```\n\n**Task:**\nCreate `Robot` class, log \"Robot Active\".",
      initialCodeSnippet: "class Robot {}\n\nconsole.log(\"Robot Active\");",
      testCases: [
        {"input": "", "output": "Robot Active", "type": "exact_match"},
      ],
    ),

    // ========== C++ MODULES ==========
    "cpp_module_1": const LearningModule(
      id: "cpp_module_1",
      title: "C++ Basics",
      instructionText:
          "# C++ Basics\n\nHigh-performance systems language!\n\n**Task:**\nPrint 'Hello World' using cout.",
      initialCodeSnippet:
          "#include <iostream>\nusing namespace std;\n\nint main() {\n  // Print Hello World\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Hello World", "type": "exact_match"},
      ],
    ),
    "cpp_module_2": const LearningModule(
      id: "cpp_module_2",
      title: "Variables",
      instructionText:
          "# Variables\n\nMust declare type first.\n\n**Task:**\nCreate `string city = \"Istanbul\"` and print it.",
      initialCodeSnippet:
          "#include <iostream>\nusing namespace std;\n\nint main() {\n  // Create city\n  cout << city;\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Istanbul", "type": "exact_match"},
      ],
    ),
    "cpp_module_3": const LearningModule(
      id: "cpp_module_3",
      title: "Data Types",
      instructionText:
          "# Data Types\n\n- int, double, char, string\n\n**Task:**\nCreate `age = 25` (int) and `name = \"Pathly\"` (string), print them.",
      initialCodeSnippet:
          "#include <iostream>\nusing namespace std;\n\nint main() {\n  // Create variables\n  cout << name << endl << age;\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Pathly\n25", "type": "exact_match"},
      ],
    ),
    "cpp_module_4": const LearningModule(
      id: "cpp_module_4",
      title: "Functions",
      instructionText:
          "# Functions\n\n```cpp\nvoid greet() {\n  cout << \"Hi!\";\n}\n```\n\n**Task:**\nDefine `multiply()` that prints 5 * 5.",
      initialCodeSnippet:
          "#include <iostream>\nusing namespace std;\n\n// Define function\n\nint main() {\n  multiply();\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "25", "type": "exact_match"},
      ],
    ),
    "cpp_module_5": const LearningModule(
      id: "cpp_module_5",
      title: "Control Flow",
      instructionText:
          "# Control Flow\n\n```cpp\nif (x > 10) {\n  cout << \"Big\";\n}\n```\n\n**Task:**\nIf `score` (80) > 50, print \"Success\".",
      initialCodeSnippet:
          "#include <iostream>\nusing namespace std;\n\nint main() {\n  int score = 80;\n  // Write if statement\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Success", "type": "exact_match"},
      ],
    ),
    "cpp_module_6": const LearningModule(
      id: "cpp_module_6",
      title: "Classes",
      instructionText:
          "# Classes\n\n```cpp\nclass Car {};\n```\n\n**Task:**\nCreate `Robot` class, print \"Robot Active\".",
      initialCodeSnippet:
          "#include <iostream>\nusing namespace std;\n\nclass Robot {};\n\nint main() {\n  cout << \"Robot Active\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Robot Active", "type": "exact_match"},
      ],
    ),

    // ========== C# MODULES ==========
    "cs_module_1": const LearningModule(
      id: "cs_module_1",
      title: "C# Basics",
      instructionText:
          "# C# Basics\n\nPerfect for Unity games!\n\n**Task:**\nPrint 'Hello World' using Console.WriteLine.",
      initialCodeSnippet:
          "using System;\n\nclass Program {\n  static void Main() {\n    // Print Hello World\n  }\n}",
      testCases: [
        {"input": "", "output": "Hello World", "type": "exact_match"},
      ],
    ),
    "cs_module_2": const LearningModule(
      id: "cs_module_2",
      title: "Variables",
      instructionText:
          "# Variables\n\nStrong typing with `var` inference.\n\n**Task:**\nCreate `string city = \"Istanbul\"` and print it.",
      initialCodeSnippet:
          "using System;\n\nclass Program {\n  static void Main() {\n    // Create city\n    Console.WriteLine(city);\n  }\n}",
      testCases: [
        {"input": "", "output": "Istanbul", "type": "exact_match"},
      ],
    ),
    "cs_module_3": const LearningModule(
      id: "cs_module_3",
      title: "Data Types",
      instructionText:
          "# Data Types\n\n- int, double, string, bool\n\n**Task:**\nCreate `age = 25` and `name = \"Pathly\"`, print them.",
      initialCodeSnippet:
          "using System;\n\nclass Program {\n  static void Main() {\n    // Create variables\n    Console.WriteLine(name);\n    Console.WriteLine(age);\n  }\n}",
      testCases: [
        {"input": "", "output": "Pathly\n25", "type": "exact_match"},
      ],
    ),
    "cs_module_4": const LearningModule(
      id: "cs_module_4",
      title: "Methods",
      instructionText:
          "# Methods\n\n```csharp\nstatic void Greet() {\n  Console.WriteLine(\"Hi!\");\n}\n```\n\n**Task:**\nDefine `Multiply()` that prints 5 * 5.",
      initialCodeSnippet:
          "using System;\n\nclass Program {\n  // Define method\n  \n  static void Main() {\n    Multiply();\n  }\n}",
      testCases: [
        {"input": "", "output": "25", "type": "exact_match"},
      ],
    ),
    "cs_module_5": const LearningModule(
      id: "cs_module_5",
      title: "Control Flow",
      instructionText:
          "# Control Flow\n\n```csharp\nif (x > 10) {\n  Console.WriteLine(\"Big\");\n}\n```\n\n**Task:**\nIf `score` (80) > 50, print \"Success\".",
      initialCodeSnippet:
          "using System;\n\nclass Program {\n  static void Main() {\n    int score = 80;\n    // Write if statement\n  }\n}",
      testCases: [
        {"input": "", "output": "Success", "type": "exact_match"},
      ],
    ),
    "cs_module_6": const LearningModule(
      id: "cs_module_6",
      title: "Classes",
      instructionText:
          "# Classes\n\n```csharp\nclass Car {}\n```\n\n**Task:**\nCreate `Robot` class, print \"Robot Active\".",
      initialCodeSnippet:
          "using System;\n\nclass Robot {}\n\nclass Program {\n  static void Main() {\n    Console.WriteLine(\"Robot Active\");\n  }\n}",
      testCases: [
        {"input": "", "output": "Robot Active", "type": "exact_match"},
      ],
    ),

    // ========== JAVA MODULES ==========
    "java_module_1": const LearningModule(
      id: "java_module_1",
      title: "Java Basics",
      instructionText:
          "# Java Basics\n\nEnterprise-grade language!\n\n**Task:**\nPrint 'Hello World' using System.out.println.",
      initialCodeSnippet:
          "public class Main {\n  public static void main(String[] args) {\n    // Print Hello World\n  }\n}",
      testCases: [
        {"input": "", "output": "Hello World", "type": "exact_match"},
      ],
    ),
    "java_module_2": const LearningModule(
      id: "java_module_2",
      title: "Variables",
      instructionText:
          "# Variables\n\nStrong typing required.\n\n**Task:**\nCreate `String city = \"Istanbul\"` and print it.",
      initialCodeSnippet:
          "public class Main {\n  public static void main(String[] args) {\n    // Create city\n    System.out.println(city);\n  }\n}",
      testCases: [
        {"input": "", "output": "Istanbul", "type": "exact_match"},
      ],
    ),
    "java_module_3": const LearningModule(
      id: "java_module_3",
      title: "Data Types",
      instructionText:
          "# Data Types\n\n- int, double, String, boolean\n\n**Task:**\nCreate `age = 25` and `name = \"Pathly\"`, print them.",
      initialCodeSnippet:
          "public class Main {\n  public static void main(String[] args) {\n    // Create variables\n    System.out.println(name);\n    System.out.println(age);\n  }\n}",
      testCases: [
        {"input": "", "output": "Pathly\n25", "type": "exact_match"},
      ],
    ),
    "java_module_4": const LearningModule(
      id: "java_module_4",
      title: "Methods",
      instructionText:
          "# Methods\n\n```java\nstatic void greet() {\n  System.out.println(\"Hi!\");\n}\n```\n\n**Task:**\nDefine `multiply()` that prints 5 * 5.",
      initialCodeSnippet:
          "public class Main {\n  // Define method\n  \n  public static void main(String[] args) {\n    multiply();\n  }\n}",
      testCases: [
        {"input": "", "output": "25", "type": "exact_match"},
      ],
    ),
    "java_module_5": const LearningModule(
      id: "java_module_5",
      title: "Control Flow",
      instructionText:
          "# Control Flow\n\n```java\nif (x > 10) {\n  System.out.println(\"Big\");\n}\n```\n\n**Task:**\nIf `score` (80) > 50, print \"Success\".",
      initialCodeSnippet:
          "public class Main {\n  public static void main(String[] args) {\n    int score = 80;\n    // Write if statement\n  }\n}",
      testCases: [
        {"input": "", "output": "Success", "type": "exact_match"},
      ],
    ),
    "java_module_6": const LearningModule(
      id: "java_module_6",
      title: "Java OOP",
      instructionText:
          "# Java OOP\n\nClasses and Objects.\n\n**Task:**\nCreate `Robot` class, print \"Robot Online\".",
      initialCodeSnippet:
          "class Robot {\n  // ...\n}\n\npublic class Main {\n  public static void main(String[] args) {\n    System.out.println(\"Robot Online\");\n  }\n}",
      testCases: [
        {"input": "", "output": "Robot Online", "type": "exact_match"},
      ],
    ),

    // ========== UNITY MODULES ==========
    "unity_intro": const LearningModule(
      id: "unity_intro",
      title: "Unity Interface",
      instructionText:
          "# Unity Interface\n\nScenes, GameObjects, and Inspectors.\n\n**Task:**\nPrint 'Scene Loaded'.",
      initialCodeSnippet:
          "using UnityEngine;\n\npublic class Loader : MonoBehaviour {\n    void Start() {\n        Debug.Log(\"Scene Loaded\");\n    }\n}",
      testCases: [
        {"input": "", "output": "Scene Loaded", "type": "exact_match"},
      ],
    ),
    "unity_scripting": const LearningModule(
      id: "unity_scripting",
      title: "Scripting Basics",
      instructionText:
          "# MonoBehaviour\n\nLifecycle: Awake -> Start -> Update.\n\n**Task:**\nPrint 'Start Called' in Start method.",
      initialCodeSnippet: "void Start() {\n    Debug.Log(\"Start Called\");\n}",
      testCases: [
        {"input": "", "output": "Start Called", "type": "exact_match"},
      ],
    ),
    "unity_physics": const LearningModule(
      id: "unity_physics",
      title: "Physics",
      instructionText:
          "# Physics System\n\nRigidbody and Colliders.\n\n**Task:**\nPrint 'Collision Detected'.",
      initialCodeSnippet:
          "void OnCollisionEnter() {\n    Debug.Log(\"Collision Detected\");\n}",
      testCases: [
        {"input": "", "output": "Collision Detected", "type": "exact_match"},
      ],
    ),
    "unity_input": const LearningModule(
      id: "unity_input",
      title: "Input System",
      instructionText:
          "# Input\n\nHandling user input.\n\n**Task:**\nPrint 'Jump' when simulation starts.",
      initialCodeSnippet:
          "void Update() {\n    // Simulate input\n    Debug.Log(\"Jump\");\n}",
      testCases: [
        {"input": "", "output": "Jump", "type": "exact_match"},
      ],
    ),
    "unity_2d": const LearningModule(
      id: "unity_2d",
      title: "2D Game Dev",
      instructionText:
          "# 2D Games\n\nSprites and Tilemaps.\n\n**Task:**\nPrint 'Sprite Rendered'.",
      initialCodeSnippet:
          "void Start() {\n    Debug.Log(\"Sprite Rendered\");\n}",
      testCases: [
        {"input": "", "output": "Sprite Rendered", "type": "exact_match"},
      ],
    ),
    "unity_3d": const LearningModule(
      id: "unity_3d",
      title: "3D Game Dev",
      instructionText:
          "# 3D Games\n\nMeshes and Lighting.\n\n**Task:**\nPrint 'Mesh Loaded'.",
      initialCodeSnippet: "void Start() {\n    Debug.Log(\"Mesh Loaded\");\n}",
      testCases: [
        {"input": "", "output": "Mesh Loaded", "type": "exact_match"},
      ],
    ),
    "unity_ui": const LearningModule(
      id: "unity_ui",
      title: "UI System",
      instructionText:
          "# Unity UI\n\nCanvas, Text, Buttons.\n\n**Task:**\nPrint 'Button Clicked'.",
      initialCodeSnippet:
          "public void OnClick() {\n    Debug.Log(\"Button Clicked\");\n}",
      testCases: [
        {"input": "", "output": "Button Clicked", "type": "exact_match"},
      ],
    ),
    "unity_publish": const LearningModule(
      id: "unity_publish",
      title: "Publishing",
      instructionText:
          "# Build & Ship\n\nBuilding for platforms.\n\n**Task:**\nPrint 'Build Success'.",
      initialCodeSnippet:
          "void Build() {\n    Debug.Log(\"Build Success\");\n}",
      testCases: [
        {"input": "", "output": "Build Success", "type": "exact_match"},
      ],
    ),

    // ========== UNREAL MODULES ==========
    "unreal_intro": const LearningModule(
      id: "unreal_intro",
      title: "Unreal Editor",
      instructionText:
          "# Unreal Editor\n\nLevels and Actors.\n\n**Task:**\nPrint 'Level Loaded'.",
      initialCodeSnippet:
          "#include <iostream>\nint main() {\n  std::cout << \"Level Loaded\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Level Loaded", "type": "exact_match"},
      ],
    ),
    "unreal_blueprints": const LearningModule(
      id: "unreal_blueprints",
      title: "Blueprints",
      instructionText:
          "# Blueprints\n\nVisual Scripting.\n\n**Task:**\nPrint 'Blueprint Logic'.",
      initialCodeSnippet:
          "#include <iostream>\nint main() {\n  std::cout << \"Blueprint Logic\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Blueprint Logic", "type": "exact_match"},
      ],
    ),
    "unreal_cpp": const LearningModule(
      id: "unreal_cpp",
      title: "C++ in Unreal",
      instructionText:
          "# Unreal C++\n\nUCLASS and UPROPERTY.\n\n**Task:**\nPrint 'Actor Spawned'.",
      initialCodeSnippet:
          "#include <iostream>\nint main() {\n  std::cout << \"Actor Spawned\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Actor Spawned", "type": "exact_match"},
      ],
    ),
    "unreal_gameplay": const LearningModule(
      id: "unreal_gameplay",
      title: "Gameplay Framework",
      instructionText:
          "# Gameplay\n\nGameMode, Pawn, Controller.\n\n**Task:**\nPrint 'Game Started'.",
      initialCodeSnippet:
          "#include <iostream>\nint main() {\n  std::cout << \"Game Started\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Game Started", "type": "exact_match"},
      ],
    ),
    "unreal_rendering": const LearningModule(
      id: "unreal_rendering",
      title: "Rendering",
      instructionText:
          "# Rendering\n\nMaterials and Shaders.\n\n**Task:**\nPrint 'Shader Compiled'.",
      initialCodeSnippet:
          "#include <iostream>\nint main() {\n  std::cout << \"Shader Compiled\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Shader Compiled", "type": "exact_match"},
      ],
    ),
    "unreal_deploy": const LearningModule(
      id: "unreal_deploy",
      title: "Deployment",
      instructionText:
          "# Packaging\n\nShipping your game.\n\n**Task:**\nPrint 'Package Ready'.",
      initialCodeSnippet:
          "#include <iostream>\nint main() {\n  std::cout << \"Package Ready\";\n  return 0;\n}",
      testCases: [
        {"input": "", "output": "Package Ready", "type": "exact_match"},
      ],
    ),

    // ========== REACT NATIVE MODULES ==========
    "rn_components": const LearningModule(
      id: "rn_components",
      title: "Core Components",
      instructionText:
          "# Core Components\n\nView, Text, Image.\n\n**Task:**\nLog 'View Rendered'.",
      initialCodeSnippet: "console.log(\"View Rendered\");",
      testCases: [
        {"input": "", "output": "View Rendered", "type": "exact_match"},
      ],
    ),
    "rn_styling": const LearningModule(
      id: "rn_styling",
      title: "Styling",
      instructionText:
          "# Styling\n\nStyleSheet and Flexbox.\n\n**Task:**\nLog 'Styles Applied'.",
      initialCodeSnippet: "console.log(\"Styles Applied\");",
      testCases: [
        {"input": "", "output": "Styles Applied", "type": "exact_match"},
      ],
    ),
    "rn_navigation": const LearningModule(
      id: "rn_navigation",
      title: "Navigation",
      instructionText:
          "# React Navigation\n\nStack and Tab navigators.\n\n**Task:**\nLog 'Navigated'.",
      initialCodeSnippet: "console.log(\"Navigated\");",
      testCases: [
        {"input": "", "output": "Navigated", "type": "exact_match"},
      ],
    ),
    "rn_state": const LearningModule(
      id: "rn_state",
      title: "RN State",
      instructionText:
          "# State Management\n\nUsing Context or Redux.\n\n**Task:**\nLog 'State Change'.",
      initialCodeSnippet: "console.log(\"State Change\");",
      testCases: [
        {"input": "", "output": "State Change", "type": "exact_match"},
      ],
    ),
    "js_module_9": const LearningModule(
      id: "js_module_9",
      title: "Async JS",
      instructionText:
          "# Async JavaScript\n\nPromises and async/await.\n\n**Task:**\nLog 'Async Done'.",
      initialCodeSnippet: "console.log(\"Async Done\");",
      testCases: [
        {"input": "", "output": "Async Done", "type": "exact_match"},
      ],
    ),
    "react_basics": const LearningModule(
      id: "react_basics",
      title: "React Fundamentals",
      instructionText:
          "# React Basics\n\nComponents and Props.\n\n**Task:**\nLog 'Component Mounted'.",
      initialCodeSnippet: "console.log(\"Component Mounted\");",
      testCases: [
        {"input": "", "output": "Component Mounted", "type": "exact_match"},
      ],
    ),
    "react_hooks": const LearningModule(
      id: "react_hooks",
      title: "React Hooks",
      instructionText:
          "# Hooks\n\nuseState and useEffect.\n\n**Task:**\nLog 'Hook Effect'.",
      initialCodeSnippet: "console.log(\"Hook Effect\");",
      testCases: [
        {"input": "", "output": "Hook Effect", "type": "exact_match"},
      ],
    ),

    // ========== WEB DEV MODULES ==========
    "html_basics": const LearningModule(
      id: "html_basics",
      title: "HTML Basics",
      instructionText:
          "# HTML5\n\nTags and structure.\n\n**Task:**\nLog '<h1>Hello</h1>'.",
      initialCodeSnippet: "console.log(\"<h1>Hello</h1>\");",
      testCases: [
        {"input": "", "output": "<h1>Hello</h1>", "type": "exact_match"},
      ],
    ),
    "node_basics": const LearningModule(
      id: "node_basics",
      title: "Node.js Basics",
      instructionText:
          "# Node.js\n\nRuntime for JS.\n\n**Task:**\nLog 'Server Running'.",
      initialCodeSnippet: "console.log(\"Server Running\");",
      testCases: [
        {"input": "", "output": "Server Running", "type": "exact_match"},
      ],
    ),

    // ========== DATA ANALYST MODULES ==========
    "pydata_basics": const LearningModule(
      id: "pydata_basics",
      title: "Python for Data",
      instructionText:
          "# Python for Data Analysis\n\nLearn list comprehensions, slicing, and dictionary manipulation.\n\n**Task:**\nCreate a list of squares from 0 to 9.",
      initialCodeSnippet: "squares = [x**2 for x in range(10)]\nprint(squares)",
      testCases: [
        {
          "input": "",
          "output": "[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]",
          "type": "exact_match",
        },
      ],
    ),
    "sql_advanced": const LearningModule(
      id: "sql_advanced",
      title: "SQL Deep Dive",
      instructionText:
          "# Advanced SQL\n\nMastering JOINS, Subqueries and CTEs.\n\n**Task:**\nWrite a SELECT statement.",
      initialCodeSnippet: "SELECT * FROM users;",
      testCases: [],
    ),
    "pandas_cleaning": const LearningModule(
      id: "pandas_cleaning",
      title: "Data Cleaning",
      instructionText:
          "# Data Cleaning with Pandas\n\nHandling missing values (NaN) and duplicates.\n\n**Task:**\nDrop missing values from `df`.",
      initialCodeSnippet: "df.dropna(inplace=True)",
      testCases: [],
    ),
    "eda_basics": const LearningModule(
      id: "eda_basics",
      title: "Exploratory Data Analysis",
      instructionText:
          "# EDA\n\nUnderstand your data distribution with `.describe()` and `.info()`.\n\n**Task:**\nPrint summary statistics.",
      initialCodeSnippet: "print(df.describe())",
      testCases: [],
    ),
    "viz_advanced": const LearningModule(
      id: "viz_advanced",
      title: "Data Visualization",
      instructionText:
          "# Visualization\n\nCreate compelling plots with Matplotlib and Seaborn.\n\n**Task:**\nPlot a histogram.",
      initialCodeSnippet: "plt.hist(data)",
      testCases: [],
    ),
    "stats_basics": const LearningModule(
      id: "stats_basics",
      title: "Statistical Analysis",
      instructionText:
          "# Statistics\n\nMean, Median, Mode, Standard Deviation, and Hypothesis Testing.\n\n**Task:**\nCalculate the mean.",
      initialCodeSnippet: "mean = sum(data) / len(data)",
      testCases: [],
    ),
    "dashboarding": const LearningModule(
      id: "dashboarding",
      title: "Dashboarding Concepts",
      instructionText:
          "# Dashboarding\n\nPrinciples of designing effective dashboards in Tableau/PowerBI.\n\n**Task:**\nRead the article.",
      initialCodeSnippet: "# No code required",
      testCases: [],
    ),
    "da_capstone": const LearningModule(
      id: "da_capstone",
      title: "Data Analyst Capstone",
      instructionText:
          "# Capstone Project\n\nAnalyze a real-world dataset and present findings.\n\n**Task:**\nSubmit your notebook link.",
      initialCodeSnippet: "# Paste link here",
      testCases: [],
    ),

    // ========== FRONTEND MODULES ==========
    "html_css_basics": const LearningModule(
      id: "html_css_basics",
      title: "HTML & CSS Basics",
      instructionText:
          "# HTML & CSS\n\nBuilding the skeleton and skin of the web.\n\n**Task:**\nCreate a div with class 'container'.",
      initialCodeSnippet: "<div class='container'></div>",
      testCases: [],
    ),
    "js_essentials": const LearningModule(
      id: "js_essentials",
      title: "JavaScript Essentials",
      instructionText:
          "# JS Essentials\n\nES6+ features, arrow functions, and destructuring.\n\n**Task:**\nUse const.",
      initialCodeSnippet: "const pi = 3.14;",
      testCases: [],
    ),
    "dom_manipulation": const LearningModule(
      id: "dom_manipulation",
      title: "DOM Manipulation",
      instructionText:
          "# The DOM\n\nSelecting and changing HTML elements via JS.\n\n**Task:**\nSelect element by ID.",
      initialCodeSnippet: "document.getElementById('app');",
      testCases: [],
    ),
    "async_js": const LearningModule(
      id: "async_js",
      title: "Async JavaScript",
      instructionText:
          "# Async JS\n\nPromises and Async/Await.\n\n**Task:**\nFetch data from API.",
      initialCodeSnippet: "await fetch('url');",
      testCases: [],
    ),
    "fe_frameworks": const LearningModule(
      id: "fe_frameworks",
      title: "Frontend Frameworks",
      instructionText:
          "# React/Vue\n\nIntroduction to component-based architecture.\n\n**Task:**\nCreate a component.",
      initialCodeSnippet: "function App() { return <h1>Hi</h1>; }",
      testCases: [],
    ),
    "fe_state": const LearningModule(
      id: "fe_state",
      title: "State Management",
      instructionText:
          "# State Management\n\nManaging global app state.\n\n**Task:**\nUse useState.",
      initialCodeSnippet: "const [count, setCount] = useState(0);",
      testCases: [],
    ),

    // ========== BACKEND MODULES ==========
    "node_fundamentals": const LearningModule(
      id: "node_fundamentals",
      title: "Node.js Fundamentals",
      instructionText:
          "# Node.js\n\nRuntime, Event Loop, and Modules.\n\n**Task:**\nRequire a module.",
      initialCodeSnippet: "const fs = require('fs');",
      testCases: [],
    ),
    "express_framework": const LearningModule(
      id: "express_framework",
      title: "Express.js",
      instructionText:
          "# Express\n\nRouting and Middleware.\n\n**Task:**\nCreate a route.",
      initialCodeSnippet: "app.get('/', (req, res) => res.send('Hi'));",
      testCases: [],
    ),
    "rest_api": const LearningModule(
      id: "rest_api",
      title: "RESTful APIs",
      instructionText:
          "# REST\n\nDesigning proper API endpoints.\n\n**Task:**\nDefine a GET endpoint.",
      initialCodeSnippet: "// GET /users",
      testCases: [],
    ),
    "backend_db": const LearningModule(
      id: "backend_db",
      title: "Database Integration",
      instructionText:
          "# Connecting DB\n\nConnecting Node to SQL/NoSQL.\n\n**Task:**\nConnect to DB.",
      initialCodeSnippet: "mongoose.connect(url);",
      testCases: [],
    ),
    "backend_auth": const LearningModule(
      id: "backend_auth",
      title: "Authentication",
      instructionText: "# Auth\n\nJWT and Cookies.\n\n**Task:**\nSign a token.",
      initialCodeSnippet: "jwt.sign(payload, secret);",
      testCases: [],
    ),
    "backend_deploy": const LearningModule(
      id: "backend_deploy",
      title: "Deployment",
      instructionText:
          "# Deployment\n\nDeploying to Heroku/AWS.\n\n**Task:**\nSet PORT.",
      initialCodeSnippet: "const PORT = process.env.PORT || 3000;",
      testCases: [],
    ),

    // ========== FULLSTACK MODULES ==========
    "web_fundamentals": const LearningModule(
      id: "web_fundamentals",
      title: "Web Fundamentals",
      instructionText: "# Web Fundamentals\n\nHow the web works.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "js_advanced": const LearningModule(
      id: "js_advanced",
      title: "Advanced JS",
      instructionText: "# Advanced JS\n\nClosures, prototypes.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "db_design": const LearningModule(
      id: "db_design",
      title: "Database Design",
      instructionText: "# DB Design\n\nER Diagrams and Normalization.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "fs_backend": const LearningModule(
      id: "fs_backend",
      title: "Fullstack Backend",
      instructionText: "# Backend Logic\n\nAPI development.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "fs_frontend": const LearningModule(
      id: "fs_frontend",
      title: "Fullstack Frontend",
      instructionText: "# Frontend Integration\n\nConnecting to API.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "fs_state": const LearningModule(
      id: "fs_state",
      title: "Global State",
      instructionText: "# Global State\n\nRedux/Context.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "fs_devops": const LearningModule(
      id: "fs_devops",
      title: "DevOps",
      instructionText: "# CI/CD\n\nPipelines.",
      initialCodeSnippet: "",
      testCases: [],
    ),
    "fs_capstone": const LearningModule(
      id: "fs_capstone",
      title: "Capstone",
      instructionText: "# Final Project\n\nBuild a SaaS.",
      initialCodeSnippet: "",
      testCases: [],
    ),

    // ========== DATA SCIENCE / ML MODULES (Existing + New) ==========
    "math_ml": const LearningModule(
      id: "math_ml",
      title: "Math for ML",
      instructionText:
          "# Linear Algebra\n\nVectors and Matrices.\n\n**Task:**\nPrint 'Matrix Dot Product'.",
      initialCodeSnippet: "print('Matrix Dot Product')",
      testCases: [
        {"input": "", "output": "Matrix Dot Product", "type": "exact_match"},
      ],
    ),
    "ml_basics": const LearningModule(
      id: "ml_basics",
      title: "Scikit-Learn",
      instructionText:
          "# Scikit-Learn\n\nModel.fit().\n\n**Task:**\nPrint 'Model Trained'.",
      initialCodeSnippet: "print('Model Trained')",
      testCases: [
        {"input": "", "output": "Model Trained", "type": "exact_match"},
      ],
    ),
    "dl_basics": const LearningModule(
      id: "dl_basics",
      title: "Deep Learning",
      instructionText:
          "# Neural Networks\n\nLayers and Neurons.\n\n**Task:**\nPrint 'Epoch 1/10'.",
      initialCodeSnippet: "print('Epoch 1/10')",
      testCases: [
        {"input": "", "output": "Epoch 1/10", "type": "exact_match"},
      ],
    ),
  };
}
