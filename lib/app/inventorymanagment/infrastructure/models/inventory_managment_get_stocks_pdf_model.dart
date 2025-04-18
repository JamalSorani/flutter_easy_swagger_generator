
import 'get_stocks_pdf_query_model_model.dart';
class InventoryManagmentGetStocksPdfModel {
  final GetStocksPdfQueryModel getStocksPdfQueryModel;
  InventoryManagmentGetStocksPdfModel({required this.getStocksPdfQueryModel});
 factory InventoryManagmentGetStocksPdfModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetStocksPdfModel(
   getStocksPdfQueryModel:       getStocksPdfQueryModel.fromJson(json),
          );
        }    
        }
          