import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RepresentativeAppraisalFormGeneratorInterface {
  Future<void> generate({
    required RepresentativeAppraisal representativeAppraisal,
    bool openFile = true,
    bool withSave = false,
    String? fileDataId,
  });
}

// Implementation:--------------------------------------------------------------
class RepresentativeAppraisalFormGenerator
    with PrivateDirectoryMixin
    implements RepresentativeAppraisalFormGeneratorInterface {
  // Variables:-----------------------------------------------------------------
  late final PdfColor _primaryColor =
      PdfColor.fromInt(_theme.representativeAppraisalFormPrimaryColor.value);

  late final PdfColor _secondaryColor =
      PdfColor.fromInt(_theme.representativeAppraisalFormSecondaryColor.value);

  late final PdfColor _objectivesHeaderColor =
      const PdfColor.fromInt(0xffd0d1de);

  late final PdfColor _firstAlternateColor = const PdfColor.fromInt(0xffefeff5);

  late final PdfColor _secondAlternateColor =
      const PdfColor.fromInt(0xffe5e6ee);

  // Dependencies:--------------------------------------------------------------
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final AppThemeDataInterface _theme = getIt<AppThemeDataInterface>();
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> generate({
    required RepresentativeAppraisal representativeAppraisal,
    bool openFile = true,
    bool withSave = false,
    String? fileDataId,
  }) async {
    final dto = await RepresentativeAppraisalFormDto.create(
      representativeAppraisal: representativeAppraisal,
    );

    late final String uniqueName;
    late final File file;

    // If withSave -> increment version
    if (withSave == true) {
      uniqueName = 'appraisal.edit.generate.unique_name'.tr(namedArgs: {
        'representativeId': dto.representativeId,
        'date': dto.date,
      });
      file = await _fileUtils.save(
        path: await _fileUtils.getUploadPath(
          agencyName: dto.agencyLabel,
          customerName: 'Rep-${dto.representativeName}',
          fileName: uniqueName,
        ),
      );
    } else {
      uniqueName = 'appraisal.edit.generate.unique_name'.tr(namedArgs: {
        'representativeId': dto.representativeId,
        'date': dto.date,
      });
      Directory directory = await privateDirectory;
      file = File('${directory.path}/$uniqueName');
    }

    final doc = Document();

    doc.addPage(
      MultiPage(
        maxPages: 40,
        pageTheme: _buildTheme(
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoRegular)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoBold)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoItalic)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.cupertinoIcons)),
        ),
        build: (context) => _buildContent(dto: dto, isPreview: !withSave),
      ),
    );

    // save the file
    await file.writeAsBytes(await doc.save(), flush: true);

    // If withSave -> create file data, open it and upload it
    if (withSave == true) {
      final fileData = FileData(
        id: fileDataId ?? _uuidUtils.generate(),
        uniqueName: uniqueName,
        displayName: uniqueName,
        syncStatus: SyncStatus.OK,
        agencyId: dto.agencyId,
      );
      await _fileDataService.create(fileData, onlyToFirestore: true);
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        file: file,
        download: true,
        withRemove: true,
      );
      _fileDataService.tryUpload(file);

      return;
    }

    // If not withSave -> open file and remove it
    if (openFile) {
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        download: false,
        withRemove: true,
      );
    }
  }

  // PDF methods:---------------------------------------------------------------
  PageTheme _buildTheme(
    Font base,
    Font bold,
    Font italic,
    Font icons,
  ) {
    return PageTheme(
      pageFormat: PdfPageFormat.a4,
      theme: ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
        icons: icons,
      ),
      margin: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 24,
        top: 24,
      ),
    );
  }

  List<Widget> _buildContent(
      {required RepresentativeAppraisalFormDto dto, required bool isPreview}) {
    return [
      _buildHeader(dto: dto, isPreview: isPreview),
      SizedBox(height: 10),
      _buildObjectives(dto: dto),
      SizedBox(height: 15),
      _buildSkillsAndAppraisalHeaders(dto: dto),
      _buildResponses(dto: dto),
      SizedBox(height: 15),
      _buildImprovementPlan(dto: dto),
    ];
  }

  Widget _buildHeader(
      {required RepresentativeAppraisalFormDto dto, required bool isPreview}) {
    return Padding(
      padding: const EdgeInsets.only(left: -25, top: -24, right: -25),
      child: Row(
        children: [
          SvgImage(
            svg: dto.demiDiskSvg,
            width: 140,
            height: 140,
            colorFilter: _secondaryColor,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'appraisal.edit.generate.document_title.analysis'.tr(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                dto.type != RepresentativeAppraisalType.ANNUAL
                    ? 'appraisal.edit.generate.document_title.of_type'
                        .tr(namedArgs: {
                        "type":
                            RepresentativeAppraisalType.periodicities[dto.type]!
                      })
                    : 'appraisal.edit.generate.document_title.annual'.tr(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            isPreview
                ? Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: _secondaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'appraisal.edit.generate.unofficial-document-description-part-1'
                                  .tr(),
                              style: TextStyle(
                                fontSize: 10,
                                color: PdfColors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                              'appraisal.edit.generate.unofficial-document-description-part-2'
                                  .tr(),
                              style: TextStyle(
                                fontSize: 10,
                                color: PdfColors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ]))
                : SizedBox(),
            dto.completedByDirectorAt.isNotEmpty
                ? Text(
                    'appraisal.edit.generate.completed_by_user_at'
                        .tr(namedArgs: {
                      "user": dto.directorName,
                      "date": dto.completedByDirectorAt,
                    }),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox(),
            dto.completedByRepresentativeAt.isNotEmpty
                ? Column(
                    children: [
                      dto.completedByDirectorAt.isNotEmpty
                          ? SizedBox(height: 5)
                          : SizedBox(),
                      Text(
                        'appraisal.edit.generate.completed_by_user_at'
                            .tr(namedArgs: {
                          "user": dto.representativeName,
                          "date": dto.completedByRepresentativeAt,
                        }),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ]),
          SizedBox(width: 25),
        ],
      ),
    );
  }

  Widget _buildObjectives({required RepresentativeAppraisalFormDto dto}) {
    return Column(
      children: [
        _buildObjectivesHeader(dto: dto),
        SizedBox(height: 1),
        _buildObjectivesDetails(dto: dto),
      ],
    );
  }

  Widget _buildObjectivesHeader({required RepresentativeAppraisalFormDto dto}) {
    return Row(children: [
      Spacer(flex: 4),
      SizedBox(width: 2),
      Expanded(
        flex: 2,
        child: Container(
          decoration: BoxDecoration(
            color: _primaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Text(
              'appraisal.edit.generate.objectives.if_yes'.tr().toUpperCase(),
              style: TextStyle(
                color: PdfColors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 2),
      Expanded(
        flex: 2,
        child: Container(
          decoration: BoxDecoration(
            color: _primaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Text(
              'appraisal.edit.generate.objectives.meeting_origin'
                  .tr()
                  .toUpperCase(),
              style: TextStyle(
                color: PdfColors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildObjectivesDetails(
      {required RepresentativeAppraisalFormDto dto}) {
    return Row(children: [
      Expanded(
        flex: 4,
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.objective'.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _firstAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.objective,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.booked_meeting_count'
                          .tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _secondAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.bookedMeetingCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.processed_meeting_booked_count'
                          .tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _firstAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.processedMeetingCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      SizedBox(width: 1),
      Expanded(
        flex: 2,
        child: Row(children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.alone'.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _secondAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.meetingAloneCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.accompanied'.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _firstAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.meetingAccompaniedCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      SizedBox(width: 1),
      Expanded(
        flex: 2,
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.tap'.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _secondAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.tapMeetingCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.phone'.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _firstAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.phoneMeetingCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _objectivesHeaderColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'appraisal.edit.generate.objectives.gms'.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: _secondAlternateColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      dto.gmsMeetingCount,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    ]);
  }

  Widget _buildSkillsAndAppraisalHeaders(
      {required RepresentativeAppraisalFormDto dto}) {
    return Row(children: [
      Expanded(
        flex: 4,
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _secondaryColor,
          ),
          padding: const EdgeInsets.only(left: 18, top: 28, bottom: 20),
          child: Text(
            'appraisal.edit.generate.skills'.tr(),
            style: TextStyle(
              letterSpacing: -0.1,
              fontSize: 16,
              color: PdfColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(width: 2),
      Expanded(
        flex: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _secondaryColor,
              ),
              padding: const EdgeInsets.only(top: 7, bottom: 3),
              child: Center(
                child: Text(
                  'appraisal.edit.generate.auto_appraisal'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 43,
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _firstAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalNotMetSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _secondAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalInProgressSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _firstAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalAchievedSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _secondAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalProficientSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      SizedBox(width: 2),
      Expanded(
        flex: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _secondaryColor,
              ),
              padding: const EdgeInsets.only(top: 7, bottom: 3),
              child: Center(
                child: Text(
                  'appraisal.edit.generate.director'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 43,
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _firstAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalNotMetSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _secondAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalInProgressSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _firstAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalAchievedSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _secondAlternateColor,
                    ),
                    child: Center(
                      child: SvgImage(
                        svg: dto.appraisalProficientSvg,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildResponses({required RepresentativeAppraisalFormDto dto}) {
    Map<
            FillAppraisalScreenTab,
            Map<FillAppraisalScreenTabQuestion,
                Map<String, RepresentativeAppraisalQuestionResponse?>>>
        responses = {
      FillAppraisalScreenTab.survey: {
        FillAppraisalScreenTabQuestion.processKnowledge: {
          'representativeResponse': dto.processKnowledge,
          'directorResponse': dto.processKnowledgeByDirector,
        },
        FillAppraisalScreenTabQuestion.glossaryKnowledge: {
          'representativeResponse': dto.glossaryKnowledge,
          'directorResponse': dto.glossaryKnowledgeByDirector,
        },
        FillAppraisalScreenTabQuestion.meetingQuantity: {
          'representativeResponse': dto.meetingQuantity,
          'directorResponse': dto.meetingQuantityByDirector,
        },
        FillAppraisalScreenTabQuestion.meetingQuality: {
          'representativeResponse': dto.meetingQuality,
          'directorResponse': dto.meetingQualityByDirector,
        },
        FillAppraisalScreenTabQuestion.attitudeTowardsCustomer: {
          'representativeResponse': dto.attitudeTowardsCustomer,
          'directorResponse': dto.attitudeTowardsCustomerByDirector,
        },
      },
      FillAppraisalScreenTab.negociation: {
        FillAppraisalScreenTabQuestion.companyIntroduction: {
          'representativeResponse': dto.companyIntroduction,
          'directorResponse': dto.companyIntroductionByDirector,
        },
        FillAppraisalScreenTabQuestion.technicalNeedCreation: {
          'representativeResponse': dto.technicalNeedCreation,
          'directorResponse': dto.technicalNeedCreationByDirector,
        },
        FillAppraisalScreenTabQuestion.technicalPitchProficiency: {
          'representativeResponse': dto.technicalPitchProficiency,
          'directorResponse': dto.technicalPitchProficiencyByDirector,
        },
        FillAppraisalScreenTabQuestion.financialPitchProficiency: {
          'representativeResponse': dto.financialPitchProficiency,
          'directorResponse': dto.financialPitchProficiencyByDirector,
        },
        FillAppraisalScreenTabQuestion.attitudeAndMoodAtMeeting: {
          'representativeResponse': dto.attitudeAndMoodAtMeeting,
          'directorResponse': dto.attitudeAndMoodAtMeetingByDirector,
        },
        FillAppraisalScreenTabQuestion.meetingCustomization: {
          'representativeResponse': dto.meetingCustomization,
          'directorResponse': dto.meetingCustomizationByDirector,
        },
      },
      FillAppraisalScreenTab.opportunityRequestQuality: {
        FillAppraisalScreenTabQuestion.opportunityRequestQuality: {
          'representativeResponse': dto.opportunityRequestQuality,
          'directorResponse': dto.opportunityRequestQualityByDirector,
        },
      },
      FillAppraisalScreenTab.lifeAtWork: {
        FillAppraisalScreenTabQuestion.teamIntegration: {
          'representativeResponse': dto.teamIntegration,
          'directorResponse': dto.teamIntegrationByDirector,
        },
        FillAppraisalScreenTabQuestion.staffSocialInteraction: {
          'representativeResponse': dto.staffSocialInteraction,
          'directorResponse': dto.staffSocialInteractionByDirector,
        },
      },
    };
    return Column(
      children: [
        ...responses.entries.map((entry) {
          return Column(children: [
            SizedBox(height: 1),
            _buildResponsesGroup(entry.key, responses[entry.key]!),
          ]);
        }),
      ],
    );
  }

  Widget _buildResponsesGroup(
      FillAppraisalScreenTab tab,
      Map<FillAppraisalScreenTabQuestion,
              Map<String, RepresentativeAppraisalQuestionResponse?>>
          responses) {
    bool isTabAQuestion = false;
    if (responses.length == 1 && responses.entries.first.key.name == tab.name) {
      isTabAQuestion = true;
    }
    return Column(
      children: [
        isTabAQuestion == false
            ? Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _primaryColor,
                    ),
                    padding: const EdgeInsets.only(left: 18, top: 6, bottom: 4),
                    child: Text(
                      tab.label.toUpperCase(),
                      style: TextStyle(
                        color: PdfColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ])
            : SizedBox(),
        ...responses.entries.map((entry) {
          return Column(children: [
            isTabAQuestion == false ? SizedBox(height: 1) : SizedBox(),
            _buildResponsesGroupQuestion(
                entry.key,
                entry.value['representativeResponse'],
                entry.value['directorResponse'],
                isTab: isTabAQuestion)
          ]);
        }),
      ],
    );
  }

  Widget _buildResponsesGroupQuestion(
      FillAppraisalScreenTabQuestion question,
      RepresentativeAppraisalQuestionResponse? representativeResponse,
      RepresentativeAppraisalQuestionResponse? directorResponse,
      {bool isTab = false}) {
    return Row(children: [
      Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
            color: isTab == false ? _objectivesHeaderColor : _primaryColor,
          ),
          padding: const EdgeInsets.only(left: 18, top: 7, bottom: 5),
          child: Text(
            isTab == false ? question.label : question.label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              color: isTab == true ? PdfColors.white : null,
              fontWeight: isTab == true ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
      // representative
      Expanded(
        flex: 2,
        child: Row(children: [
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _firstAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(representativeResponse ==
                        RepresentativeAppraisalQuestionResponse.NOT_MET
                    ? 'X'
                    : ''),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _secondAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(representativeResponse ==
                        RepresentativeAppraisalQuestionResponse.IN_PROGRESS
                    ? 'X'
                    : ''),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _firstAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(representativeResponse ==
                        RepresentativeAppraisalQuestionResponse.ACHIEVED
                    ? 'X'
                    : ''),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _secondAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(representativeResponse ==
                        RepresentativeAppraisalQuestionResponse.PROFICIENT
                    ? 'X'
                    : ''),
              ),
            ),
          ),
        ]),
      ),
      SizedBox(width: 2),
      // director
      Expanded(
        flex: 2,
        child: Row(children: [
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _firstAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(directorResponse ==
                        RepresentativeAppraisalQuestionResponse.NOT_MET
                    ? 'X'
                    : ''),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _secondAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(directorResponse ==
                        RepresentativeAppraisalQuestionResponse.IN_PROGRESS
                    ? 'X'
                    : ''),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _firstAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(directorResponse ==
                        RepresentativeAppraisalQuestionResponse.ACHIEVED
                    ? 'X'
                    : ''),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: _secondAlternateColor,
              ),
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Center(
                child: Text(directorResponse ==
                        RepresentativeAppraisalQuestionResponse.PROFICIENT
                    ? 'X'
                    : ''),
              ),
            ),
          ),
        ]),
      ),
    ]);
  }

  Widget _buildImprovementPlan({required RepresentativeAppraisalFormDto dto}) {
    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: _firstAlternateColor,
          ),
          constraints: const BoxConstraints(
            minHeight: 75,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'appraisal.edit.generate.improvement_plan'.tr().toUpperCase(),
                style: TextStyle(
                  color: _primaryColor,
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 5),
              Text(
                dto.improvementPlan,
                style: const TextStyle(
                  fontSize: 10,
                  lineSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
