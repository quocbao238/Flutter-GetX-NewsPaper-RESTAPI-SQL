import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: _dataList());

  Widget _dataList() => Container(
      margin: EdgeInsets.only(right: 16.0, top: 16.0),
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => __dataItem()));

  Widget __dataItem() => Container(
        margin: EdgeInsets.only(bottom: 16.0),
        height: 130.0,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://cdn.tuoitre.vn/zoom/600_315/2020/12/31/img8803-16093924123941810518087-crop-16093937913781515813735.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 8.0, right: 8.0),
                            child: Text(
                              "Video: Nóng thời điểm giáp Tết, bắt lái xe bán tải cùng hàng trăm kí pháo lậu,Video: Nóng thời điểm giáp Tết, bắt lái xe bán tải cùng hàng trăm kí pháo lậu,Video: Nóng thời điểm giáp Tết, bắt lái xe bán tải cùng hàng trăm kí pháo lậu,Video: Nóng thời điểm giáp Tết, bắt lái xe bán tải cùng hàng trăm kí pháo lậu",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '5 min ago',
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.favorite, color: Colors.red),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
