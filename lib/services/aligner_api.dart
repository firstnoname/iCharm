import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';

class AlignerAPI extends BasedAPI {
  static const collectionName = 'aligner';
  static AlignerAPI? _cache;

  factory AlignerAPI() {
    _cache ??= AlignerAPI._();
    return _cache!;
  }

  AlignerAPI._() : super(collectionName: collectionName);

  Future<Aligner> getAligner({required String docId}) async {
    var response = await collection.doc(docId).get();
    return Aligner.fromJson(response.data()!..addAll({'': response.id}));
  }
}
