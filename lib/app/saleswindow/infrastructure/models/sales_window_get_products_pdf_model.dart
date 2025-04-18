
import 'get_products_to_pdf_query_model_model.dart';
class SalesWindowGetProductsPdfModel {
  final GetProductsToPdfQueryModel getProductsToPdfQueryModel;
  SalesWindowGetProductsPdfModel({required this.getProductsToPdfQueryModel});
 factory SalesWindowGetProductsPdfModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowGetProductsPdfModel(
   getProductsToPdfQueryModel:       GetProductsToPdfQueryModel.fromJson(json),
          );
        }    
        }
          