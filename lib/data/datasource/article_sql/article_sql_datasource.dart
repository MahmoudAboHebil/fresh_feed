import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/sql_conversion.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArticleSqlDatasource {
  static final ArticleSqlDatasource _instance = ArticleSqlDatasource._();
  ArticleSqlDatasource._();
  factory ArticleSqlDatasource() {
    return _instance;
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final myPath = join(dbPath, 'articles.db');
    return await openDatabase(
      myPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sourceId TEXT,
    artTitle TEXT,
    name TEXT,
    description TEXT,
    url TEXT,
    category TEXT,
    language TEXT,
    country TEXT
)
    ''');
    await db.execute('''
    CREATE TABLE articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    url TEXT,
    urlToImage TEXT,
    publishedAt TEXT,
    content TEXT,
    source_fk INTEGER,
    author TEXT,
    FOREIGN KEY (source_fk) REFERENCES sources(id)
)
    ''');
  }

  Future<int> addArticle(Article article) async {
    try {
      final db = await database;
      final sourceFK = await db.insert(
        'sources',
        SqlConversion.convertSourceToSql(
            source: article.source, article: article),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final response = await db.insert(
        'articles',
        SqlConversion.convertArticleToSql(article: article, sourceFK: sourceFK),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> updateArticle(Article article) async {
    try {
      final db = await database;
      final sourceSql = SqlConversion.convertSourceToSql(
          source: article.source, article: article);
      await db.update(
        'sources',
        sourceSql,
        where: 'sourceId = ? AND artTitle = ? ',
        whereArgs: [sourceSql['sourceId'], article.title],
      );
      final articleSql = SqlConversion.convertArticleToSql(article: article);
      final response = await db.update(
        'articles',
        articleSql,
        where: 'title = ?',
        whereArgs: [
          articleSql['title'],
        ],
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteArticle(Article article) async {
    try {
      final db = await database;
      await db.delete(
        'sources',
        where: 'sourceId = ? AND artTitle = ? ',
        whereArgs: [article.source?.id, article.title],
      );
      final response = await db.delete(
        'articles',
        where: 'title = ?',
        whereArgs: [
          article.title,
        ],
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllArticles() async {
    try {
      const String query = '''
    SELECT 
      articles.title,
      articles.description,
      articles.url,
      articles.urlToImage,
      articles.publishedAt,
      articles.content,
      articles.author,
      sources.sourceId,
      sources.artTitle,
      sources.name,
      sources.description AS source_description,
      sources.url AS source_url,
      sources.category,
      sources.language,
      sources.country
    FROM articles
    INNER JOIN sources ON articles.source_fk = sources.id
     ORDER BY articles.id DESC

  ''';

      final db = await database;
      List<Map<String, dynamic>> response = await db.rawQuery(query);

      final organisedResponse = response.map((res) {
        return SqlConversion.convertSqlMapToArticleMap(res);
      }).toList();

      return organisedResponse;
    } catch (e) {
      rethrow;
    }
  }
}
