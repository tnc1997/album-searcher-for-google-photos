import 'package:googleapis/photoslibrary/v1.dart';

int albumComparator(Album a, Album b) {
  final titleA = a.title;
  final titleB = b.title;

  return titleA != null && titleB != null ? titleA.compareTo(titleB) : 0;
}
