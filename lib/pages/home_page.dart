import 'package:daily_pick/api/api_provider.dart';
import 'package:daily_pick/bloc/foto_bloc.dart';
import 'package:daily_pick/models/NasaPic.dart';
import 'package:daily_pick/utils/consts.dart';
import 'package:daily_pick/widgets/swipter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FotoModel modelFoto =
      new FotoModel(url: "        ", title: "Loading                    ");
  var itemC;
  var swipter;
  @override
  void initState() {
    itemC = CircularProgressIndicator();
    swipter= CircularProgressIndicator();
    ApiProvider().getDailyPick().then((apiResult) {
      setState(() {
        modelFoto = apiResult;
        itemC = card(modelFoto.url, modelFoto.title);
      });
    });
    FotoBloc().selectAllFotos().then((listFotos){
      setState(() {
        print(listFotos.length);
       swipter = FavoritesPicsSwiper(fotosList: listFotos,); 
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _background(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titles(
                    "Daily pick",
                    "Daily picture from NASA Astronomy Picture of the Day",
                    Colors.white),
                itemC,
                _titles("Favorites","Look again that picture you liked                     ",Colors.white),
                //_swipter()
                swipter
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titles(String title, String description, Color textColor) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: TextStyle(color: textColor, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _background() {
    final gradient = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [Consts.darken, Consts.primary])),
    );

    return Stack(
      children: <Widget>[
        gradient,
      ],
    );
  }

  Widget card(String url, String title) {
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .9,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  
}
