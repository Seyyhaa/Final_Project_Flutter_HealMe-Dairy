import 'package:flutter/material.dart';
import 'package:healme_dairy/models/log_entry.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  final LogEntry logEntry;

  const CardWidget({super.key, required this.logEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            // Colored Left Border
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: logEntry.logItem.type.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Icon(
                logEntry.logItem.icon,
                size: 40,
                color: logEntry.logItem.type.color,
              ),
            ),
            const SizedBox(width: 15),
            
            // Text Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          logEntry.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(logEntry.date),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (logEntry.severity != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: logEntry.logItem.type.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Pain level: ${logEntry.severity}/10",
                          style: TextStyle(
                            color: logEntry.logItem.type.color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    if (logEntry.descriptions.isNotEmpty)
                      Text(
                        logEntry.descriptions,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          height: 1.4, // Better readability
                        ),
                        maxLines: 3, 
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}