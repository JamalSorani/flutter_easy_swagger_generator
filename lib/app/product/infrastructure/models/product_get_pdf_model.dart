
import 'get_products_pdf_query_model_model.dart';
class ProductGetPdfModel {
  final GetProductsPdfQueryModel getProductsPdfQueryModel;
  ProductGetPdfModel({required this.getProductsPdfQueryModel});
 factory ProductGetPdfModel.fromJson(Map<String, dynamic> json) {
    return ProductGetPdfModel(
   getProductsPdfQueryModel:       GetProductsPdfQueryModel.fromJson(json),
          );
        }    
        }
          