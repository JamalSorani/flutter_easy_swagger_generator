import 'package:either_dart/either.dart';
import '../../infrastructure/models/role_get_all_roles_model.dart';
import '../../infrastructure/models/role_get_all_roles_names_model.dart';
import '../../infrastructure/models/role_get_role_by_id_model.dart';
import '../../infrastructure/models/role_upsert_role_model.dart';
import '../../infrastructure/models/role_delete_roles_model.dart';
import '../../infrastructure/models/role_export_roles_to_excel_model.dart';
import '../../infrastructure/models/role_get_pdf_model.dart';
import '../entities/role_get_all_roles_param.dart';
import '../entities/role_get_all_roles_names_param.dart';
import '../entities/role_get_role_by_id_param.dart';
import '../entities/role_upsert_role_param.dart';
import '../entities/role_delete_roles_param.dart';
import '../entities/role_export_roles_to_excel_param.dart';
import '../entities/role_get_pdf_param.dart';

abstract class RoleRepository {
  Future<Either<String, RoleGetAllRolesModel>> roleGetAllRoles({required RoleGetAllRolesParam roleGetAllRolesParam});

  Future<Either<String, RoleGetAllRolesNamesModel>> roleGetAllRolesNames({required RoleGetAllRolesNamesParam roleGetAllRolesNamesParam});

  Future<Either<String, RoleGetRoleByIdModel>> roleGetRoleById({required RoleGetRoleByIdParam roleGetRoleByIdParam});

  Future<Either<String, RoleUpsertRoleModel>> roleUpsertRole({required RoleUpsertRoleParam roleUpsertRoleParam});

  Future<Either<String, RoleDeleteRolesModel>> roleDeleteRoles({required RoleDeleteRolesParam roleDeleteRolesParam});

  Future<Either<String, RoleExportRolesToExcelModel>> roleExportRolesToExcel({required RoleExportRolesToExcelParam roleExportRolesToExcelParam});

  Future<Either<String, RoleGetPdfModel>> roleGetPdf({required RoleGetPdfParam roleGetPdfParam});

}
