import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection('Events').snapshots();
  }

  Stream<QuerySnapshot> getSearchEvents(String searchName) {
    return _firestore
        .collection('Events').orderBy('eventName').startAt([searchName]).endAt([searchName + '\uf8ff'])
        .snapshots();
        
  }
}
