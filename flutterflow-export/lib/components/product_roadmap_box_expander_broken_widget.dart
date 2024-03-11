import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'product_roadmap_box_expander_broken_model.dart';
export 'product_roadmap_box_expander_broken_model.dart';

class ProductRoadmapBoxExpanderBrokenWidget extends StatefulWidget {
  const ProductRoadmapBoxExpanderBrokenWidget({super.key});

  @override
  State<ProductRoadmapBoxExpanderBrokenWidget> createState() =>
      _ProductRoadmapBoxExpanderBrokenWidgetState();
}

class _ProductRoadmapBoxExpanderBrokenWidgetState
    extends State<ProductRoadmapBoxExpanderBrokenWidget> {
  late ProductRoadmapBoxExpanderBrokenModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductRoadmapBoxExpanderBrokenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Product Roadmap',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          decoration: TextDecoration.underline,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context)
                                  .headlineMediumFamily),
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      'The Cepro team is working hard to enable microgrid customers to manage all aspects of their energy use through this “MyEnergy” app. New features are being rolled out regularly.\n',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: 600.0,
                  child: custom_widgets.ExpandableTextWidget(
                    width: double.infinity,
                    height: 600.0,
                    longText:
                        'This initial version (v1) of MyEnergy can be used to:\n    1. Check your smart meter serial number, mode and credit balance.\n    2. Review monthly energy consumption (power & lights, electric heat)\n    3. Add a payment method\n\nThe next app release (due in April) will support:\n    1. Signing your electricity supply agreement\n    2. Signing your solar installation usage agreement \n   3. Making payments for electricity consumption\n    4. Receiving credits for use of your solar installation\n',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
