import 'package:flutter/material.dart';


class DecisionNode {
  final int id;
  final int symptomId;
  final int questionItemId;
  final int threshold;
  final int yesNextId;
  final int noNextId;
  final String outCome;
  final bool isleaf = false;

  DecisionNode(this.id, this.symptomId, this.questionItemId, this.threshold, this.yesNextId, this.noNextId, this.outCome);
}