import 'package:flutter/material.dart';

import '../../../config/url_icons.dart';
import '../../../utils/determine_icon.dart';
import '../../form/model/form_model.dart';
import '../../form/widgets/form_fields.dart';

class LinkField extends MyFormField {
  LinkField(
    SocialUrl url,
    super.label, {
    super.key,
    super.formControl,
    super.formControlName,
    super.hintText,
    super.suffixIcon,
  }) : super(
          prefixIcon: Image.asset(
            url.isUrlEmail ? IconsConfig.mailLink : url.url.determineIcon(),
          ),
        );
}
