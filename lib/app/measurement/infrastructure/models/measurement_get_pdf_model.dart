
import 'get_measurements_pdf_query_model_model.dart';
class MeasurementGetPdfModel {
  final GetMeasurementsPdfQueryModel getMeasurementsPdfQueryModel;
  MeasurementGetPdfModel({required this.getMeasurementsPdfQueryModel});
 factory MeasurementGetPdfModel.fromJson(Map<String, dynamic> json) {
    return MeasurementGetPdfModel(
   getMeasurementsPdfQueryModel:       getMeasurementsPdfQueryModel.fromJson(json),
          );
        }    
        }
          