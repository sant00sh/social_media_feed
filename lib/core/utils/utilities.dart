import 'dart:math';

class Utilities {
  // Generate a list of random avatar URLs
  static List<String> generateRandomAvatarUrls(int count) {
    return List<String>.generate(count, (index) {
      final randomNumber = Random().nextInt(1000);
      return 'https://i.pravatar.cc/300?u=$randomNumber';
    });
  }

  // Generate a list of random feed image URLs
  static List<String> generateRandomFeedUrls(int count) {
    return List<String>.generate(count, (index) {
      final randomNumber = Random().nextInt(1000);
      return 'https://picsum.photos/id/$randomNumber/500/300';
    });
  }
}