import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';

class ClinicAPI extends BasedAPI {
  static const collectionName = 'clinics';
  static ClinicAPI? _cache;

  factory ClinicAPI() {
    _cache ??= ClinicAPI._();
    return _cache!;
  }

  ClinicAPI._() : super(collectionName: collectionName);

  Future<List<Clinic>> getAllClinics() async {
    List<Clinic> clinics = [];
    await collection.get().then((value) => value.docs.forEach((clinic) {
          clinics
              .add(Clinic.fromJson(clinic.data()..addAll({'id': clinic.id})));
        }));

    return clinics;
  }

  Future<List<Clinic>> getClinics(String? keywords) async {
    List<Clinic> clinics = [];
    await collection
        .where('clinic_name', isGreaterThanOrEqualTo: keywords)
        .where('clinic_name',
            isLessThan: keywords != ''
                ? keywords!.substring(0, keywords.length - 1) +
                    String.fromCharCode(
                        keywords.codeUnitAt(keywords.length - 1) + 1)
                : '')
        .get()
        .then((value) => value.docs.forEach((clinic) {
              clinics.add(
                  Clinic.fromJson(clinic.data()..addAll({'id': clinic.id})));
            }));

    return clinics;
  }
}
