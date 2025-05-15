import 'dart:ui';
import 'package:event_booking_app_ui/controllers/ticket_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatefulWidget {
  final EventModel event;
  static final GlobalKey _ticketKey = GlobalKey();

  const TicketScreen({super.key, required this.event});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with TickerProviderStateMixin {
  UserModel? user;
  String seat = '';
  final String orderNo = TicketController().generateOrderId();

  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadSeatNumber();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  Future<void> _fetchUserData() async {
    UserModel? fetchedUser = await UserController().fetchUserData();
    setState(() {
      user = fetchedUser;
    });
  }

  Future<void> _loadSeatNumber() async {
    String seatNumber =
        await TicketController().generateSeatNumber(widget.event.eventId);
    setState(() {
      seat = seatNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        title: const Text('My Ticket',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: RepaintBoundary(
                    key: TicketScreen._ticketKey,
                    child: _buildGlassTicketCard(context),
                  ),
                ),
              ),
            ),
            // _buildBottomActionBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassTicketCard(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                _buildEventImage(),
                const SizedBox(height: 20),
                Text(
                  widget.event.eventName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "${DateFormat('MMM dd, yyyy').format(widget.event.eventBegDate)} | ${widget.event.eventLocation}",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                const Divider(height: 30, color: Colors.grey),
                _buildTicketDetails(),
                const Divider(height: 30, color: Colors.grey),
                QrImageView(data: orderNo, version: QrVersions.auto, size: 180),
                const SizedBox(height: 16),
                Text(
                  "Present this QR code at the gate.",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    TicketController().saveTicket(widget.event, orderNo, seat);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Ticket confirmed and saved")),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Confirm Ticket"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        widget.event.eventImage,
        fit: BoxFit.fill,
        height: 180,
        width: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          height: 180,
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.broken_image, size: 40)),
        ),
      ),
    );
  }

  Widget _buildTicketDetails() {
    return Column(
      children: [
        _buildTicketRow("Name", user?.userName ?? "Loading..."),
        const SizedBox(height: 12),
        _buildTicketRow("Order No.", orderNo),
        const SizedBox(height: 12),
        _buildTicketRow("Date",
            DateFormat('MMM dd, yyyy').format(widget.event.eventBegDate)),
        const SizedBox(height: 12),
        _buildTicketRow("Seat", seat),
      ],
    );
  }

  Widget _buildTicketRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}
