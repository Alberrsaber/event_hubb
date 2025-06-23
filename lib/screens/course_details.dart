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

 Color _getTypeColor(String type) {
  final lowerType = type.toLowerCase().trim();
  print('programType: "$type", normalized: "$lowerType"');

  switch (lowerType) {
    case 'lecture':
    case 'lec':
      return Colors.blue.shade600;
    case 'lab':
      return Colors.green.shade600;
    case 'workshop':
    case 'ws':
      return Colors.orange.shade600;
    case 'exam':
    case 'ex':
      return Colors.red.shade600;
    case 'elective':
      return Colors.purple.shade600;
    case 'mandatory':
      return Colors.teal.shade700;
    default:
      return Colors.grey.shade600;
  }
}


  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    final double tableHeaderFontSize = screenWidth < 360 ? 10 : 12;
    final double tableCellFontSize = screenWidth < 360 ? 9 : 11;
    final double chipFontSize = screenWidth < 360 ? 8 : 10;
    final double paddingValue = screenWidth < 360 ? 6.0 : 8.0;

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
            Text(
              widget.course.courseName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark?Theme.of(context).cardColor: Colors.white,
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
                    // Course Description
            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark?Theme.of(context).cardColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        l10n.notes, // or use a string like 'Course Notes'
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      const SizedBox(height: 8),
      ...widget.course.courseNotes.map(
        (note) => Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            "- $note",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    ],
  ),
),

            Text(
              l10n.course_program,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: screenWidth - 32,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(screenWidth < 360 ? 2 : 2.5),
                    1: FlexColumnWidth(screenWidth < 360 ? 1.8 : 2),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(screenWidth < 360 ? 1.8 : 2),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      children: [
                        _buildTableHeaderCell(l10n.program_name, tableHeaderFontSize, paddingValue),
                        _buildTableHeaderCell(l10n.date, tableHeaderFontSize, paddingValue),
                        _buildTableHeaderCell(l10n.time, tableHeaderFontSize, paddingValue),
                        _buildTableHeaderCell(l10n.type, tableHeaderFontSize, paddingValue),
                        _buildTableHeaderCell(l10n.location, tableHeaderFontSize, paddingValue),
                      ],
                    ),
                    ...programs.asMap().entries.map((entry) {
                      int index = entry.key;
                      ProgramModel program = entry.value;
                      bool isEven = index % 2 == 0;

                      return TableRow(
                        decoration: BoxDecoration(
                          color:  Theme.of(context).brightness == Brightness.dark?Theme.of(context).cardColor: Colors.white,
                        ),
                        children: [
                          _buildTableCell(program.programName, tableCellFontSize, paddingValue),
                          _buildTableCell(program.programDate.join('\n'), tableCellFontSize, paddingValue),
                          _buildTableCell(program.programTime, tableCellFontSize, paddingValue),
                          _buildTableCell(program.programType, tableCellFontSize, paddingValue, 
                              isChip: true, chipFontSize: chipFontSize),
                          _buildTableCell(program.programLocation, tableCellFontSize, paddingValue),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, double fontSize, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTableCell(String text, double fontSize, double padding, 
      {bool isChip = false, double? chipFontSize}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: isChip
          ? Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: padding - 2,
                  vertical: padding - 4,
                ),
                decoration: BoxDecoration(
                  color: _getTypeColor(text),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: chipFontSize ?? fontSize - 1,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          : Text(
              text,
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}