import sqlite3
from newspaper import Article
from html.parser import HTMLParser
import newspaper

webUrl = "https://thanhnien.vn/"


#  Lấy danh sách bài báo && category
def get_all(query,index):
    connection = sqlite3.connect("data/newsdb.db")
    data = connection.execute(query).fetchmany(index)
    connection.close()
    return data


# Lấy danh sách theo id
def get_news_by_categoryId(category_id):
    connection = sqlite3.connect("data/newsdb.db")
    sql = """
    SELECT id,
           subject,
           description,
           image,
           original_url,
           category_id,
           publish_date,
           favorite
      FROM news (
               SELECT id,
                      subject,
                      description,
                      image,
                      original_url,
                      category_id,
                      publish_date,
                      favorite
                 FROM news
           )
     WHERE category_id = ?;
    """

    resultListNews = connection.execute(sql, (category_id, )).fetchall()
    connection.close()
    return resultListNews


# Lấy danh sách theo id
def get_news_by_id(news_id):
    connection = sqlite3.connect("data/newsdb.db")
    sql = """
    SELECT
       N.subject,
       N.description,
       N.image,
       N.original_url,
       C.name,
       C.url
    FROM news N INNER JOIN category C ON N.category_id=C.id
    WHERE N.id=?
    """

    resultNews = connection.execute(sql, (news_id, )).fetchone()
    connection.close()
    return resultNews

# Lấy bài báo về dùng lib newspaper
def add_news(conection, url, category_id):
    sql = """
    INSERT INTO news(subject, description, image, original_url, category_id, publish_date, favorite)
    VALUES (?, ?, ?, ?, ?, ?, ?)
    """
    article = Article(url)
    article.download()
    article.parse()

    conection.execute(sql, (article.title, article.text, article.top_img, article.url, category_id, article.publish_date, 'TRUE' ))

    conection.commit()


# Doanh muc category
def get_cat_id(url):
    _cat_id = 0
    if "/video/" in url:
        _cat_id = 16
    elif "/thoi-su/" in url:
        _cat_id = 1
    elif "/the-gioi/" in url:
        _cat_id = 2
    elif "/tai-chinh-kinh-doanh/" in url:
        _cat_id = 3
    elif "/doi-song/" in url:
        _cat_id = 4
    elif "/van-hoa/" in url:
        _cat_id = 5
    elif "/giai-tri/" in url:
        _cat_id = 6
    elif "/gioi-tre/" in url:
        _cat_id = 7
    elif "/giao-duc/" in url:
        _cat_id = 8
    elif "/the-thao/" in url:
        _cat_id = 9
    elif "/suc-khoe/" in url:
        _cat_id = 10
    elif "/du-lich/" in url:
        _cat_id = 11
    elif "/cong-nghe/" in url:
        _cat_id = 12
    elif "/xe/" in url:
        _cat_id = 13
    elif "/game/" in url:
        _cat_id = 14
    elif "thoitrangtre." in url:
        _cat_id = 15
    else:
        _cat_id = 17

    return _cat_id



# Lấy bài báo cho các doanh mục
def get_news_url():
    connection = sqlite3.connect("data/newsdb.db")
    cat_paper = newspaper.build(webUrl)
    for article in cat_paper.articles:
        try:
            print("=====", article.url)
            _cat_id = get_cat_id(article.url)
            add_news(connection, article.url, _cat_id)
        except Exception as ex:
                print("ERROR " + str(ex))
                pass

    connection.close()


# add comment
def add_commnet(news_id, content, time_create):
    connection = sqlite3.connect("data/newsdb.db")
    sql = '''
    INSERT INTO comment(content, news_id, time_create) 
    VALUES (?, ?, ?)
    '''
    connection.execute(sql, (content, news_id, time_create)).fetchall()
    connection.commit()
    connection.close()


def get_comment(news_id):
    connection = sqlite3.connect("data/newsdb.db")
    sql = '''
    SELECT id,
       content,
       news_id,
       time_create
    FROM (
           SELECT id,
                  content,
                  news_id,
                  time_create
             FROM comment
       )
    WHERE news_id = ?;
    '''
    resultComment = connection.execute(sql, (news_id, )).fetchall()
    connection.close()
    return resultComment



if __name__ == "__main__":
    get_news_url()
