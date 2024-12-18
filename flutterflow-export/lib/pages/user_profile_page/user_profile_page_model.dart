import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/change_email_modal/change_email_modal_widget.dart';
import '/components/change_name_modal/change_name_modal_widget.dart';
import '/components/change_phone_number_modal/change_phone_number_modal_widget.dart';
import '/components/confirm_details_confirmation_modal/confirm_details_confirmation_modal_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/user_profile_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'user_profile_page_widget.dart' show UserProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfilePageModel extends FlutterFlowModel<UserProfilePageWidget> {
  ///  Local state fields for this page.

  bool detailsJustConfirmed = false;

  bool detailsConfirmedFailure = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - decodeSupabaseJwt] action in UserProfilePage widget.
  SupabaseUserStruct? decodeTokenForProfileResponse;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for UserProfileRow component.
  late UserProfileRowModel userProfileRowModel1;
  // Model for UserProfileRow component.
  late UserProfileRowModel userProfileRowModel2;
  // Model for UserProfileRow component.
  late UserProfileRowModel userProfileRowModel3;
  // Stores action output result for [Bottom Sheet - ConfirmDetailsConfirmationModal] action in ConfirmDetails widget.
  bool? confirmDetailsModalResponse;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    userProfileRowModel1 = createModel(context, () => UserProfileRowModel());
    userProfileRowModel2 = createModel(context, () => UserProfileRowModel());
    userProfileRowModel3 = createModel(context, () => UserProfileRowModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    userProfileRowModel1.dispose();
    userProfileRowModel2.dispose();
    userProfileRowModel3.dispose();
  }
}
