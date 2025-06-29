import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreen createState() => _ContactScreen();
}

class _ContactScreen extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      await UserController().sendEmail(
        name: _nameController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your message has been sent!'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );

      // Optionally clear the form
      _nameController.clear();
      _subjectController.clear();
      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView (
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Send us a message", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
        
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                SizedBox(height: 16),
        
                TextFormField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    labelText: "Subject",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter a subject' : null,
                ),
                SizedBox(height: 16),
        
                TextFormField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Message",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter your message' : null,
                ),
                SizedBox(height: 24),
        
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text("Send", style: TextStyle(color: Colors.white,fontSize: 16),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    ),
                  ),
                ),
        
                SizedBox(height: 30),
                Divider(),
                Text("Or email us directly:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                SelectableText("eventhub53@gmail.com", style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

