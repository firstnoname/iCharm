import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';

class HistoryAPI extends BasedAPI {
  static const collectionName = 'history';
  static HistoryAPI? _cache;

  factory HistoryAPI() {
    _cache ??= HistoryAPI._();
    return _cache!;
  }

  HistoryAPI._() : super(collectionName: collectionName);

  Future<List<AlignerHistory>> getHistories({
    required String docId,
    required int alignerNumber,
  }) async {
    List<AlignerHistory> histories = [];
    var response = await FirebaseFirestore.instance
        .collection(PatientAPI.collectionName)
        .doc(docId)
        .collection(HistoryAPI.collectionName)
        .where('aligner_number', isEqualTo: alignerNumber)
        .get();

    for (var history in response.docs) {
      histories.add(
          AlignerHistory.fromJson(history.data()..addAll({'id': history.id})));
    }
    return histories;
  }
}
