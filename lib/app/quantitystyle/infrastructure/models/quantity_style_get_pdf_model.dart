
import 'get_quantity_styles_pdf_query_model_model.dart';
class QuantityStyleGetPdfModel {
  final GetQuantityStylesPdfQueryModel getQuantityStylesPdfQueryModel;
  QuantityStyleGetPdfModel({required this.getQuantityStylesPdfQueryModel});
 factory QuantityStyleGetPdfModel.fromJson(Map<String, dynamic> json) {
    return QuantityStyleGetPdfModel(
   getQuantityStylesPdfQueryModel:       getQuantityStylesPdfQueryModel.fromJson(json),
          );
        }    
        }
          