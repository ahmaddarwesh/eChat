import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/consts.dart';
import 'package:whatsapp_clone/providers/all_users.dart';
import 'package:whatsapp_clone/providers/message.dart';
import 'package:whatsapp_clone/providers/person.dart';
import 'package:whatsapp_clone/providers/user.dart';
import 'package:whatsapp_clone/screens/chat_item_screen.dart';

class ProfileInfo extends StatelessWidget {
  List<DocumentSnapshot> getItems(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> result = [];
    final userID = Provider.of<User>(context, listen: false).getUserId;
    snapshot.removeWhere((element) => element.documentID != userID);
  }

  Widget _buildImageAndName(BuildContext context, String imageUrl) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(          
          color: Hexcolor('#202020'),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          // border: Border.all(
          //   color: kBorderColor2,
          // ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () => print('edititng -------< '),
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Name here',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.87),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildSectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      );

  Widget _buildEmail(FirebaseUser user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('EMAIL ADDRESS'),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Hexcolor('#202020'),
            border: Border(
              bottom: BorderSide(color: kBorderColor2),
              top: BorderSide(color: kBorderColor2),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
            child: Text(
              user.email,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white.withOpacity(0.87),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAbout(FirebaseUser user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('ABOUT'),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Hexcolor('#202020'),
            border: Border(
              bottom: BorderSide(color: kBorderColor2),
              top: BorderSide(color: kBorderColor2),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
            child: Text(
              'Available',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white.withOpacity(0.87),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context).getUser;

    final mq = MediaQuery.of(context);
    return Column(
      children: [
        Container(
          height: mq.size.height * 0.12,
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            child: ListView(
              children: [
                _buildImageAndName(context,
                    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
                SizedBox(height: 30),
                _buildEmail(user),
                SizedBox(height: 30),
                _buildAbout(user),
              ],
            ),
          ),
        ),
      ],
    );
  }
}