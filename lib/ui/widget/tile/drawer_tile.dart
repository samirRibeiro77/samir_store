import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData _icon;
  final String _menuText;
  final PageController _pageController;
  final int _page;

  DrawerTile(this._icon, this._menuText, this._pageController, this._page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
          _pageController.jumpToPage(_page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                _icon,
                size: 32.0,
                color: _pageController.page.round() == _page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700]
              ),
              SizedBox(width: 32.0),
              Text(
                _menuText,
                style: TextStyle(
                  fontSize: 16.0,
                  color: _pageController.page.round() == _page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
