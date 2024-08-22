import 'package:capstonedesign/view/screens/discover/discoverPage.dart';
import 'package:capstonedesign/view/screens/mypage/myPage.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/forumPage.dart';
import 'package:capstonedesign/view/screens/chat/chattingListPage.dart';
import '../screens/chatBot/chatBotPage.dart';
import '../screens/first/homePage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    HomePage(),
    ForumPage(),
    ChattingListPage(),
    /*MyPage()*/
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
     ),
      child: Container(
        height: 70.0,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
       ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color.fromRGBO(92, 67, 239, 50),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: '게시판',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.send),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatBotPage()),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        splashColor: Colors.transparent,
        // child: Image.asset('assets/img/chatBot.png'),
      ),
    );
  }
}