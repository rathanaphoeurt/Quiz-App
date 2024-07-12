import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class QuizCategoryCard extends StatelessWidget {
  final String category;
  final String imagePath;

  QuizCategoryCard({required this.category, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen(category: category)),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 50),
            SizedBox(height: 10),
            Text(category, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
