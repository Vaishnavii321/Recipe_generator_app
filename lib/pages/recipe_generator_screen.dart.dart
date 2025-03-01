import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RecipeGeneratorScreen extends StatefulWidget {
  const RecipeGeneratorScreen({super.key});

  @override
  State<RecipeGeneratorScreen> createState() => _RecipeGeneratorScreenState();
}

class _RecipeGeneratorScreenState extends State<RecipeGeneratorScreen> {
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController mealTypeController = TextEditingController();
  final TextEditingController cuisinePreferenceController =
      TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController complexityController = TextEditingController();

  bool _isLoading = false;
  String _generatedRecipe = '';

  // Initialize the Generative Model with the API key
  final String? apiKey = dotenv.env['API_KEY']; // Set your API Key
  late GenerativeModel model;

  @override
  void initState() {
    super.initState();
    if (apiKey == null) {
      throw Exception('API_KEY is not set in environment variables.');
    }
    model = GenerativeModel(
      model: 'gemini-1.5-flash', // Use your Gemini model version
      apiKey: apiKey!,
    );
  }

  Future<void> generateRecipe() async {
    setState(() {
      _isLoading = true;
      _generatedRecipe = '';
    });

    // Prepare the user input for the prompt
    final prompt = '''
          Generate a recipe based on the following details:
          Ingredients: ${ingredientsController.text}
          Meal Type: ${mealTypeController.text}
          Cuisine Preference: ${cuisinePreferenceController.text}
          Cooking Time: ${cookingTimeController.text}
          Complexity: ${complexityController.text}.
          ''';

    try {
      // Use Gemini API to generate content
      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        _generatedRecipe = response.text ?? 'No recipe generated. Try again!';
      });
    } catch (e) {
      setState(() {
        _generatedRecipe = 'Error generating recipe: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text('Recipe Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ingredients",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: ingredientsController,
                decoration: InputDecoration(
                  hintText: "Enter ingredients",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Meal Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: mealTypeController,
                decoration: InputDecoration(
                  hintText: "Enter meal type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Cuisine Preference",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cuisinePreferenceController,
                decoration: InputDecoration(
                  hintText: "e.g., Italian, Mexican",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Cooking Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cookingTimeController,
                decoration: InputDecoration(
                  hintText: "e.g., 30 minutes",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Complexity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: complexityController,
                decoration: InputDecoration(
                  hintText: "e.g., beginner, advanced, intermediate",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : generateRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Generate Recipe",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              if (_generatedRecipe.isNotEmpty)
                Text(
                  _generatedRecipe,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
