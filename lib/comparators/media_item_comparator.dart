import 'package:googleapis/photoslibrary/v1.dart';

int mediaItemComparator(MediaItem a, MediaItem b) {
  final nameA = a.filename;
  final nameB = b.filename;

  return nameA != null && nameB != null ? nameA.compareTo(nameB) : 0;
}
