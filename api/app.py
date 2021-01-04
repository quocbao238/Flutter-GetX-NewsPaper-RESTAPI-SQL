from flask import Flask, jsonify, request
import utils
app = Flask(__name__)






#  Lấy toàn bộ danh sách category
@app.route("/categories", methods=["GET"])
def get_categories():
    rows = utils.get_all("SELECT * FROM category",20)
    data = []
    for row in rows:
        data.append({
            "id":  row[0],
            "name": row[1],
            "url": row[2],
        })
    return jsonify({
        "categories": data
    })


#  Lấy toàn bộ danh sách bài viết , lấy 10 bài mới nhất
@app.route("/news", methods=["GET"])
def get_news():
    rows = utils.get_all("SELECT * FROM news", 10)
    data = []
    for row in rows:
        favorite = False
        if row[7] == 1:
            favorite = True
        data.append({
            "id": row[0],
            "subject": row[1],
            "image": row[3],
            "publish_date": row[6],
            "favorite": favorite
        })
    return jsonify({
        "news": data
    })


# Lấy danh sách bài viết theo categoryId
@app.route("/newsbycategoryid/<int:category_id>", methods=["GET"])
def get_news_by_category_id(category_id):
    rows = utils.get_news_by_categoryId(category_id)
    print(rows)
    data = []
    for row in rows:
        favorite = False
        if row[7] == 1:
            favorite = True
        data.append({
            "id": row[0],
            "subject": row[1],
            "image": row[3],
            "publish_date": row[6],
            "favorite": favorite
        })
    return jsonify({
        "news": data
    })


# Lấy dữ liệu chi tiết theo id
@app.route("/news/<int:news_id>", methods=["GET"])
def get_news_by_id(news_id):
    row = utils.get_news_by_id(news_id)
    data = {
        "subject": row[0],
        "description": row[1],
        "image": row[2],
        "original_url": row[3],
        "category_name": row[4],
        "category_url": row[5],
        "publish_date": row[6]
    }

    return jsonify({
        "product": data
    })


@app.route("/news/<int:news_id>", methods=["POST"])
def insert_comments(news_id):
    # import pdb
    # pdb.set_trace()
    if request.form.get("content"):
        utils.add_commnet(news_id, request.form["content"], request.form["timeCreate"])

        return jsonify({
            "status_code": 200,
            "message": "Successful"
        })

    return jsonify({
        "status_code": -1,
        "message": "Need News Id"
    })

@app.route("/comment/<int:news_id>", methods=["GET"])
def get_comments(news_id):
    rows = utils.get_comment(news_id)
    data = []
    for r in rows:
        data.append({
            "id": r[0],
            "content": r[1],
            "time_create": r[3]
        })

    return jsonify({
        "comment": data
    })


@app.route("/news/add", methods=["POST"])
def insert_news():
    pass


if __name__ == "__main__":
    utils.get_news_url()
    app.run()
