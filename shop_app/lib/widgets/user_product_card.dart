import 'package:flutter/material.dart';
import 'package:shop_app/pages/edit_product_page.dart';

class UserProductCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function deleteHandler;

  const UserProductCard(this.id, this.title, this.imageUrl, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/images/placeholder.png'),
        width: 50,
        height: 50,
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditProductPage.routeName, arguments: id),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: deleteHandler,
            ),
          ],
        ),
      ),
    );
  }
}
