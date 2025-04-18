import 'package:either_dart/either.dart';
import '../../infrastructure/models/customer_get_all_model.dart';
import '../../infrastructure/models/customer_get_by_id_model.dart';
import '../../infrastructure/models/customer_add_model.dart';
import '../../infrastructure/models/customer_modify_model.dart';
import '../../infrastructure/models/customer_get_names_model.dart';
import '../../infrastructure/models/customer_delete_model.dart';
import '../../infrastructure/models/customer_export_to_excel_model.dart';
import '../../infrastructure/models/customer_get_pdf_model.dart';
import '../entities/customer_get_all_param.dart';
import '../entities/customer_get_by_id_param.dart';
import '../entities/customer_add_param.dart';
import '../entities/customer_modify_param.dart';
import '../entities/customer_get_names_param.dart';
import '../entities/customer_delete_param.dart';
import '../entities/customer_export_to_excel_param.dart';
import '../entities/customer_get_pdf_param.dart';

abstract class CustomerRepository {
  Future<Either<String, CustomerGetAllModel>> customerGetAll({required CustomerGetAllParam customerGetAllParam});

  Future<Either<String, CustomerGetByIdModel>> customerGetById({required CustomerGetByIdParam customerGetByIdParam});

  Future<Either<String, CustomerAddModel>> customerAdd({required CustomerAddParam customerAddParam});

  Future<Either<String, CustomerModifyModel>> customerModify({required CustomerModifyParam customerModifyParam});

  Future<Either<String, CustomerGetNamesModel>> customerGetNames({required CustomerGetNamesParam customerGetNamesParam});

  Future<Either<String, CustomerDeleteModel>> customerDelete({required CustomerDeleteParam customerDeleteParam});

  Future<Either<String, CustomerExportToExcelModel>> customerExportToExcel({required CustomerExportToExcelParam customerExportToExcelParam});

  Future<Either<String, CustomerGetPdfModel>> customerGetPdf({required CustomerGetPdfParam customerGetPdfParam});

}
