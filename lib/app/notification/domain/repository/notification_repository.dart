import 'package:either_dart/either.dart';
import '../../infrastructure/models/notification_get_all_sent_model.dart';
import '../../infrastructure/models/notification_get_all_received_model.dart';
import '../../infrastructure/models/notification_get_sent_by_id_model.dart';
import '../../infrastructure/models/notification_get_received_by_id_model.dart';
import '../../infrastructure/models/notification_add_model.dart';
import '../../infrastructure/models/notification_delete_sent_notifications_model.dart';
import '../../infrastructure/models/notification_delete_received_notifications_model.dart';
import '../../infrastructure/models/notification_read_notification_model.dart';
import '../../infrastructure/models/notification_export_received_notifications_to_excel_model.dart';
import '../../infrastructure/models/notification_export_send_notifications_to_excel_model.dart';
import '../../infrastructure/models/notification_get_received_pdf_model.dart';
import '../../infrastructure/models/notification_get_sents_pdf_model.dart';
import '../entities/notification_get_all_sent_param.dart';
import '../entities/notification_get_all_received_param.dart';
import '../entities/notification_get_sent_by_id_param.dart';
import '../entities/notification_get_received_by_id_param.dart';
import '../entities/notification_add_param.dart';
import '../entities/notification_delete_sent_notifications_param.dart';
import '../entities/notification_delete_received_notifications_param.dart';
import '../entities/notification_read_notification_param.dart';
import '../entities/notification_export_received_notifications_to_excel_param.dart';
import '../entities/notification_export_send_notifications_to_excel_param.dart';
import '../entities/notification_get_received_pdf_param.dart';
import '../entities/notification_get_sents_pdf_param.dart';

abstract class NotificationRepository {
  Future<Either<String, NotificationGetAllSentModel>> notificationGetAllSent({required NotificationGetAllSentParam notificationGetAllSentParam});

  Future<Either<String, NotificationGetAllReceivedModel>> notificationGetAllReceived({required NotificationGetAllReceivedParam notificationGetAllReceivedParam});

  Future<Either<String, NotificationGetSentByIdModel>> notificationGetSentById({required NotificationGetSentByIdParam notificationGetSentByIdParam});

  Future<Either<String, NotificationGetReceivedByIdModel>> notificationGetReceivedById({required NotificationGetReceivedByIdParam notificationGetReceivedByIdParam});

  Future<Either<String, NotificationAddModel>> notificationAdd({required NotificationAddParam notificationAddParam});

  Future<Either<String, NotificationDeleteSentNotificationsModel>> notificationDeleteSentNotifications({required NotificationDeleteSentNotificationsParam notificationDeleteSentNotificationsParam});

  Future<Either<String, NotificationDeleteReceivedNotificationsModel>> notificationDeleteReceivedNotifications({required NotificationDeleteReceivedNotificationsParam notificationDeleteReceivedNotificationsParam});

  Future<Either<String, NotificationReadNotificationModel>> notificationReadNotification({required NotificationReadNotificationParam notificationReadNotificationParam});

  Future<Either<String, NotificationExportReceivedNotificationsToExcelModel>> notificationExportReceivedNotificationsToExcel({required NotificationExportReceivedNotificationsToExcelParam notificationExportReceivedNotificationsToExcelParam});

  Future<Either<String, NotificationExportSendNotificationsToExcelModel>> notificationExportSendNotificationsToExcel({required NotificationExportSendNotificationsToExcelParam notificationExportSendNotificationsToExcelParam});

  Future<Either<String, NotificationGetReceivedPdfModel>> notificationGetReceivedPdf({required NotificationGetReceivedPdfParam notificationGetReceivedPdfParam});

  Future<Either<String, NotificationGetSentsPdfModel>> notificationGetSentsPdf({required NotificationGetSentsPdfParam notificationGetSentsPdfParam});

}
