import 'package:flutter/material.dart';
import 'package:geometryhunter/constants.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:geometryhunter/gallery_store.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String selectedShape = "All";

  final List<String> shapeFilters = [
    "All",
    "Circle",
    "Rectangle",
    "Zigzag",
    "Triangle",
    "Square"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> allImages = GalleryStore.getTaggedImages();

    // Apply shape filter
    List<Map<String, dynamic>> filtered = selectedShape == "All"
        ? allImages
        : allImages.where((img) => img["shape"] == selectedShape).toList();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                //  Back
                GestureDetector(
                  onTap:()=> Get.back(),
                  child: Row(
                    children: const [
                      SizedBox(width: 12),
                      Icon(Icons.arrow_back_ios_rounded, size: 20),
                      Text(
                        "BACK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/gallery_icon.png'),
                      SizedBox(width: 10),
                      Text(
                        "Gallery",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: kPrimaryColor
                        ),
                      ),
                    ]
                ),
                const SizedBox(height: 10),
                Divider(
                  color: kPrimaryColor,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 20),
                // 🔘 Shape filters
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: shapeFilters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final shape = shapeFilters[index];
                      final isSelected = selectedShape == shape;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedShape = shape;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green : Colors.white,
                            border: Border.all(
                                color: isSelected
                                    ? Colors.green
                                    : Color(0xFF0FAF5F)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              shape == "All" ? "All shapes" : shape,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Color(0xFF0FAF5F),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),
                //image grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(item['path']),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            right: 6,
                            bottom: 6,
                            child: shapeIcon(item["shape"]),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget shapeIcon(String shape) {
    switch (shape) {
      case "Circle":
        return Icon(Icons.circle, color: Colors.white, size: 24);
      case "Rectangle":
        return Icon(Icons.crop_landscape, color: Colors.white, size: 24);
      case "Triangle":
        return Icon(Icons.change_history, color: Colors.white, size: 24);
      case "Zigzag":
        return Icon(Icons.waves, color: Colors.white, size: 24);
      case "Square":
        return Icon(Icons.crop_square, color: Colors.white, size: 24);
      default:
        return Container();
    }
  }
}

