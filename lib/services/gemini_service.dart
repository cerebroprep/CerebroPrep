  import 'dart:convert';

  import 'package:google_generative_ai/google_generative_ai.dart';
  import '../models/question.dart';
  import 'package:flutter_dotenv/flutter_dotenv.dart';


  class GeminiService {
    static final String apiKey =
    dotenv.env['GEMINI_API_KEY'] ?? '';
    
    static Future<List<Question>> generateQuiz(
  String topic,
  String difficulty,
) async {
  if (apiKey.isEmpty) {
  throw StateError("Gemini API key is missing.");
}
      final model = GenerativeModel(
        model: 'gemini-3-flash-preview',
        apiKey: apiKey,
      );

      final prompt = """
You are an expert educational quiz creator.

Generate exactly 3 unique multiple-choice questions.

Topic: $topic

Difficulty: $difficulty

Rules:
- Generate questions appropriate for the selected difficulty.
- Each question must test a different concept.
- Avoid repeating commonly asked questions.
- Make every quiz different from previous quizzes.
- Create exactly 4 answer options.
- Only one option should be correct.
- Randomize the position of the correct answer.
- Return ONLY valid JSON.
- Do not use markdown.
- Do not include explanations or extra text.

Format exactly like this:

[
  {
    "question": "Question text",
    "options": [
      "Option A",
      "Option B",
      "Option C",
      "Option D"
    ],
    "correctAnswer": 0
  }
]
""";
try {
    final response = await model.generateContent([
      Content.text(prompt),
    ]);

    if (response.text == null || response.text!.isEmpty) {
      throw Exception("Gemini returned an empty response.");
    }

    String jsonString = response.text!;

    jsonString = jsonString
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    final start = jsonString.indexOf('[');
    final end = jsonString.lastIndexOf(']');

    if (start == -1 || end == -1) {
      throw Exception("Could not find JSON array.");
    }

    jsonString = jsonString.substring(start, end + 1);

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map((item) => Question.fromJson(item))
        .toList();
  } catch (e) {
  throw Exception("Gemini Error: $e");
}
}
  }