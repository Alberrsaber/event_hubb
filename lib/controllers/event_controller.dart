import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get all events
  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection('Events').snapshots();
  }

// get event by id
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
      return null;
    }
  }

  // get events by category name
  Stream<QuerySnapshot> getEventsbyCategory(String category) {
    return _firestore.collection('Events').where('eventCategory', isEqualTo: category).snapshots();
  }

}
