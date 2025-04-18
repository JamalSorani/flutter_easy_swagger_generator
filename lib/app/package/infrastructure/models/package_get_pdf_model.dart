
import 'get_packages_pdf_query_model_model.dart';
class PackageGetPdfModel {
  final GetPackagesPdfQueryModel getPackagesPdfQueryModel;
  PackageGetPdfModel({required this.getPackagesPdfQueryModel});
 factory PackageGetPdfModel.fromJson(Map<String, dynamic> json) {
    return PackageGetPdfModel(
   getPackagesPdfQueryModel:       getPackagesPdfQueryModel.fromJson(json),
          );
        }    
        }
          