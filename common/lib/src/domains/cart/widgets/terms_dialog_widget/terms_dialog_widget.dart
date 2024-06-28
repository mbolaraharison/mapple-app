import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class TermsDialogWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class TermsDialog extends StatefulWidget implements TermsDialogWidgetInterface {
  const TermsDialog({super.key});

  @override
  State<TermsDialog> createState() => _TermsDialogState();
}

class _TermsDialogState extends State<TermsDialog> {
  // Stores:--------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late CustomerOrderStoreInterface _customerOrderStore;
  late final TermsDialogStoreInterface _store =
      getIt<TermsDialogStoreInterface>();

  // Variables:-----------------------------------------------------------------
  late String terms = '';

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CartTermsNavigatorInterface _cartTermsNavigator =
      getIt<CartTermsNavigatorInterface>();

  // Utils:---------------------------------------------------------------------
  late final MarkdownUtilsInterface _markdownUtils =
      getIt<MarkdownUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _customerOrderStore = Provider.of<CustomerOrderStoreInterface>(context);
    _buildTerms();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(context, _store),
        child: _buildContent(context, _store),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildContent(BuildContext context, TermsDialogStoreInterface store) {
    return Column(
      children: [
        SizedBox(
          height: 410,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _markdownUtils.parse(terms, {
                        'agencyName': store.currentAgency?.label ?? '',
                        'agencyAddress': store.currentAgency?.address1 ?? '',
                        'agencyPostalCode':
                            store.currentAgency?.postalCode ?? '',
                        'agencyCity': store.currentAgency?.city ?? '',
                        'agencyPhone':
                            store.currentAgency?.formattedPhone ?? '',
                        'agencyEmail': store.currentAgency?.email ?? '',
                        'agencySiret': store.currentAgency?.siret ?? '',
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildAcceptDematerializationButton(context, store),
              const SizedBox(height: 5),
              _buildAcceptTermsButton(context, store),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, TermsDialogStoreInterface store) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            _customerOrderStore.signatureStepStore.step > 1
                ? 'close'.tr()
                : 'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => _rootNavigator.key.currentState?.pop(),
        ),
        middleContent: Text(
          'cart.terms'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: _customerOrderStore.signatureStepStore.step > 1
            ? null
            : Observer(
                builder: (_) {
                  return CupertinoButton(
                    onPressed: store.formIsValid
                        ? () {
                            _cartTermsNavigator.key.currentState!.pushNamed(
                              _cartTermsNavigator.signature,
                              arguments: TermsSelectSignatureMethodArguments(
                                store: store,
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      'next'.tr(),
                      style: store.formIsValid
                          ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                              .copyWith(fontWeight: FontWeight.w600)
                          : const TextStyle(
                              color: CupertinoColors.inactiveGray,
                            ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildAcceptDematerializationButton(
    BuildContext context,
    TermsDialogStoreInterface store,
  ) {
    return Observer(builder: (_) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _customerOrderStore.signatureStepStore.step > 1
            ? null
            : store.toggleAcceptanteDematerialization,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getIt<RadioWidgetInterface>(
              param1: RadioProps(
                value: _customerOrderStore.signatureStepStore.step > 1
                    ? true
                    : store.acceptanteDematerialization,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'cart.acceptance_dematerialization'.tr(),
              style: TextStyle(color: _appThemeData.defaultTextColor),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAcceptTermsButton(
    BuildContext context,
    TermsDialogStoreInterface store,
  ) {
    return Observer(builder: (_) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _customerOrderStore.signatureStepStore.step > 1
            ? null
            : store.toggleAcceptanteTerms,
        minSize: null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getIt<RadioWidgetInterface>(
              param1: RadioProps(
                value: _customerOrderStore.signatureStepStore.step > 1
                    ? true
                    : store.acceptanteTerms,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'cart.acceptance_terms'.tr(),
                style: TextStyle(color: _appThemeData.defaultTextColor),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _buildTerms() async {
    Representative? representative = await _representativeService.getCurrent();
    // get terms
    if (representative != null) {
      String fetchedTerms =
          await _customerOrderStore.order.getTerms(representative);
      setState(() {
        terms = fetchedTerms;
      });
    }
  }
}
