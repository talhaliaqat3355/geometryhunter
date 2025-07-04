import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'package:get/get.dart';

class SelectShapeScreen extends StatelessWidget {
  final Function(String shape) onShapeSelected;

  const SelectShapeScreen({super.key, required this.onShapeSelected});

  final List<Map<String, dynamic>> shapes = const [
    {"name": "Rectangle", "icon": Icons.crop_16_9},
    {"name": "Square", "icon": Icons.crop_square},
    {"name": "Zigzag", "icon": Icons.waves},
    {"name": "Circle", "icon": Icons.circle_outlined},
    {"name": "Triangle", "icon": Icons.change_history},
    {"name": "Cross", "icon": Icons.close},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded, size: 18, color: kPrimaryColor),
                        SizedBox(width: 1),
                        Text(
                          "BACK",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "SELECT A SHAPE",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Shape Grid
                  Expanded(
                    child: GridView.builder(
                      itemCount: shapes.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final shape = shapes[index];
                        return GestureDetector(
                          onTap: () {
                            onShapeSelected(shape['name']);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                shape['icon'],
                                size: 48,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        onShapeSelected("Unknown");
                      },
                      child: const Text(
                        "Play without selecting shapes",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final randomShape = shapes[DateTime.now().second % shapes.length];
                        onShapeSelected(randomShape['name']);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 20),
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Select random shape",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
