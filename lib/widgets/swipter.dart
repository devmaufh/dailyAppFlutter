import 'package:daily_pick/models/NasaPic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FavoritesPicsSwiper extends StatefulWidget {
  List<FotoModel> fotosList;
  FavoritesPicsSwiper({@required this.fotosList});

  FavoritesPicsSwiperState createState() => FavoritesPicsSwiperState();
}

class FavoritesPicsSwiperState extends State<FavoritesPicsSwiper> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: new Image.network(
                widget.fotosList[index].url,//"http://via.placeholder.com/288x188",
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: widget.fotosList.length,
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
        ));
  }
}
