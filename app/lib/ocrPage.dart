import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/services.dart'; // For loading assets
import 'package:path_provider/path_provider.dart'; // For temporary directory
import 'package:app/components/imageSelectionPage.dart';

class OCRPage extends StatefulWidget {
  const OCRPage({Key? key}) : super(key: key);

  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  String extractedText = "No text detected.";
  File? imageFile;

  // Load image from assets
  Future<void> loadAssetImage(String assetPath) async {
    try {
      // Load the image from assets as bytes
      final byteData = await rootBundle.load(assetPath);

      // Write the bytes to a unique temporary file
      final tempDir = await getTemporaryDirectory();
      final fileName = assetPath.split('/').last; // Use asset file name
      final tempFilePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      final tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      // Delete previous temp image file if it exists
      if (imageFile != null && await imageFile!.exists()) {
        await imageFile!.delete();
      }

      // Update the imageFile to display the new image
      setState(() {
        imageFile = tempFile;
      });

      // Extract text from the newly selected image
      extractTextFromImage(tempFile);
    } catch (e) {
      setState(() {
        extractedText = "Error loading asset image: $e";
      });
    }
  }

  // Perform text extraction from the image
  Future<void> extractTextFromImage(File file) async {
    final inputImage = InputImage.fromFile(file);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      setState(() {
        extractedText = recognizedText.text.isNotEmpty
            ? recognizedText.text
            : "No text detected.";
      });
    } catch (e) {
      setState(() {
        extractedText = "Error recognizing text: $e";
      });
    } finally {
      textRecognizer.close();
    }
  }

  // Navigate to the Image Selection Page
  void navigateToSelectionPage() async {
    final selectedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageSelectionPage(
          imagePaths: [
            'assets/images/chapter1.jpg',
            'assets/images/theHouse.jpg',
            'assets/images/prologue.jpg',
          ],
        ),
      ),
    );

    if (selectedImage != null) {
      debugPrint('Selected image: $selectedImage');
      // Load the new selected image after ensuring the state rebuilds
      setState(() {
        imageFile = null; // Clear old image to trigger UI rebuild
      });
      loadAssetImage(selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OCR Text Recognition"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: navigateToSelectionPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Select Image from List",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (imageFile != null)
              // Display the newly selected image
              Image.file(
                imageFile!,
                key: UniqueKey(), // Add this line
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20),
            const Text(
              "Extracted Text:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  extractedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
