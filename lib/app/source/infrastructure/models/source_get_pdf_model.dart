
import 'get_sources_pdf_query_model_model.dart';
class SourceGetPdfModel {
  final GetSourcesPdfQueryModel getSourcesPdfQueryModel;
  SourceGetPdfModel({required this.getSourcesPdfQueryModel});
 factory SourceGetPdfModel.fromJson(Map<String, dynamic> json) {
    return SourceGetPdfModel(
   getSourcesPdfQueryModel:       GetSourcesPdfQueryModel.fromJson(json),
          );
        }    
        }
          