import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:reactive_forms/reactive_forms.dart";

import "../../utils/context_extensions.dart";
import "../image_dropzone/image_dropzone.dart";
import "../mockup_frame/breakpoint.dart";
import "../mockup_frame/preview_fab.dart";
import "../social_links_subform/social_links_form.dart";
import "model/form_model.dart";
import "widgets/fab_send.dart";
import "widgets/form_fields.dart";
import "widgets/form_header.dart";
import "widgets/form_padding.dart";
import "widgets/html_field.dart";
import "widgets/select_tags.dart";
import "widgets/type_choice_field.dart";

class SciClubForm extends ConsumerWidget {
  const SciClubForm({super.key});

  static const children = [
    FormHeader(),
    _NameField(),
    _DeptField(),
    _TypeChoiceField(),
    _LogoField(),
    _CoverField(),
    _LinksForm(),
    _TagsField(),
    _ShortDescField(),
    _DescField(),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormPadding(
      child: SliverToBoxAdapter(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: const Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class _DescField extends StatelessWidget {
  const _DescField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return WYSIWYGEditor(
      context.localize.form_sci_desc,
      formModel.descriptionControl,
    );
  }
}

class _ShortDescField extends StatelessWidget {
  const _ShortDescField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return MyFormField(
      context.localize.form_sci_short_desc,
      formControl: formModel.shortDescriptionControl,
    );
  }
}

class _TagsField extends StatelessWidget {
  const _TagsField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return SelectTags(
      formModel.tagsControl,
    );
  }
}

class _LinksForm extends StatelessWidget {
  const _LinksForm();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return SocialLinksForm(
      formModel: formModel,
    );
  }
}

class _CoverField extends StatelessWidget {
  const _CoverField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return ImageDropzone(
      label: context.localize.form_cover,
      formControl: formModel.coverControl,
    );
  }
}

class _LogoField extends StatelessWidget {
  const _LogoField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return ImageDropzone(
      label: context.localize.form_logo,
      formControl: formModel.logoControl,
    );
  }
}

class _TypeChoiceField extends StatelessWidget {
  const _TypeChoiceField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return TypeChoiceField(
      formModel.typeControl,
    );
  }
}

class _DeptField extends StatelessWidget {
  const _DeptField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;

    return MyFormField(
      context.localize.form_sci_club_department,
      formControl: formModel.departmentControl,
      counterText: context.localize.dept_form_info,
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveSciClubFormModelForm.of(context)!;
    return MyFormField(
      context.localize.form_sci_club_name,
      formControl: formModel.nameControl,
    );
  }
}

class SciClubFormScaffold extends StatefulWidget {
  final Widget child;

  const SciClubFormScaffold({super.key, required this.child});

  @override
  State<SciClubFormScaffold> createState() => _SciClubFormScaffoldState();
}

class _SciClubFormScaffoldState extends State<SciClubFormScaffold> {
  bool shouldElevateBtns = false;

  @override
  void initState() {
    FocusManager.instance.addListener(weirdFocusListener);
    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(weirdFocusListener);
    super.dispose();
  }

  void weirdFocusListener() {
    setState(() {
      shouldElevateBtns = ReactiveSciClubFormModelForm.of(
            context,
          )?.form.anyControls(
                (controll) => controll is FormControl && controll.hasFocus,
              ) ??
          false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: // workaround, but the editor is buggy :/
              shouldElevateBtns ? MediaQuery.viewInsetsOf(context).bottom : 0,
        ),
        child: const _FABs(),
      ),
      body: widget.child,
      primary: false,
    );
  }
}

class _FABs extends StatelessWidget {
  const _FABs();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!context.showSplitView)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: ShowPreviewFAB(),
          ),
        const FabSend(),
      ],
    );
  }
}
