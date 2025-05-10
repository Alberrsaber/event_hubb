import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatefulWidget {
  final EventModel event;
  
  const TicketScreen({super.key, required this.event});
  static final GlobalKey _ticketKey = GlobalKey();

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  UserModel? usser;
@override
  void initState() {
    super.initState();
    fetchUserDataAndSetState();
  }
Future<void> fetchUserDataAndSetState() async {
    UserModel? currentUser = await UserController().fetchUserData();
    setState(() {
      usser = currentUser;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: RepaintBoundary(
                  key: TicketScreen._ticketKey,
                  child: _buildTicketCard(context),
                ),
              ),
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'My Ticket',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEventImage(),
            const SizedBox(height: 16),
            _buildEventTitle(),
            const SizedBox(height: 4),
            _buildEventLocation(),
            const Divider(height: 30, color: Colors.grey),
            _buildTicketInfoRows(),
            const SizedBox(height: 20),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 16),
            _buildQrCode(),
            const SizedBox(height: 12),
            _buildScanInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          widget.event.eventImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildEventTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        widget.event.eventName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEventLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        "${DateFormat('MMM dd, yyyy').format(widget.event.eventBegDate)} ${widget.event.eventLocation}",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTicketInfoRows() {
    return Column(
      children: [
         TicketInfoRow(
          firstItem: TicketInfoItem(title: 'Name', value: usser?.userName ?? ""),
          secondItem: TicketInfoItem(title: 'Order No.', value: 'CLD09738PL'),
        ),
        const SizedBox(height: 12),
        TicketInfoRow(
          firstItem: TicketInfoItem(
              title: 'Date',
              value: DateFormat('MMM dd, yyyy').format(widget.event.eventBegDate)),
          secondItem: const TicketInfoItem(title: 'Seat', value: 'A21'),
        ),
      ],
    );
  }

  Widget _buildQrCode() {
    return QrImageView(
      data: 'https://yourapp.com/ticket/CLD09738PL',
      version: QrVersions.auto,
      size: 160,
    );
  }

  Widget _buildScanInstructions() {
    return Text(
      'Please present this QR code at the gate.',
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.save_alt,
            label: 'Save',
            onPressed: () {},
          ),
          _buildActionButton(
            icon: Icons.link,
            label: 'Copy Link',
            onPressed: () {},
          ),
          _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// TicketInfoRow widget
class TicketInfoRow extends StatelessWidget {
  final TicketInfoItem firstItem;
  final TicketInfoItem secondItem;

  const TicketInfoRow({
    super.key,
    required this.firstItem,
    required this.secondItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: firstItem),
        const SizedBox(width: 16),
        Expanded(child: secondItem),
      ],
    );
  }
}

// TicketInfoItem widget
class TicketInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const TicketInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
      ],
    );
  }
}
