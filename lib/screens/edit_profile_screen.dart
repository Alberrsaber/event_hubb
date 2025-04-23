import 'dart:io';
import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:event_booking_app_ui/my_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  List<CategoryModel> _selectedInterests = [];
  List<CategoryModel> _allInterests = [];

  

  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    _allInterests = await CategoryController().getCategoriesFav();
    currentUser = await UserController().fetchUserData();

    if (currentUser != null) {
      _nameController.text = currentUser!.userName;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
              : (currentUser?.userImage != null
                  ? NetworkImage(currentUser!.userImage!)
                  : const NetworkImage("https://i.imgur.com/BoN9kdC.png"))
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
        hintText: "Tell us something about yourself",
        hintStyle: const TextStyle(color: Colors.grey),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _allInterests.map((interest) {
            final isSelected = _selectedInterests.contains(interest);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedInterests.remove(interest);
                  } else {
                    _selectedInterests.add(interest);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color(interest.categoryColor)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? Color(interest.categoryColor)
                          : Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.network(
                      interest.categoryImage,
                      height: 40,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      interest.categoryName,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () async {
          await UserController().updateUserData(
            userName: _nameController.text.trim(),
            bio: _bioController.text.trim(),
                      );

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
      ),
    );
  }
}
