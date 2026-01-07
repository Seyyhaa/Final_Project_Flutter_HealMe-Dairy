import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String date;
  final String greeting;
  final String avatarUrl;

  const HeaderCard({
    super.key,
    required this.date,
    required this.greeting,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 155, 199, 246),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(avatarUrl)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: const Color.fromARGB(255, 88, 177, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
