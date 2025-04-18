
import 'export_manufacturers_to_excel_query_model_model.dart';
class ManufacturerExportToExcelModel {
  final ExportManufacturersToExcelQueryModel exportManufacturersToExcelQueryModel;
  ManufacturerExportToExcelModel({required this.exportManufacturersToExcelQueryModel});
 factory ManufacturerExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerExportToExcelModel(
   exportManufacturersToExcelQueryModel:       exportManufacturersToExcelQueryModel.fromJson(json),
          );
        }    
        }
          