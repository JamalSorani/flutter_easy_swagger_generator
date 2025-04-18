/// 🚀 API Routes
///
/// This class contains all API route constants extracted from the Swagger JSON.
class AppUrl {
//****************************** category ************************************/
  static const String categoryGetById = 'Dashboard/Category/GetById';
  static const String categoryAdd = 'Dashboard/Category/Add';
  static const String categoryModify = 'Dashboard/Category/Modify';
  static const String categoryGetAllCategoriesByParentCategoryId = 'Dashboard/Category/GetAllCategoriesByParentCategoryId';
  static const String categorySearchAtCategories = 'Dashboard/Category/SearchAtCategories';
  static const String categoryGetCategoriesBySearch = 'Dashboard/Category/GetCategoriesBySearch';
  static const String categoryGetAllNames = 'Dashboard/Category/GetAllNames';
  static const String categoryDelete = 'Dashboard/Category/Delete';
//****************************** category ************************************/

//****************************** color ************************************/
  static const String colorGetAll = 'Dashboard/Color/GetAll';
  static const String colorUpsert = 'Dashboard/Color/Upsert';
  static const String colorDelete = 'Dashboard/Color/Delete';
  static const String colorExportToExcel = 'Dashboard/Color/ExportToExcel';
  static const String colorGetPdf = 'Dashboard/Color/GetPdf';
//****************************** color ************************************/

//****************************** currencyexchange ************************************/
  static const String currencyexchangeGet = 'Dashboard/CurrencyExchange/Get';
  static const String currencyexchangeModify = 'Dashboard/CurrencyExchange/Modify';
//****************************** currencyexchange ************************************/

//****************************** customer ************************************/
  static const String customerGetAll = 'Dashboard/Customer/GetAll';
  static const String customerGetById = 'Dashboard/Customer/GetById';
  static const String customerAdd = 'Dashboard/Customer/Add';
  static const String customerModify = 'Dashboard/Customer/Modify';
  static const String customerGetNames = 'Dashboard/Customer/GetNames';
  static const String customerDelete = 'Dashboard/Customer/Delete';
  static const String customerExportToExcel = 'Dashboard/Customer/ExportToExcel';
  static const String customerGetPdf = 'Dashboard/Customer/GetPdf';
//****************************** customer ************************************/

//****************************** employee ************************************/
  static const String employeeGetAll = 'Dashboard/Employee/GetAll';
  static const String employeeGetById = 'Dashboard/Employee/GetById';
  static const String employeeAdd = 'Dashboard/Employee/Add';
  static const String employeeModify = 'Dashboard/Employee/Modify';
  static const String employeeDelete = 'Dashboard/Employee/Delete';
  static const String employeeLogIn = 'Dashboard/Employee/LogIn';
  static const String employeeRefreshToken = 'Dashboard/Employee/RefreshToken';
  static const String employeeForgetPassword = 'Dashboard/Employee/ForgetPassword';
  static const String employeeConfirmForgetPassword = 'Dashboard/Employee/ConfirmForgetPassword';
  static const String employeeModifyMyProfile = 'Dashboard/Employee/ModifyMyProfile';
  static const String employeeGetMyProfilee = 'Dashboard/Employee/GetMyProfilee';
  static const String employeeChangeBlockStatus = 'Dashboard/Employee/ChangeBlockStatus';
  static const String employeeResetPassword = 'Dashboard/Employee/ResetPassword';
  static const String employeeGetAllNames = 'Dashboard/Employee/GetAllNames';
  static const String employeeModifyMyPassword = 'Dashboard/Employee/ModifyMyPassword';
  static const String employeeExportToExcel = 'Dashboard/Employee/ExportToExcel';
  static const String employeeGetPdf = 'Dashboard/Employee/GetPdf';
//****************************** employee ************************************/

//****************************** fillstyle ************************************/
  static const String fillstyleGetAll = 'Dashboard/FillStyle/GetAll';
  static const String fillstyleUpsert = 'Dashboard/FillStyle/Upsert';
  static const String fillstyleDelete = 'Dashboard/FillStyle/Delete';
//****************************** fillstyle ************************************/

//****************************** general ************************************/
  static const String generalGeneralSearch = 'Dashboard/General/GeneralSearch';
//****************************** general ************************************/

//****************************** inventorymanagment ************************************/
  static const String inventorymanagmentAddInboundOrOutboundProcess = 'Dashboard/InventoryManagment/AddInboundOrOutboundProcess';
  static const String inventorymanagmentAddtransferProcess = 'Dashboard/InventoryManagment/AddtransferProcess';
  static const String inventorymanagmentGetAllStocks = 'Dashboard/InventoryManagment/GetAllStocks';
  static const String inventorymanagmentGetAllInboundAndOutboundProcesses = 'Dashboard/InventoryManagment/GetAllInboundAndOutboundProcesses';
  static const String inventorymanagmentGetAllTransferProcesses = 'Dashboard/InventoryManagment/GetAllTransferProcesses';
  static const String inventorymanagmentModifyInboundOrOutboundProcess = 'Dashboard/InventoryManagment/ModifyInboundOrOutboundProcess';
  static const String inventorymanagmentModifyTransferProcess = 'Dashboard/InventoryManagment/ModifyTransferProcess';
  static const String inventorymanagmentDeleteTransferProcess = 'Dashboard/InventoryManagment/DeleteTransferProcess';
  static const String inventorymanagmentDeleteInboundOrOutboundProcess = 'Dashboard/InventoryManagment/DeleteInboundOrOutboundProcess';
  static const String inventorymanagmentGetProductById = 'Dashboard/InventoryManagment/GetProductById';
  static const String inventorymanagmentGetInboundOrOutboundProcessById = 'Dashboard/InventoryManagment/GetInboundOrOutboundProcessById';
  static const String inventorymanagmentGetTransferProcessById = 'Dashboard/InventoryManagment/GetTransferProcessById';
  static const String inventorymanagmentExportStocksToExcel = 'Dashboard/InventoryManagment/ExportStocksToExcel';
  static const String inventorymanagmentExportInboundOrOutboundProcessesToExcel = 'Dashboard/InventoryManagment/ExportInboundOrOutboundProcessesToExcel';
  static const String inventorymanagmentExportTransferProcessesToExcel = 'Dashboard/InventoryManagment/ExportTransferProcessesToExcel';
  static const String inventorymanagmentGetTransferProcessesPdf = 'Dashboard/InventoryManagment/GetTransferProcessesPdf';
  static const String inventorymanagmentGetInboundOrOutboundPrcoessesPdf = 'Dashboard/InventoryManagment/GetInboundOrOutboundPrcoessesPdf';
  static const String inventorymanagmentGetStocksPdf = 'Dashboard/InventoryManagment/GetStocksPdf';
//****************************** inventorymanagment ************************************/

//****************************** manufacturer ************************************/
  static const String manufacturerGetAll = 'Dashboard/Manufacturer/GetAll';
  static const String manufacturerUpsert = 'Dashboard/Manufacturer/Upsert';
  static const String manufacturerDelete = 'Dashboard/Manufacturer/Delete';
  static const String manufacturerExportToExcel = 'Dashboard/Manufacturer/ExportToExcel';
  static const String manufacturerGetPdf = 'Dashboard/Manufacturer/GetPdf';
//****************************** manufacturer ************************************/

//****************************** measurement ************************************/
  static const String measurementGetAll = 'Dashboard/Measurement/GetAll';
  static const String measurementUpsert = 'Dashboard/Measurement/Upsert';
  static const String measurementDelete = 'Dashboard/Measurement/Delete';
  static const String measurementExportToExcel = 'Dashboard/Measurement/ExportToExcel';
  static const String measurementGetPdf = 'Dashboard/Measurement/GetPdf';
//****************************** measurement ************************************/

//****************************** notification ************************************/
  static const String notificationGetAllSent = 'Dashboard/Notification/GetAllSent';
  static const String notificationGetAllReceived = 'Dashboard/Notification/GetAllReceived';
  static const String notificationGetSentById = 'Dashboard/Notification/GetSentById';
  static const String notificationGetReceivedById = 'Dashboard/Notification/GetReceivedById';
  static const String notificationAdd = 'Dashboard/Notification/Add';
  static const String notificationDeleteSentNotifications = 'Dashboard/Notification/DeleteSentNotifications';
  static const String notificationDeleteReceivedNotifications = 'Dashboard/Notification/DeleteReceivedNotifications';
  static const String notificationReadNotification = 'Dashboard/Notification/ReadNotification';
  static const String notificationExportReceivedNotificationsToExcel = 'Dashboard/Notification/ExportReceivedNotificationsToExcel';
  static const String notificationExportSendNotificationsToExcel = 'Dashboard/Notification/ExportSendNotificationsToExcel';
  static const String notificationGetReceivedPdf = 'Dashboard/Notification/GetReceivedPdf';
  static const String notificationGetSentsPdf = 'Dashboard/Notification/GetSentsPdf';
//****************************** notification ************************************/

//****************************** order ************************************/
  static const String orderGetAll = 'Dashboard/Order/GetAll';
  static const String orderGetById = 'Dashboard/Order/GetById';
  static const String orderAdd = 'Dashboard/Order/Add';
  static const String orderModify = 'Dashboard/Order/Modify';
  static const String orderGetInvoiceByOrderId = 'Dashboard/Order/GetInvoiceByOrderId';
  static const String orderDelete = 'Dashboard/Order/Delete';
  static const String orderChangeStatus = 'Dashboard/Order/ChangeStatus';
  static const String orderExportToExcel = 'Dashboard/Order/ExportToExcel';
  static const String orderGetOrdersPdf = 'Dashboard/Order/GetOrdersPdf';
  static const String orderGetInvoicePdf = 'Dashboard/Order/GetInvoicePdf';
//****************************** order ************************************/

//****************************** saleswindowapp ************************************/
  static const String saleswindowappOrderAddFromCart = 'SalesWindowApp/Order/AddFromCart';
  static const String saleswindowappOrderModify = 'SalesWindowApp/Order/Modify';
  static const String saleswindowappOrderAdd = 'SalesWindowApp/Order/Add';
  static const String saleswindowappProductGetSimilar = 'SalesWindowApp/Product/GetSimilar';
  static const String saleswindowappReportGetMainPage = 'SalesWindowApp/Report/GetMainPage';
  static const String saleswindowappReportGetMostRequestedProducts = 'SalesWindowApp/Report/GetMostRequestedProducts';
  static const String saleswindowappReportGetMostRequestedPackages = 'SalesWindowApp/Report/GetMostRequestedPackages';
  static const String saleswindowappReportGetProductReports = 'SalesWindowApp/Report/GetProductReports';
  static const String saleswindowappShoppingCartGetById = 'SalesWindowApp/ShoppingCart/GetById';
  static const String saleswindowappShoppingCartGetAll = 'SalesWindowApp/ShoppingCart/GetAll';
  static const String saleswindowappShoppingCartAdd = 'SalesWindowApp/ShoppingCart/Add';
  static const String saleswindowappShoppingCartDelete = 'SalesWindowApp/ShoppingCart/Delete';
  static const String saleswindowappShoppingCartGetAllNames = 'SalesWindowApp/ShoppingCart/GetAllNames';
  static const String saleswindowappShoppingCartModify = 'SalesWindowApp/ShoppingCart/Modify';
  static const String saleswindowappShoppingCartDeleteFromShoppingCart = 'SalesWindowApp/ShoppingCart/DeleteFromShoppingCart';
//****************************** saleswindowapp ************************************/

//****************************** ore ************************************/
  static const String oreGetAll = 'Dashboard/Ore/GetAll';
  static const String oreUpsert = 'Dashboard/Ore/Upsert';
  static const String oreDelete = 'Dashboard/Ore/Delete';
  static const String oreExportToExcel = 'Dashboard/Ore/ExportToExcel';
  static const String oreGetPdf = 'Dashboard/Ore/GetPdf';
//****************************** ore ************************************/

//****************************** package ************************************/
  static const String packageGetAll = 'Dashboard/Package/GetAll';
  static const String packageGetById = 'Dashboard/Package/GetById';
  static const String packageGetAllProducts = 'Dashboard/Package/GetAllProducts';
  static const String packageAdd = 'Dashboard/Package/Add';
  static const String packageModify = 'Dashboard/Package/Modify';
  static const String packageDelete = 'Dashboard/Package/Delete';
  static const String packageGetSimilar = 'Dashboard/Package/GetSimilar';
  static const String packageGetPdf = 'Dashboard/Package/GetPdf';
  static const String packageExportToExcel = 'Dashboard/Package/ExportToExcel';
//****************************** package ************************************/

//****************************** product ************************************/
  static const String productGetAll = 'Dashboard/Product/GetAll';
  static const String productGetByQR = 'Dashboard/Product/GetByQR';
  static const String productAdd = 'Dashboard/Product/Add';
  static const String productModify = 'Dashboard/Product/Modify';
  static const String productGetById = 'Dashboard/Product/GetById';
  static const String productDelete = 'Dashboard/Product/Delete';
  static const String productGetAllNames = 'Dashboard/Product/GetAllNames';
  static const String productGetSimilar = 'Dashboard/Product/GetSimilar';
  static const String productGetPdf = 'Dashboard/Product/GetPdf';
  static const String productExportToExcel = 'Dashboard/Product/ExportToExcel';
//****************************** product ************************************/

//****************************** quantitystyle ************************************/
  static const String quantitystyleGetAll = 'Dashboard/QuantityStyle/GetAll';
  static const String quantitystyleUpsert = 'Dashboard/QuantityStyle/Upsert';
  static const String quantitystyleDelete = 'Dashboard/QuantityStyle/Delete';
  static const String quantitystyleExportToExcel = 'Dashboard/QuantityStyle/ExportToExcel';
  static const String quantitystyleGetPdf = 'Dashboard/QuantityStyle/GetPdf';
//****************************** quantitystyle ************************************/

//****************************** report ************************************/
  static const String reportGetMainPage = 'Dashboard/Report/GetMainPage';
  static const String reportGetAllLowStocks = 'Dashboard/Report/GetAllLowStocks';
//****************************** report ************************************/

//****************************** role ************************************/
  static const String roleGetAllRoles = 'Dashboard/Role/GetAllRoles';
  static const String roleGetAllRolesNames = 'Dashboard/Role/GetAllRolesNames';
  static const String roleGetRoleById = 'Dashboard/Role/GetRoleById';
  static const String roleUpsertRole = 'Dashboard/Role/UpsertRole';
  static const String roleDeleteRoles = 'Dashboard/Role/DeleteRoles';
  static const String roleExportRolesToExcel = 'Dashboard/Role/ExportRolesToExcel';
  static const String roleGetPdf = 'Dashboard/Role/GetPdf';
//****************************** role ************************************/

//****************************** saleswindow ************************************/
  static const String saleswindowGetAll = 'Dashboard/SalesWindow/GetAll';
  static const String saleswindowGetById = 'Dashboard/SalesWindow/GetById';
  static const String saleswindowAdd = 'Dashboard/SalesWindow/Add';
  static const String saleswindowModify = 'Dashboard/SalesWindow/Modify';
  static const String saleswindowDelete = 'Dashboard/SalesWindow/Delete';
  static const String saleswindowGetAllProductsBySalesWindowId = 'Dashboard/SalesWindow/GetAllProductsBySalesWindowId';
  static const String saleswindowExportToExcel = 'Dashboard/SalesWindow/ExportToExcel';
  static const String saleswindowGetPdf = 'Dashboard/SalesWindow/GetPdf';
  static const String saleswindowGetProductsPdf = 'Dashboard/SalesWindow/GetProductsPdf';
  static const String saleswindowExportProdductToExcel = 'Dashboard/SalesWindow/ExportProdductToExcel';
//****************************** saleswindow ************************************/

//****************************** setting ************************************/
  static const String settingGetAllSettingNames = 'Dashboard/Setting/GetAllSettingNames';
  static const String settingGetAllUserNames = 'Dashboard/Setting/GetAllUserNames';
//****************************** setting ************************************/

//****************************** source ************************************/
  static const String sourceGetAll = 'Dashboard/Source/GetAll';
  static const String sourceUpsert = 'Dashboard/Source/Upsert';
  static const String sourceDelete = 'Dashboard/Source/Delete';
  static const String sourceExportToExcel = 'Dashboard/Source/ExportToExcel';
  static const String sourceGetPdf = 'Dashboard/Source/GetPdf';
//****************************** source ************************************/

//****************************** store ************************************/
  static const String storeGetAll = 'Dashboard/Store/GetAll';
  static const String storeUpsert = 'Dashboard/Store/Upsert';
  static const String storeDelete = 'Dashboard/Store/Delete';
  static const String storeExportToExcel = 'Dashboard/Store/ExportToExcel';
  static const String storeGetPdf = 'Dashboard/Store/GetPdf';
//****************************** store ************************************/

//****************************** warehouse ************************************/
  static const String warehouseGetAll = 'Dashboard/Warehouse/GetAll';
  static const String warehouseGetById = 'Dashboard/Warehouse/GetById';
  static const String warehouseAdd = 'Dashboard/Warehouse/Add';
  static const String warehouseModify = 'Dashboard/Warehouse/Modify';
  static const String warehouseDelete = 'Dashboard/Warehouse/Delete';
  static const String warehouseGetAllProductsByWarehouseId = 'Dashboard/Warehouse/GetAllProductsByWarehouseId';
  static const String warehouseExportToExcel = 'Dashboard/Warehouse/ExportToExcel';
  static const String warehouseGetPdf = 'Dashboard/Warehouse/GetPdf';
  static const String warehouseGetProductsPdf = 'Dashboard/Warehouse/GetProductsPdf';
  static const String warehouseExportProdductToExcel = 'Dashboard/Warehouse/ExportProdductToExcel';
//****************************** warehouse ************************************/

}
