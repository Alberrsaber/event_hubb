import 'package:event_booking_app_ui/controllers/course_controller.dart';
import 'package:event_booking_app_ui/models/course_model.dart';
import 'package:event_booking_app_ui/models/program_Model.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

class CourseDetailsScreen extends StatefulWidget {
  final CourseModel course;

  const CourseDetailsScreen({Key? key, required this.course}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  List<ProgramModel> programs = [];

  @override
  void initState() {
    super.initState();
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    programs = await CourseController().getAllProgram(widget.course.courseId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.course_details),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Name
            Text(
              widget.course.courseName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
            ),
            const SizedBox(height: 16),

            // Course Description
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.description,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.course.courseDes,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Course Program Table
            Text(
              l10n.course_program,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(2),
                },
                children: [
                  // Table Header
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    children: [
                      _buildTableHeaderCell(l10n.program_name),
                      _buildTableHeaderCell(l10n.date),
                      _buildTableHeaderCell(l10n.time),
                      _buildTableHeaderCell(l10n.type),
                      _buildTableHeaderCell(l10n.location),
                    ],
                  ),
                  // Table Rows
                  ...programs.asMap().entries.map((entry) {
                    int index = entry.key;
                    ProgramModel program = entry.value;
                    bool isEven = index % 2 == 0;

                    return TableRow(
                      decoration: BoxDecoration(
                        color: isEven ? Colors.white : Colors.grey.shade50,
                      ),
                      children: [
                        _buildTableCell(program.programName),
                        _buildTableCell(program.programDate.join('\n')),
                        _buildTableCell(program.programTime),
                        _buildTableCell(program.programType, isChip: true),
                        _buildTableCell(program.programLocation),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isChip = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: isChip
          ? Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTypeColor(text),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : Text(
              text,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'lecture':
        return Colors.blue.shade600;
      case 'lab':
        return Colors.green.shade600;
      case 'workshop':
        return Colors.orange.shade600;
      case 'exam':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}
