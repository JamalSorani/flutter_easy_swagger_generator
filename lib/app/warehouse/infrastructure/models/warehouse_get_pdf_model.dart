
import 'get_warehouses_pdf_query_model_model.dart';
class WarehouseGetPdfModel {
  final GetWarehousesPdfQueryModel getWarehousesPdfQueryModel;
  WarehouseGetPdfModel({required this.getWarehousesPdfQueryModel});
 factory WarehouseGetPdfModel.fromJson(Map<String, dynamic> json) {
    return WarehouseGetPdfModel(
   getWarehousesPdfQueryModel:       GetWarehousesPdfQueryModel.fromJson(json),
          );
        }    
        }
          