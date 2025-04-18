
import 'get_products_to_pdf_query_model_model.dart';
class WarehouseGetProductsPdfModel {
  final GetProductsToPdfQueryModel getProductsToPdfQueryModel;
  WarehouseGetProductsPdfModel({required this.getProductsToPdfQueryModel});
 factory WarehouseGetProductsPdfModel.fromJson(Map<String, dynamic> json) {
    return WarehouseGetProductsPdfModel(
   getProductsToPdfQueryModel:       GetProductsToPdfQueryModel.fromJson(json),
          );
        }    
        }
          