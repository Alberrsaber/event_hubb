import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventController  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  // Get all events
  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection('Events').snapshots();
  }

  // Get event by ID
  Future<EventModel?> getEventbyId(String eventId) async {
    try {
      DocumentSnapshot eventDoc =
          await _firestore.collection('Events').doc(eventId).get();
      if (eventDoc.exists) {
        return EventModel.fromMap(
            eventDoc.data() as Map<String, dynamic>, eventDoc.id);
      } else {
        print("No event found with ID: $eventId");
      }
    } catch (e) {
      print("Error fetching event: $e");
    }
    return null;
  }

  // Get events by category
  Stream<QuerySnapshot> getEventsbyCategory(String category) {
    return _firestore
        .collection('Events')
        .where('eventCategory', isEqualTo: category)
        .snapshots();
  }

  // Get events bookmarks
  Stream<QuerySnapshot> getBookmarks() {
    return _firestore
        .collection('Events')
        .where('eventBookmarks', arrayContains: currentUser?.uid)
        .snapshots();
  }

  // Toggle bookmark
  Future<void> toggleBookmark(String eventId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final eventRef = _firestore.collection('Events').doc(eventId);
    final eventDoc = await eventRef.get();
    final data = eventDoc.data();

    if (data == null) return;

    List<dynamic> bookmarks = data['eventBookmarks'] ?? [];

    if (bookmarks.contains(user.uid)) {
      bookmarks.remove(user.uid);
    } else {
      bookmarks.add(user.uid);
    }

    await eventRef.update({'eventBookmarks': bookmarks});
  }
}
