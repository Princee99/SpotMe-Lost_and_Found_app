import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> itemDetails;

  const ItemDetailsScreen({Key? key, required this.itemDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          itemDetails['name'] ?? "Item Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[300],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (itemDetails['imageUrl'] != null &&
                    itemDetails['imageUrl'].toString().isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      itemDetails['imageUrl'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 20),
                _buildDetailRow("Type", itemDetails['type']),
                _buildDetailRow("Name", itemDetails['name']),
                _buildDetailRow("Location", itemDetails['location']),
                _buildDetailRow("Area", itemDetails['area']),
                _buildDetailRow("Date", itemDetails['date']),
                _buildDetailRow("Contact", itemDetails['contact']),
                _buildDetailRow("Description", itemDetails['description']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value ?? "Not available",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
