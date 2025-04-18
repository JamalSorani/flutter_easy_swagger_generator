
import 'get_manufacturers_pdf_query_model_model.dart';
class ManufacturerGetPdfModel {
  final GetManufacturersPdfQueryModel getManufacturersPdfQueryModel;
  ManufacturerGetPdfModel({required this.getManufacturersPdfQueryModel});
 factory ManufacturerGetPdfModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerGetPdfModel(
   getManufacturersPdfQueryModel:       GetManufacturersPdfQueryModel.fromJson(json),
          );
        }    
        }
          