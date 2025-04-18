import 'package:either_dart/either.dart';
import '../../infrastructure/models/employee_get_all_model.dart';
import '../../infrastructure/models/employee_get_by_id_model.dart';
import '../../infrastructure/models/employee_add_model.dart';
import '../../infrastructure/models/employee_modify_model.dart';
import '../../infrastructure/models/employee_delete_model.dart';
import '../../infrastructure/models/employee_log_in_model.dart';
import '../../infrastructure/models/employee_refresh_token_model.dart';
import '../../infrastructure/models/employee_forget_password_model.dart';
import '../../infrastructure/models/employee_confirm_forget_password_model.dart';
import '../../infrastructure/models/employee_modify_my_profile_model.dart';
import '../../infrastructure/models/employee_get_my_profilee_model.dart';
import '../../infrastructure/models/employee_change_block_status_model.dart';
import '../../infrastructure/models/employee_reset_password_model.dart';
import '../../infrastructure/models/employee_get_all_names_model.dart';
import '../../infrastructure/models/employee_modify_my_password_model.dart';
import '../../infrastructure/models/employee_export_to_excel_model.dart';
import '../../infrastructure/models/employee_get_pdf_model.dart';
import '../entities/employee_get_all_param.dart';
import '../entities/employee_get_by_id_param.dart';
import '../entities/employee_add_param.dart';
import '../entities/employee_modify_param.dart';
import '../entities/employee_delete_param.dart';
import '../entities/employee_log_in_param.dart';
import '../entities/employee_refresh_token_param.dart';
import '../entities/employee_forget_password_param.dart';
import '../entities/employee_confirm_forget_password_param.dart';
import '../entities/employee_modify_my_profile_param.dart';
import '../entities/employee_get_my_profilee_param.dart';
import '../entities/employee_change_block_status_param.dart';
import '../entities/employee_reset_password_param.dart';
import '../entities/employee_get_all_names_param.dart';
import '../entities/employee_modify_my_password_param.dart';
import '../entities/employee_export_to_excel_param.dart';
import '../entities/employee_get_pdf_param.dart';

abstract class EmployeeRepository {
  Future<Either<String, EmployeeGetAllModel>> employeeGetAll({required EmployeeGetAllParam employeeGetAllParam});

  Future<Either<String, EmployeeGetByIdModel>> employeeGetById({required EmployeeGetByIdParam employeeGetByIdParam});

  Future<Either<String, EmployeeAddModel>> employeeAdd({required EmployeeAddParam employeeAddParam});

  Future<Either<String, EmployeeModifyModel>> employeeModify({required EmployeeModifyParam employeeModifyParam});

  Future<Either<String, EmployeeDeleteModel>> employeeDelete({required EmployeeDeleteParam employeeDeleteParam});

  Future<Either<String, EmployeeLogInModel>> employeeLogIn({required EmployeeLogInParam employeeLogInParam});

  Future<Either<String, EmployeeRefreshTokenModel>> employeeRefreshToken({required EmployeeRefreshTokenParam employeeRefreshTokenParam});

  Future<Either<String, EmployeeForgetPasswordModel>> employeeForgetPassword({required EmployeeForgetPasswordParam employeeForgetPasswordParam});

  Future<Either<String, EmployeeConfirmForgetPasswordModel>> employeeConfirmForgetPassword({required EmployeeConfirmForgetPasswordParam employeeConfirmForgetPasswordParam});

  Future<Either<String, EmployeeModifyMyProfileModel>> employeeModifyMyProfile({required EmployeeModifyMyProfileParam employeeModifyMyProfileParam});

  Future<Either<String, EmployeeGetMyProfileeModel>> employeeGetMyProfilee({required EmployeeGetMyProfileeParam employeeGetMyProfileeParam});

  Future<Either<String, EmployeeChangeBlockStatusModel>> employeeChangeBlockStatus({required EmployeeChangeBlockStatusParam employeeChangeBlockStatusParam});

  Future<Either<String, EmployeeResetPasswordModel>> employeeResetPassword({required EmployeeResetPasswordParam employeeResetPasswordParam});

  Future<Either<String, EmployeeGetAllNamesModel>> employeeGetAllNames({required EmployeeGetAllNamesParam employeeGetAllNamesParam});

  Future<Either<String, EmployeeModifyMyPasswordModel>> employeeModifyMyPassword({required EmployeeModifyMyPasswordParam employeeModifyMyPasswordParam});

  Future<Either<String, EmployeeExportToExcelModel>> employeeExportToExcel({required EmployeeExportToExcelParam employeeExportToExcelParam});

  Future<Either<String, EmployeeGetPdfModel>> employeeGetPdf({required EmployeeGetPdfParam employeeGetPdfParam});

}
