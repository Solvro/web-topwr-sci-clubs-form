import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../config/url_icons.dart";
import "../../../utils/determine_icon.dart";
import "../../form/model/form_model.dart";
import "../../form/widgets/form_fields.dart";

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
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8).copyWith(left: 12),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    url.isUrlEmail
                        ? ContactIconsConfig.mailLink
                        : url.url.determineIcon(),
                  ),
                ),
              ),
            ],
          ),
        );
}
