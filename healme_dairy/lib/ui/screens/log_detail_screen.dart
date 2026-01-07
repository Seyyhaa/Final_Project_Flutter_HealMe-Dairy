import 'package:flutter/material.dart';
import 'package:healme_dairy/data/symptom_repository.dart';
import 'package:healme_dairy/models/log_entry.dart';
import 'package:intl/intl.dart';
import '../../models/log_item.dart';
import '../widgets/log_header.dart';
import '../widgets/save_button.dart';

class LogDetailScreen extends StatefulWidget {
  final LogItem symptom;

  const LogDetailScreen({super.key, required this.symptom});

  @override
  State<LogDetailScreen> createState() => _LogDetailScreenState();
}

class _LogDetailScreenState extends State<LogDetailScreen> {
  List<LogEntry> latestSymptoms = [];
  double _severity = 7;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();

  String get severityText {
    if (_severity < 3) return 'Mild';
    if (_severity < 7) return 'Moderate';
    return 'Severe';
  }

  Color severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return const Color.fromARGB(255, 213, 220, 88);
      case 'moderate':
        return const Color.fromARGB(255, 249, 170, 43);
      case 'severe':
        return const Color.fromARGB(255, 255, 67, 67);
      default:
        return const Color.fromARGB(255, 255, 175, 175);
    }
  }


  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  bool get _isFormValid {
    return true;
  }

  bool get isActivity => widget.symptom.type == Type.activity;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.symptom.type == Type.symptom
              ? 'Log Symptom'
              : 'Log Activities',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// Symptom header
            Center(
              child: LogHeader(
                icon: widget.symptom.icon,
                label: widget.symptom.label,
                color: isActivity
                    ? Colors.green
                    : const Color.fromARGB(255, 231, 24, 48),
              ),
            ),
            if (widget.symptom.type == Type.symptom) ...[
              const SectionTitle('Severity'),

              Center(
                child: Column(
                  children: [
                    Text(
                      _severity.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      severityText,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Slider(
                value: _severity,
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: severityColor(severityText),
                inactiveColor: Colors.grey.shade200,
                onChanged: (val) => setState(() => _severity = val),
              ),
            ],
            const SectionTitle('Time & Date'),
            CustomInputContainer(
              child: ListTile(
                title: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
                trailing: const Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                  size: 20,
                ),
                onTap: _pickDate,
              ),
            ),

            const SectionTitle('Notes (Optional)'),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add details...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SaveButton(
          enabled: _isFormValid,
          onPressed: () {
            final newLog = LogEntry(
              title: widget.symptom.label,
              severity: widget.symptom.type == Type.activity
                  ? null
                  : _severity.toInt(),
              date: _selectedDate,
              logItem: widget.symptom,
              descriptions: _notesController.text,
            );
            SymptomRepository.addLog(newLog);
            Navigator.pop(context, newLog);
          },
        ),
      ),
    );
  }
}
