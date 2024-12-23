enum NewsCategory {
  business,
  technology,
  sports,
  science,
  general,
  health,
  entertainment;

  static NewsCategory? stringToNewsCategory(String? categoryString) {
    if (categoryString == null) {
      return null;
    }
    try {
      return NewsCategory.values
          .firstWhere((cate) => (cate.name == categoryString));
    } catch (e) {
      return null;
    }
  }
}
