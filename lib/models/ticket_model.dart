class TicketModel {
  final String ticketNumber;
  final String ticketSeat;
  final String eventId;
  final String userId;
  final String ticketBarcode;

  TicketModel({
    required this.ticketNumber,
    required this.ticketSeat,
    required this.eventId,
    required this.userId,
    required this.ticketBarcode,
  });
  Map<String, dynamic> toMap() {
    return {
      'ticketNumber': ticketNumber,
      'ticketSeat': ticketSeat,
      'eventId': eventId,
      'userId': userId,
      'ticketBarcode': ticketBarcode,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> data, String documentId) {
    return TicketModel(
    ticketNumber: data['ticketNumber'] ?? '',
    ticketSeat: data['ticketSeat'] ?? '',
    eventId: data['eventId'] ?? '',
    userId: data['userId'] ?? '',
    ticketBarcode: data['ticketBarcode'] ?? '',
    );

  }
}
