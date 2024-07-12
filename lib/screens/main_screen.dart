import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/quiz_category_card.dart';
import 'history_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Your Skills'),
         backgroundColor: Colors.purple.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          padding: const EdgeInsets.all(16.0),
          children: [
            QuizCategoryCard(category: 'Flutter', imagePath: 'assets/Flutter.png'),
            QuizCategoryCard(category: 'React Native', imagePath: 'assets/React Native.png'),
            QuizCategoryCard(category: 'Python', imagePath: 'assets/Python.png'),
            QuizCategoryCard(category: 'C#', imagePath: 'assets/C#.png'),
            QuizCategoryCard(category: 'JavaScript', imagePath: 'assets/Javascript.webp'),
            QuizCategoryCard(category: 'Vue.js', imagePath: 'assets/VueJs.png'),
          ],
        ),
      ),
    );
  }
}