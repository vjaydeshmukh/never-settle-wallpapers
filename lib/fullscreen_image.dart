import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:transparent_image/transparent_image.dart';

const String _appTitle = "Never Settle";

class FullScreenImagePage extends StatefulWidget {
  final String imgPath;
  FullScreenImagePage(this.imgPath);

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImagePageState();
  }
}


class _FullScreenImagePageState extends State<FullScreenImagePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String result = "Waiting to set wallpaper";
  String imgPath;

  @override
  void initState() {
    imgPath = widget.imgPath;
    super.initState();
  }

  final LinearGradient backGroundGradient = new LinearGradient(
      colors: [new Color(0x30000000), new Color(0x80000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
            title: Text(_appTitle),
          ),
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backGroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                child: new Hero(
                  tag: imgPath,
                  child: Column(children: [
                    Stack(
                        alignment: Alignment.center,
                        children: [
                          Center( child: CircularProgressIndicator()),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              height: MediaQuery.of(context).size.height - 130,
                              placeholder: kTransparentImage,
                              image: imgPath,
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: <Widget>[
                        Expanded(child:RaisedButton(
                      onPressed: () async {
                        _showSnackBar(result);
                        String res = await Wallpaper.homeScreen(imgPath);
                        if (!mounted) return;
                        setState(() {
                          result = res;
                          _showSnackBar(result);
                        });
                      },
                      child: Text("Set as wallpaper"),
                    )),
                    Expanded(child:RaisedButton(
                      onPressed: (){
                        // TODO: implement this to download
                      },
                      child: Text("Download wallpaper"),
                    ))    
                    
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   _showSnackBar(String text,
      {Duration duration = const Duration(seconds: 1, milliseconds: 500)}) {
    return scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(text), duration: duration));
  }
}
