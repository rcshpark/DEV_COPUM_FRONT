import 'package:flutter/material.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  '사용자이름',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  width: 120,
                ),
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
        ),
      ),
    );
  }
}
