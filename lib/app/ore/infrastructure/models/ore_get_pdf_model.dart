
import 'get_ores_pdf_query_model_model.dart';
class OreGetPdfModel {
  final GetOresPdfQueryModel getOresPdfQueryModel;
  OreGetPdfModel({required this.getOresPdfQueryModel});
 factory OreGetPdfModel.fromJson(Map<String, dynamic> json) {
    return OreGetPdfModel(
   getOresPdfQueryModel:       GetOresPdfQueryModel.fromJson(json),
          );
        }    
        }
          