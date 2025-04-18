
import 'get_stores_pdf_query_model_model.dart';
class StoreGetPdfModel {
  final GetStoresPdfQueryModel getStoresPdfQueryModel;
  StoreGetPdfModel({required this.getStoresPdfQueryModel});
 factory StoreGetPdfModel.fromJson(Map<String, dynamic> json) {
    return StoreGetPdfModel(
   getStoresPdfQueryModel:       GetStoresPdfQueryModel.fromJson(json),
          );
        }    
        }
          