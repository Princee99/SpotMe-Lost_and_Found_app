import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotme/services/firestore_servcies.dart';
import 'package:intl/intl.dart';

class FoundBottomSheet extends StatefulWidget {
  const FoundBottomSheet({Key? key}) : super(key: key);

  @override
  _FoundBottomSheetState createState() => _FoundBottomSheetState();
}

class _FoundBottomSheetState extends State<FoundBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();
  final ImagePicker _picker = ImagePicker();

  File? selectedImage;
  String? uploadedImageUrl;
  bool isSubmitting = false;

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    dateController.dispose();
    areaController.dispose();
    contactController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.black,
              surface: Colors.grey[800]!,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[900],
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<String?> uploadImageToImgbb(File imageFile) async {
    const apiKey =
        'YOUR_IMGBB_KEY'; // 🔑 Replace with your imgbb key
    final url = Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey');

    final base64Image = base64Encode(await imageFile.readAsBytes());

    final response = await http.post(url, body: {
      'image': base64Image,
      'name': 'found_${DateTime.now().millisecondsSinceEpoch}',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['url'];
    } else {
      print("Upload error: ${response.body}");
      return null;
    }
  }

  // Helper method to show error messages consistently
  void _showErrorSnackBar(BuildContext context, String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color.fromARGB(255, 209, 46, 46).withOpacity(0.7),
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  bool validateForm() {
    // Check if name is empty
    if (nameController.text.trim().isEmpty) {
      _showErrorSnackBar(context, 'Item name is required');
      return false;
    }

    // Check if location is empty
    if (locationController.text.trim().isEmpty) {
      _showErrorSnackBar(context, 'Location is required');
      return false;
    }

    // Check if date is empty
    if (dateController.text.trim().isEmpty) {
      _showErrorSnackBar(context, 'Date is required');
      return false;
    }

    // Check if area is empty
    if (areaController.text.trim().isEmpty) {
      _showErrorSnackBar(context, 'Area is required');
      return false;
    }

    // Check if contact is empty or not a 10-digit number
    final contact = contactController.text.trim();
    if (contact.isEmpty) {
      _showErrorSnackBar(context, 'Contact information is required');
      return false;
    }

    if (contact.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(contact)) {
      _showErrorSnackBar(context, 'Contact must be a 10-digit mobile number');
      return false;
    }

    // Check if description is empty
    if (descriptionController.text.trim().isEmpty) {
      _showErrorSnackBar(context, 'Description is required');
      return false;
    }

    // Check if image is selected
    if (selectedImage == null) {
      _showErrorSnackBar(context, 'Please add an image of the found item');
      return false;
    }

    return true;
  }

  Future<void> submitForm() async {
    if (!validateForm()) {
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser!;

      if (selectedImage != null) {
        uploadedImageUrl = await uploadImageToImgbb(selectedImage!);
        if (uploadedImageUrl == null) {
          throw Exception("Failed to upload image");
        }
      }

      await firestoreService.addItem(
        type: "found",
        name: nameController.text.trim(),
        location: locationController.text.trim(),
        date: dateController.text.trim(),
        area: areaController.text.trim(),
        contact: contactController.text.trim(),
        description: descriptionController.text.trim(),
        userId: user.uid,
        imageUrl: uploadedImageUrl ?? "",
      );

      // Show success message
      Get.snackbar(
        'Success',
        'Found item added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 188, 55, 29),
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        isSubmitting = false;
      });
      _showErrorSnackBar(context, 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add Found Item",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 20),
            _buildTextField("Item Name", nameController),
            _buildTextField("Location", locationController),
            _buildDateField(),
            _buildTextField("Area", areaController),
            _buildTextField(
                "Contact Information (10-digit mobile)", contactController,
                keyboardType: TextInputType.phone),
            _buildTextField("Description", descriptionController, maxLines: 3),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: selectedImage == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                color: Colors.white54, size: 40),
                            SizedBox(height: 8),
                            Text("Tap to add image (Required)",
                                style: TextStyle(color: Colors.white54)),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(selectedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor:
                      Colors.white, // Different color from lost items
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isSubmitting
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextField(
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: "Date (Required)",
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(Icons.calendar_today, color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white),
        onTap: () => _selectDate(context),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: "$label (Required)",
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
