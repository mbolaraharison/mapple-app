import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomersProjectCardWidgetInterface implements Widget {
  CustomersProjectCardProps get props;
}

// Props:-----------------------------------------------------------------------
class CustomersProjectCardProps {
  const CustomersProjectCardProps({
    required this.order,
  });

  final Order order;
}

// Implementation:--------------------------------------------------------------
class CustomersProjectCard extends StatefulWidget
    implements CustomersProjectCardWidgetInterface {
  const CustomersProjectCard({super.key, required this.props});

  @override
  final CustomersProjectCardProps props;

  @override
  State<CustomersProjectCard> createState() => _CustomersProjectCardState();
}

class _CustomersProjectCardState extends State<CustomersProjectCard> {
  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _onProjectTap(widget.props.order),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) =>
                              _getGradient(widget.props.order).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: SvgPicture.asset(
                            widget.props.order.statusIcon,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) =>
                              _getGradient(widget.props.order).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            widget.props.order.status.label,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'project.list.order_at'.tr(),
                                            style: TextStyle(
                                              color: _appThemeData
                                                  .defaultTextColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: Text(
                                            widget.props.order
                                                        .envelopeSignedAt !=
                                                    null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(widget.props.order
                                                        .envelopeSignedAt!)
                                                : '-',
                                            style: TextStyle(
                                              color: _appThemeData
                                                  .defaultTextColor,
                                              fontSize: 17,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'project.list.install_at'.tr(),
                                        style: TextStyle(
                                          color: _appThemeData.defaultTextColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          widget.props.order.installAt != null
                                              ? DateFormat('dd/MM/yyyy').format(
                                                  widget.props.order.installAt!)
                                              : '-',
                                          style: TextStyle(
                                            color:
                                                _appThemeData.defaultTextColor,
                                            fontSize: 17,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'project.list.payment_method'.tr(),
                                            style: TextStyle(
                                              color: _appThemeData
                                                  .defaultTextColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              widget.props.order.paymentTerms
                                                  .label,
                                              style: TextStyle(
                                                color: _appThemeData
                                                    .defaultTextColor,
                                                fontSize: 17,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'project.list.services'.tr(),
                                    style: TextStyle(
                                      color: _appThemeData.defaultTextColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ..._servicesListWidget(
                                    widget.props.order.orderRows,
                                  ),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              width: 20,
                            ),
                            IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'project.list.total'.tr(),
                                    style: TextStyle(
                                      color: _appThemeData.defaultTextColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) =>
                                        _getGradient(widget.props.order)
                                            .createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    ),
                                    child: Text(
                                      widget
                                          .props.order.formattedTotalNetInclTax,
                                      style: TextStyle(
                                        color: _appThemeData.defaultTextColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'project.list.representatives'.tr(),
                          style: TextStyle(
                            color: _appThemeData.defaultTextColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          widget.props.order.representivesFullnames.isNotEmpty
                              ? widget.props.order.representivesFullnames
                              : '-',
                          style: TextStyle(
                            color: _appThemeData.defaultTextColor,
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                      ],
                    )
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    color: CupertinoColors.opaqueSeparator.withOpacity(.5),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  void _onProjectTap(Order order) {
    Navigator.of(context).pushNamed(
      _customerTabNavigator.viewProjectRoute,
      arguments: CustomerViewProjectScreenArguments(order: order),
    );
  }

  List<Widget> _servicesListWidget(List<OrderRow> orderRows) {
    return orderRows.map(
      (OrderRow orderRow) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    orderRow.service!.label,
                    maxLines: 2,
                    style: TextStyle(
                      color: _appThemeData.defaultTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  orderRow.formattedTotalNetInclTax,
                  style: TextStyle(
                    color: _appThemeData.defaultTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ).toList();
  }

  LinearGradient _getGradient(Order order) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        order.colors[0],
        order.colors[1],
      ],
    );
  }
}
