import 'package:flutter/material.dart';
import 'package:healme_dairy/data/users_pref.dart';
import 'package:intl/intl.dart'; 
import 'package:healme_dairy/ui/widgets/empty_widget.dart';
import 'package:healme_dairy/ui/widgets/card_widget.dart';
import '../../widgets/header_card.dart';
import '../../widgets/section_header.dart';
import '../../../data/symptom_repository.dart';
import '../../../models/log_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LogEntry> displayedSymptoms = [];
  bool isExpanded = false;
  String name = '';
  

  @override
  void initState() {
    super.initState();
    _loadData();
    _getname();
  }

  void _loadData() {
    setState(() {
      displayedSymptoms = isExpanded
          ? SymptomRepository.getAllSymptomLog()
          : SymptomRepository.getLastestSymptomLog();
    });
  }

  void _views() {
    setState(() {
      isExpanded = !isExpanded;
      _loadData();
    });
  }

  Future<void> _getname() async {
    String? savedName = await UsersPref.getName();
    if (savedName != null && savedName.isNotEmpty) {
    setState(() {
      name = savedName;
    });
  }
  }

  String get _currentDateFormatted {
    return DateFormat('dd MMM, yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Consistent background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderCard(
                date: _currentDateFormatted,
                greeting: 'Welcome, $name!',
                avatarUrl: 'https://i.pravatar.cc/150?img=12',
              ),

              const SizedBox(height: 32),
              SectionHeader(
                title: isExpanded ? 'All History' : 'Latest Symptoms',
                actionText: isExpanded ? 'Show Less' : 'View All',
                onTap: _views,
              ),

              const SizedBox(height: 20),
              if (displayedSymptoms.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: EmptyWidget(
                      title: 'No Symptom Record',
                      subtitle: 'Track your health to see data here',
                      icon: Icons.healing,
                    ),
                  ),
                )
              /// DATA STATE
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedSymptoms.length,
                  itemBuilder: (context, index) {
                    return CardWidget(logEntry: displayedSymptoms[index]);
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
