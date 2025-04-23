import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:spotme/Screens/item_details.dart';
import 'package:spotme/Screens/lost.dart';
import 'package:spotme/Screens/found.dart';
import 'package:spotme/Screens/profile.dart';
import 'package:spotme/wrapper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // 0 for "Lost", 1 for "Found"
  TextEditingController _searchController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  String _searchQuery = "";

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(Wrapper());
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "SpotMe",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Navigate to Profile Screen
              print("Profile Icon Pressed");
              Get.to(ProfilePage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: _selectedIndex == 0
                    ? "Search Lost Items..."
                    : "Search Found Items...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // Handle Search Logic
                print("Search: $value");
              },
            ),
          ),
          // Content Area
          Expanded(
            child: _selectedIndex == 0 ? _buildLostItems() : _buildFoundItems(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Lost",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Found",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedIndex == 0) {
            // Navigate to Add Lost Item Screen
            print("Add Lost Item Pressed");
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => LostBottomSheet(),
            );
          } else {
            print("Add Found Item Pressed");
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => FoundBottomSheet(),
            );
          }
        },
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  // Fetch and Display "Lost" Items
  Widget _buildLostItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('items')
          .where('type', isEqualTo: 'lost') // Filter for "lost" items
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No lost items found."));
        }

        // Filter items based on search query
        final items = snapshot.data!.docs.where((item) {
          final name = item['name'].toString().toLowerCase();
          final location = item['location'].toString().toLowerCase();
          final search = _searchQuery.toLowerCase();
          return name.contains(search) || location.contains(search);
        }).toList();

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    item['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Location: ${item['location']}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsScreen(
                          itemDetails: item.data() as Map<String, dynamic>,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Fetch and Display "Found" Items
  Widget _buildFoundItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('items')
          .where('type', isEqualTo: 'found') // Filter for "found" items
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No found items found."));
        }

        // Filter items based on search query
        // Filter items based on search query
        final items = snapshot.data!.docs.where((item) {
          final name = item['name']?.toString().toLowerCase() ?? '';
          final location = item['location']?.toString().toLowerCase() ?? '';
          final search = _searchQuery.toLowerCase();
          return name.contains(search) || location.contains(search);
        }).toList();

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    item['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Location: ${item['location']}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsScreen(
                          itemDetails: item.data() as Map<String, dynamic>,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
