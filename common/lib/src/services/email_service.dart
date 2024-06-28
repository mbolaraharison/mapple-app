import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class EmailServiceInterface {
  Future<void> sendQuote(
      FileData quote, Order order, Representative? representative);
  Future<void> sendRepresentativeAppraisalRecall(
      List<RepresentativeAppraisal> representativeAppraisals);
}

// Implementation:--------------------------------------------------------------
class EmailService implements EmailServiceInterface {
  EmailFirestoreDao emailDao = getIt<EmailFirestoreDao>();
  EmailTemplateServiceInterface emailTemplateService =
      getIt<EmailTemplateServiceInterface>();
  UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();

  @override
  Future<void> sendQuote(
      FileData quote, Order order, Representative? representative) async {
    List<String> contactEmails =
        order.contactsList.map((c) => c.email).toList();
    await order.loadOrderRows();
    List<FileData> servicesSheets =
        (await Future.wait(order.orderRows.map((orderRow) async {
      await orderRow.loadService();
      await orderRow.service!.loadSheetFileData();
      return orderRow.service!.sheetFileData;
    })))
            .nonNulls
            .toList();

    EmailTemplate? emailTemplate = await emailTemplateService.getByTemplateName(
        EmailTemplate.emailTemplates['ORDER_QUOTE_TO_CONTACTS'] ?? '');
    final email = Email(
        id: uuidUtils.generate(),
        from: dotenv.env['EMAIL_NO_REPLY_SENDER_BRAND'] ?? '',
        to: contactEmails,
        templateId: emailTemplate?.templateId,
        sentAt: DateTime.now(),
        sent: false,
        cc: [],
        bcc:
            representative?.isEmailValid == true ? [representative!.email] : [],
        retry: 0,
        attachments: [
          {
            'uniqueName': quote.uniqueName,
            'displayName': quote.displayName,
          },
          ...servicesSheets.map((sheet) => {
                'uniqueName': sheet.uniqueName,
                'displayName': sheet.displayName,
              })
        ],
        params: {
          'user': representative?.fullName ?? '',
        });
    await emailDao.create(email);
  }

  @override
  Future<void> sendRepresentativeAppraisalRecall(
      List<RepresentativeAppraisal> representativeAppraisals) async {
    EmailTemplate? emailTemplate = await emailTemplateService.getByTemplateName(
        EmailTemplate.emailTemplates['APPRAISAL_RECALL_TO_REPRESENTATIVE'] ??
            '');

    List<Future> futureEmails = [];
    for (RepresentativeAppraisal appraisal in representativeAppraisals) {
      await appraisal.loadData();
      final email = Email(
          id: uuidUtils.generate(),
          from: dotenv.env['EMAIL_NO_REPLY_SENDER_BRAND'] ?? '',
          to: [appraisal.representative!.email],
          templateId: emailTemplate?.templateId,
          sentAt: DateTime.now(),
          sent: false,
          cc: [],
          bcc: [],
          retry: 0,
          params: {
            'limitDate': DateFormat('dd/MM/yyyy').format(appraisal.limitDate),
            'type': appraisal.type.label,
          });
      futureEmails.add(emailDao.create(email));
    }

    await Future.wait(futureEmails);
  }
}
