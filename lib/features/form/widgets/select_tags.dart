import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../topwr_mockup/features/sci_clubs_tab/repositories/tags_repository.dart';
import '../../topwr_mockup/widgets/my_error_widget.dart';

class SelectTags extends ConsumerWidget {
  const SelectTags(this.formControl, {super.key});

  final FormArray<bool>? formControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(remoteTagsRepositoryProvider);
    return switch (tags) {
      AsyncLoading() => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => TagsCheckboxList([
          ...value.whereNonNull,
          ...value.whereNonNull.map((e) => Tag(name: e.name + e.name))
        ], formControl),
    };
  }
}

class TagsCheckboxList extends ConsumerStatefulWidget {
  const TagsCheckboxList(this.tags, this.formControl, {super.key});
  final List<Tag>? tags;
  final FormArray<bool>? formControl;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TagsCheckboxListState();
}

class _TagsCheckboxListState extends ConsumerState<TagsCheckboxList> {
  bool isError = false;
  @override
  void initState() {
    widget.formControl?.addAll(
      widget.tags
              ?.map(
                (email) => FormControl<bool>(value: false),
              )
              .toList() ??
          [],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FormFieldConfig.padding,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorTheme.blackMirage,
          ),
          borderRadius: const BorderRadius.all(FormFieldConfig.radius),
        ),
        height: FormFieldConfig.bigSectionDefHeight * 1.5,
        child: ReactiveFormArray(
          formArray: widget.formControl,
          builder: (context, formArray, child) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      context.localize.form_sci_tags,
                      style: context.textTheme.headline,
                    ),
                  ),
                ),
                if (isError)
                  Text(
                    context.localize.max3tags,
                    style: context.textTheme.titleOrange,
                  ),
                Expanded(
                  child: ListView(
                    children: [
                      for (final iter in IterableZip([
                        formArray.controls,
                        widget.tags ?? [],
                      ]))
                        ReactiveCheckboxListTile(
                          key: ValueKey(iter.last?.name),
                          formControl: iter.first as FormControl<bool>?,
                          title: Text(iter.last?.name),
                          onChanged: (control) {
                            final allTrues = formArray.controls
                                .where((e) => e.value == true);
                            if (allTrues.length > 3) {
                              for (final element in allTrues) {
                                element.setErrors({"": ""});
                              }
                              setState(() {
                                isError = true;
                              });
                            } else {
                              for (final element in allTrues) {
                                element.setErrors({});
                              }
                              setState(() {
                                isError = false;
                              });
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
