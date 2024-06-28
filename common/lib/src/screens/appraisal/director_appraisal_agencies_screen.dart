import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class DirectorAppraisalAgenciesScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class DirectorAppraisalAgenciesScreen extends StatelessWidget
    implements DirectorAppraisalAgenciesScreenInterface {
  // Constructor:---------------------------------------------------------------
  DirectorAppraisalAgenciesScreen({super.key});

  // Services:------------------------------------------------------------------
  late final RepresentativeAppraisalServiceInterface
      _representativeAppraisalsService =
      getIt<RepresentativeAppraisalServiceInterface>();
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Navigators:----------------------------------------------------------------
  late final AppraisalsNavigatorInterface _navigator =
      getIt<AppraisalsNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        disabledHeader: true,
        padding: EdgeInsets.zero,
        child: _buildContent(context),
        backgroundColor: MapleCommonColors.greyLightest,
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 336),
              child: Image.asset(
                MapleCommonAssets.bgRepresentativeAppraisals,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Column(
                children: [
                  const SizedBox(height: 17),
                  getIt<HeaderWidgetInterface>(
                    param1: HeaderProps(
                      title: 'representative_appraisals_title'.tr(),
                    ),
                  ),
                  const SizedBox(height: 34),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'appraisal.agencies'.tr(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildRepresentativeAppraisals(context),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildRepresentativeAppraisals(BuildContext context) {
    return StreamBuilder(
        stream: _representativeService.getCurrentAsStream(),
        builder: (_, AsyncSnapshot<Representative?> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          Representative representative = snapshot.data!;
          return StreamBuilder<List<Agency>>(
            stream: _agencyService.getAllByEmailAsStream(representative.email,
                roles: [Role.agencyDirector, Role.regionalDirector]),
            builder:
                (BuildContext context, AsyncSnapshot<List<Agency>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CupertinoActivityIndicator());
              }
              List<Agency> agencies = snapshot.data!;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                height: MediaQuery.of(context).size.height - 200,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: agencies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 180,
                  ),
                  itemBuilder: (context, index) {
                    return StreamBuilder<List<RepresentativeAppraisal>>(
                      stream: _representativeAppraisalsService
                          .getByAgencyIdAsStream(agencies[index].id),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<RepresentativeAppraisal>>
                              snapshot) {
                        return _buildAgencyButton(representative.email.trim(),
                            agencies[index], snapshot.data ?? []);
                      },
                    );
                  },
                ),
              );
            },
          );
        });
  }

  Widget _buildAgencyButton(
      String email, Agency agency, List<RepresentativeAppraisal> appraisals) {
    List<RepresentativeAppraisal> appraisalsForRepresentatives =
        appraisals.where((a) => a.completedByRepresentativeAt == null).toList();
    List<RepresentativeAppraisal> appraisalsForDirector = appraisals
        .where((a) =>
            a.completedByDirectorAt == null ||
            (a.completedByDirectorAt != null &&
                a.representativeAppraisalFormFileDataId == null))
        .toList();
    int doneAppraisalsCount = appraisals
        .where((a) =>
            a.completedByRepresentativeAt != null &&
            a.completedByDirectorAt != null &&
            a.representativeAppraisalFormFileDataId != null)
        .length;
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      color: CupertinoColors.white,
      disabledColor: const Color.fromRGBO(240, 240, 240, 1),
      onPressed: agency.canAccessRepresentativeAppraisalModule == true
          ? () {
              _navigator.key.currentState!.pushNamed(_navigator.agencyRoute,
                  arguments: DirectorAppraisalAgencyScreenArguments(
                      email: email, agency: agency));
            }
          : null,
      child: SizedBox(
        width: 340,
        height: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IntrinsicHeight(
                child: Row(
              children: [
                const VerticalDivider(
                  color: MapleCommonColors.red,
                  thickness: 4,
                  width: 1,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 270,
                        child: Text(
                          agency.city,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _appThemeData.defaultTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const SizedBox(height: 2),
                    Text(
                      'appraisal.done_appraisals'.tr(namedArgs: {
                        'doneCount': doneAppraisalsCount.toString(),
                        'totalCount': appraisals.length.toString(),
                      }),
                      style: TextStyle(
                        color: _appThemeData.activeMenuColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )),
            const SizedBox(height: 22),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IntrinsicHeight(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconTextNumberWidget(
                        MapleCommonAssets.recall,
                        'appraisal.appraisals_for_representative',
                        appraisalsForRepresentatives.length),
                    const VerticalDivider(
                      color: MapleCommonColors.greyLighter,
                      width: 1,
                      thickness: 1,
                    ),
                    _buildIconTextNumberWidget(
                        MapleCommonAssets.progressChart,
                        'appraisal.appraisals_for_director',
                        appraisalsForDirector.length),
                  ],
                )))
          ],
        ),
      ),
    );
  }

  Widget _buildIconTextNumberWidget(String icon, String text, int number) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              _appThemeData.buttonColor,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 86,
                child: Text(
                  text.tr(),
                  style: const TextStyle(
                    color: MapleCommonColors.greyLighter,
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                number.toString(),
                style: TextStyle(
                  color: _appThemeData.defaultTextColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}
