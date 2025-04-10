import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:event_booking_app_ui/my_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: "Ashfak Sayem");
  final TextEditingController _bioController =
      TextEditingController(text: "UI/UX Designer | Photographer");

  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final List<Map<String, dynamic>> _allInterests = [
    {"name": "Sports", "color": Colors.red},
    {"name": "Music", "color": Colors.orange},
    {"name": "Tech", "color": Colors.green},
    {"name": "Art", "color": Colors.blue},
    {"name": "Travel", "color": Colors.teal},
  ];

  List<Map<String, dynamic>> _interests = [];

  @override
  void initState() {
    super.initState();
    _interests = List<Map<String, dynamic>>.from(_allInterests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileAvatar(),
            const SizedBox(height: 30),
            _buildNameField(),
            const SizedBox(height: 30),
            _buildLabel("About Me"),
            const SizedBox(height: 8),
            _buildBioField(),
            const SizedBox(height: 30),
            _buildLabel("Interests"),
            const SizedBox(height: 12),
            _buildInterestsSection(),
            const SizedBox(height: 80),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Edit Profile",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      backgroundColor: MyTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _profileImage != null
              ? FileImage(_profileImage!)
              : const NetworkImage("https://i.imgur.com/BoN9kdC.png")
                  as ImageProvider,
        ),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyTheme.primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBioField() {
    return TextFormField(
      controller: _bioController,
      maxLines: 3,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInterestsSection() {
    final availableToAdd = _allInterests.where((item) =>
      !_interests.any((i) => i["name"] == item["name"])).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _interests.map((interest) {
            return Chip(
              label: Text(
                interest["name"] as String,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: interest["color"] as Color,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              deleteIcon: const Icon(Icons.close, size: 18, color: Colors.white),
              onDeleted: () {
                setState(() {
                  _interests.remove(interest);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${interest["name"]} removed')),
                );
              },
            );
          }).toList(),
        ),

        if (availableToAdd.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            "Add Interests Back",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: availableToAdd.map((interest) {
              return ActionChip(
                label: Text(interest["name"]),
                backgroundColor: interest["color"],
                labelStyle: const TextStyle(color: Colors.white),
                onPressed: () {
                  setState(() {
                    _interests.add(interest);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${interest["name"]} added back')),
                  );
                },
              );
            }).toList(),
          ),
        ]
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Save logic here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes saved')),
        );
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: MyTheme.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: const Center(
          child: Text(
            'SAVE CHANGES',
            style: TextStyle(
              color: MyTheme.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
