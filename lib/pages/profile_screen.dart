import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> chronicDiseases = [];
  List<String> allergies = [];


  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
  String uid = _auth.currentUser!.uid;
  
  try {
    DocumentSnapshot snapshot = await _firestore.collection('profile').doc(uid).get();
    
    if (snapshot.exists) {
      // Get data from Firestore and populate the TextControllers and lists
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      
      setState(() {
        nameController.text = data['name'] ?? '';
        ageController.text = data['age']?.toString() ?? '';
        weightController.text = data['weight']?.toString() ?? '';
        heightController.text = data['height']?.toString() ?? '';
        genderController.text = data['gender'] ?? '';
        
        chronicDiseases = List<String>.from(data['chronicDiseases'] ?? []);
        allergies = List<String>.from(data['allergies'] ?? []);
      });
    }
  } catch (e) {
    print('Error loading profile: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to load profile data.'))
    );
  }
}


  Future<void> _saveProfile() async {
    String uid = _auth.currentUser!.uid;

    await _firestore.collection('profile').doc(uid).set({
      'name': nameController.text,
      'age': int.parse(ageController.text),
      'weight': double.parse(weightController.text),
      'height': double.parse(heightController.text),
      'gender': genderController.text,
      'chronicDiseases': chronicDiseases,
      'allergies': allergies,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile is saved succesfully'))
    );
  }

  void _addNewItem(List<String> list, String title){
    showDialog(
      context: context,
      builder: (BuildContext context){
        final TextEditingController itemController = TextEditingController();

        return AlertDialog(
          title: Text("Add $title"),
          content: TextField(
            controller: itemController,
            decoration: InputDecoration(hintText: "Enter $title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (itemController.text.isNotEmpty) {
                  setState(() {
                    list.add(itemController.text.trim());
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      }
    );
  }

  Widget _buildItemList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Text(item)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: const Text("Profile Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
            //Personal Details card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: weightController,
                      decoration: const InputDecoration(labelText: 'Weight (kg)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: heightController,
                      decoration: const InputDecoration(labelText: 'Height (cm)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: genderController,
                      decoration: const InputDecoration(labelText: 'Gender'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            //chroonoc Diseases Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chronic Diseases',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () => _addNewItem(chronicDiseases, "Chronic Diseases"),
                          icon: const Icon(Icons.add))
                      ],),
                      const SizedBox(height: 10),
                    _buildItemList(chronicDiseases),
                  ],
                ),
              )
            ),

            const SizedBox(height: 20),

            // Allergies Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Allergies',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _addNewItem(allergies, "Allergy"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildItemList(allergies),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Profile'),
            ),
          ]),
        ));
  }
}
