import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<AlignerHistory> addHistory(
      {required String docId,
      required int currentAligner,
      required AlignerHistory history}) async {
    history.alignerNumber = currentAligner;
    await FirebaseFirestore.instance
        .collection(PatientAPI.collectionName)
        .doc(docId)
        .collection(collectionName)
        .add(history.toJson())
        .then((value) => history.id = value.id)
        .catchError((error) => print('Add history error.'));

    return history;
  }

  Future<List<AlignerHistory>> getHistories({
    required String docId,
    required int alignerNumber,
    required DateTime queryDate,
  }) async {
    List<AlignerHistory> histories = [];
    DateTime greaterThan =
        DateTime(queryDate.year, queryDate.month, queryDate.day, 0, 0);
    DateTime lessThan =
        DateTime(queryDate.year, queryDate.month, queryDate.day, 24, 0);

    var response = await FirebaseFirestore.instance
        .collection(PatientAPI.collectionName)
        .doc(docId)
        .collection(HistoryAPI.collectionName)
        .where('aligner_number', isEqualTo: alignerNumber)
        .where('create_date', isGreaterThanOrEqualTo: greaterThan)
        .where('create_date', isLessThanOrEqualTo: lessThan)
        .get();

    for (var history in response.docs) {
      histories.add(
          AlignerHistory.fromJson(history.data()..addAll({'id': history.id})));
    }
    return histories;
  }
}
