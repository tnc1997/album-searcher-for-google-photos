import 'package:googleapis/photoslibrary/v1.dart';

import '../extensions/string_extensions.dart';
import '../specifications/specification.dart';

class AlbumTitleSpecification extends Specification<Album> {
  final String title;

  const AlbumTitleSpecification({
    required this.title,
  });

  @override
  bool isSatisfiedBy(Album value) {
    final title = value.title;

    return title != null && title.uglify().contains(this.title.uglify());
  }
}
