import 'package:deli_meals_app/pages/filters.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildDrawerHeader(context),
          _buildListTile(context, 'Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _buildListTile(context, 'Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersPage.routeName);
          }),
        ],
      ),
    );
  }

  ListTile _buildListTile(
      BuildContext context, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor.withOpacity(0.7),
            Theme.of(context).accentColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Icon(
              Icons.room_service,
              size: 18,
            ),
          ),
          SizedBox(width: 15),
          Text(
            'Let\'s start cooking!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
