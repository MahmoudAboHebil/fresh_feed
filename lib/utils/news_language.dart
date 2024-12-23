enum NewsLanguage {
  ar("Arabic"),
  de("German"),
  en("English"),
  es("Spanish"),
  fr("French"),
  he("Hebrew"),
  it("Italian"),
  nl("Dutch"),
  no("Norwegian"),
  pt("Portuguese"),
  ru("Russian"),
  sv("Swedish"),
  ud("Undefined"),
  zh("Chinese");

  final String description;
  const NewsLanguage(this.description);

  static NewsLanguage? stringToNewsLanguage(String? languageString) {
    if (languageString == null) {
      return null;
    }
    try {
      return NewsLanguage.values
          .firstWhere((lan) => (lan.name == languageString));
    } catch (e) {
      return null;
    }
  }
}
