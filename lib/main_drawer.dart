import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  //builder για το ListTile
  Widget buildListTile(String title, IconData icon, Function pageHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: pageHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.indigo, //χρωμα του header του drawer
            // decoration:BoxDecoration(color:Colors.blue), διαφορετικος τροπος να περασουμε χρωμα
            child: Text(
              "Health",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          buildListTile("Home", Icons.home, () {
            Navigator.of(context)
                .pushNamed('/'); //η συναρτηση που περναμε στον pageHandler
          }),
          SizedBox(
            height: 10,
          ), //για να αφησουμε ενα κενο
          buildListTile("Heartrate", Icons.favorite, () {
            Navigator.pushNamed(context,
                '/heartrate'); //η συναρτηση που περναμε στον pageHandler
          }),
          SizedBox(
            height: 10,
          ), //για να αφησουμε ενα κενο
          buildListTile("Steps", Icons.directions_walk, () {
            Navigator.pushNamed(context,
                '/steps'); //η συναρτηση που περναμε στον pageHandler
          }),
          SizedBox(
            height: 10,
          ), //για να αφησουμε ενα κενο
          buildListTile("Sleep", Icons.hotel, () {
            Navigator.pushNamed(context,
                '/sleep'); //η συναρτηση που περναμε στον pageHandler
          }),
          SizedBox(
            height: 10,
          ), //για να αφησουμε ενα κενο
          buildListTile("Demographics", Icons.account_circle, () {
            Navigator.pushNamed(context,
                '/demographics'); //η συναρτηση που περναμε στον pageHandler
          }),
        ],
      ),
    );
  }
}
