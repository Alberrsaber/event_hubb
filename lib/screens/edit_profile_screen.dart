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
  final _phoneController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _specialityController = TextEditingController();
  final _bioController = TextEditingController();

  List<CategoryModel> _allInterests = [];
  List<CategoryModel> _allCategories = [];



  UserModel? currentUser;

  final List<String> _qualifications = [
    "Faculty Member",
    "Student",
  ];

  final List<String> _specialities = [
    "Pharmacy","Medicine","Engineering","Sciences","Computers and Information","Education","Commerce","Nursing","Arts","Law"
  ];

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    _allInterests = await CategoryController().getCategoriesFav();
    currentUser = await UserController().fetchUserData();
    _allCategories = await CategoryController().getAllCategories();

    if (currentUser != null) {
      _nameController.text = currentUser!.userName;
      _phoneController.text = currentUser!.userPhone;
      _qualificationController.text = currentUser!.userQualification ?? "";
      _specialityController.text = currentUser!.userSpecialty ?? "";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileAvatar(),
                  const SizedBox(height: 24),
                  _buildEditableField("User Name", _nameController),
                  const SizedBox(height: 16),
                  _buildStaticField("Email Address", currentUser!.userEmail),
                  const SizedBox(height: 16),
                  _buildEditableField("Mobile Number", _phoneController),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: "Qualification",
                    value: _qualificationController.text,
                    items: _qualifications,
                    onChanged: (val) {
                      _qualificationController.text = val ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: "Speciality",
                    value: _specialityController.text,
                    items: _specialities,
                    onChanged: (val) {
                      _specialityController.text = val ?? '';
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel("Interests"),
                  _buildInterestsDropdown(),
                  _buildSelectedInterestsChips(),                  
                  const SizedBox(height: 32),
                  _buildSaveButton(),
                ],
              ),
            ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: MyTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _profileImage != null
              ? FileImage(_profileImage!)
              : (currentUser?.userImage != null
                  ? NetworkImage(currentUser!.userImage!)
                  : const NetworkImage("https://i.imgur.com/BoN9kdC.png")) as ImageProvider,
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.edit, size: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter $label",
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isNotEmpty ? value : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          hint: Text("Select $label"),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(label),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }


  Widget _buildInterestsDropdown() {
    return DropdownButtonFormField<CategoryModel>(
      value: null,
      hint: const Text("Select a category"),
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: _allCategories.map((category) {
        return DropdownMenuItem<CategoryModel>(
          value: category,
          child: Text(category.categoryName),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null && !_allInterests.contains(value)) {
          setState(() {
            _allInterests.add(value);
          });
        }
      },
    );
  }
   Widget _buildSelectedInterestsChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _allInterests.map((interest) {
        return Chip(
          label: Text(interest.categoryName),
          onDeleted: () {
            setState(() {
              _allInterests.remove(interest);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyTheme.primaryColor,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onPressed: () async {
        await UserController().updateUserData(
          userName: _nameController.text.trim(),
          bio: _bioController.text.trim(),
          
          // Add more fields if needed
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context);
      },
      child: const Text(
        'Save Changes',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
