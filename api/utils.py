import sqlite3
from newspaper import Article
import newspaper
#  Lấy danh sách bài báo
def get_all(query):
    connection = sqlite3.connect("data/newsdb.db")
    data = connection.execute(query).fetchall()
    connection.close()
    return data

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
    INSERT INTO news(subject, description, image, original_url, category_id, publish_date)
    VALUES (?, ?, ?, ?, ?, ?)
    """
    article = Article(url)
    article.download()
    article.parse()

    conection.execute(sql, (article.title, article.text, article.top_img, article.url, category_id, article.publish_date ))

    conection.commit()


# Lấy bài báo cho các doanh mục
def get_news_url():
    categories = get_all("SELECT * FROM category")
    connection = sqlite3.connect("data/newsdb.db")
    for cat in categories:
        cat_id = cat[0]
        url = cat[2]
        print(url)
        cat_paper = newspaper.build(url)
        for article in cat_paper.articles:
            try:
                print("=====", article.url)
                add_news(connection, article.url, cat_id)
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