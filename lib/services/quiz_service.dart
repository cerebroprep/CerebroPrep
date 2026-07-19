import '../models/question.dart';

class QuizService {
  static List<Question> getQuestions(String topic) {
    topic = topic.toLowerCase();

    if (topic.contains("cricket")) {
      return [
        Question(
          question: "How many players are in a cricket team?",
          options: ["9", "10", "11", "12"],
          correctAnswer: 2,
        ),
        Question(
          question: "What does LBW stand for?",
          options: [
            "Leg Before Wicket",
            "Long Bat Win",
            "Leg Bat Wide",
            "Last Ball Win"
          ],
          correctAnswer: 0,
        ),
        Question(
          question: "How many runs is a boundary?",
          options: ["2", "4", "5", "6"],
          correctAnswer: 1,
        ),
      ];
    }

    if (topic.contains("history")) {
      return [
        Question(
          question: "Who was Ashoka?",
          options: [
            "Scientist",
            "King",
            "Cricketer",
            "Writer"
          ],
          correctAnswer: 1,
        ),
        Question(
          question: "World War II ended in?",
          options: [
            "1945",
            "1947",
            "1939",
            "1950"
          ],
          correctAnswer: 0,
        ),
        Question(
          question: "Indus Valley Civilization was known for?",
          options: [
            "Space Travel",
            "Urban Planning",
            "Computers",
            "Railways"
          ],
          correctAnswer: 1,
        ),
      ];
    }

    return [
      Question(
        question: "What is Photosynthesis?",
        options: [
          "Process used by plants",
          "Animal respiration",
          "Water cycle",
          "Soil erosion"
        ],
        correctAnswer: 0,
      ),
      Question(
        question: "Which gas do plants absorb?",
        options: [
          "Oxygen",
          "Carbon Dioxide",
          "Nitrogen",
          "Hydrogen"
        ],
        correctAnswer: 1,
      ),
      Question(
        question: "Which part of the plant performs photosynthesis?",
        options: [
          "Roots",
          "Stem",
          "Leaves",
          "Flowers"
        ],
        correctAnswer: 2,
      ),
    ];
  }
}