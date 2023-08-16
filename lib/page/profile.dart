import 'dart:convert';

import 'package:copum_front_update/model/user_model.dart';
import 'package:copum_front_update/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text('내 프로필'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 40, right: 20),
        child: Consumer<UserInfoProvider>(builder: (_, p, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 50,
                    backgroundImage:
                        NetworkImage("${p.userModel.profileImage}"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${p.userModel.nickname}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white70),
                      child: const Text(
                        '수정하기',
                        style: TextStyle(color: Colors.black54),
                      )),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
