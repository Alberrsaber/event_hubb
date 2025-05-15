import 'dart:ui';
import 'package:event_booking_app_ui/controllers/ticket_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/ticket_model.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class MyticketScreen extends StatefulWidget {
  final TicketModel ticket;
  static final GlobalKey _ticketKey = GlobalKey();

  const MyticketScreen({super.key, required this.ticket});

  @override
  State<MyticketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<MyticketScreen> with TickerProviderStateMixin {
  UserModel? user;

  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    

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

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        title: const Text('My Ticket', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    key: MyticketScreen._ticketKey,
                    child: _buildGlassTicketCard(context),
                  ),
                ),
              ),
            ),
             _buildBottomActionBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassTicketCard(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width ,
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
                  widget.ticket.eventName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "${DateFormat('MMM dd, yyyy').format(widget.ticket.eventBegDate)} | ${widget.ticket.eventLocation}",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                const Divider(height: 30, color: Colors.grey),
                _buildTicketDetails(),
                const Divider(height: 30, color: Colors.grey),
                QrImageView(data: widget.ticket.orderId, version: QrVersions.auto, size: 180),
                const SizedBox(height: 16),
                Text(
                  "Present this QR code at the gate.",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                
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
        widget.ticket.eventImage,
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
        _buildTicketRow("Order No.", widget.ticket.orderId),
        const SizedBox(height: 12),
        _buildTicketRow("Date", DateFormat('MMM dd, yyyy').format(widget.ticket.eventBegDate)),
        const SizedBox(height: 12),
        _buildTicketRow("Seat", widget.ticket.seat),
      ],
    );
  }

  Widget _buildTicketRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _iconAction(Icons.download, "Save", () {
            TicketController().saveTicketPhoto(MyticketScreen._ticketKey, context);
          }),
          _iconAction(Icons.share_outlined, "Share", () async {
            String? path = await TicketController().shareTicketPhoto(MyticketScreen._ticketKey, context);
            if (path != null) {
              Share.shareXFiles([XFile(path)], text: "Here's my ticket 🎟️");
            }
          }),
          
        ],
      ),
    );
  }

  Widget _iconAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Icon(icon, color: Colors.blueAccent),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
