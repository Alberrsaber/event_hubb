import 'package:flutter/material.dart';

class HelpsScreen extends StatelessWidget {
  final List<Map<String, String>> faqData = [
    {
      "question": "How do I register for an event?",
      "answer": "Tap on any event and press the 'Register' button. You will get a confirmation instantly."
    },
    {
      "question": "How will I get event updates?",
      "answer": "You will receive push notifications and updates inside the app under the 'Notifications' tab."
    },
    {
      "question": "Do I need an account to use EventHub?",
      "answer": "Yes, you must sign in with your university email to access and register for events."
    },
    {
      "question": "What if I face a technical issue?",
      "answer": "Go to 'Support' in the app menu or email us at support@eventhub.com."
    },
    {
      "question": "How do I see the events I registered for?",
      "answer": "Open the 'My Events' tab to view all your registered and upcoming events."
    },
    {
      "question": "Can I share an event with my friends?",
      "answer": "Yes, each event page has a 'Share' button to send it via social media or messaging apps."
    },
    {
      "question": "How do I search for events by category?",
      "answer": "Use the filter icon on the home screen to browse events by category, date, or location."
    },
    {
      "question": "Will I get a reminder before an event starts?",
      "answer": "Yes, reminders will be sent a few hours before the event as push notifications."
    },
    {
      "question": "Is there a limit to how many events I can join?",
      "answer": "No, you can register for as many events as you want unless the event is full."
    },
  {
      "question": "Will I get a reminder for upcoming events?",
      "answer": "Yes, reminders will be sent as long as you have chosen these events category in your interests and you will recive notifications."
    },
    {
      "question": "How do I update my profile information?",
      "answer": "Go to the 'Profile' tab and click 'Edit' to update your name, photo, or contact info."
    },
    {
      "question": "Can I access past events ?",
      "answer": " All the past events are shown in the explore screen on section called past events "
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & FAQ"),
         backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqData[index]['question']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqData[index]['answer']!),
              )
            ],
          );
        },
      ),
    );
  }
}
