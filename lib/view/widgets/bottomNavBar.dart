import 'package:capstonedesign/dataSource/discover_dataSource.dart';
import 'package:capstonedesign/dataSource/fortune_dataSource.dart';
import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/view/screens/discover/discoverPage.dart';
import 'package:capstonedesign/view/screens/mypage/myPage.dart';
import 'package:capstonedesign/viewModel/first/homePage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/forumPage.dart';
import 'package:capstonedesign/view/screens/chat/chattingListPage.dart';
import 'package:provider/provider.dart';
import '../../model/chattingList.dart';
import '../../model/translate/LanguageProvider.dart';
import '../../model/translate/translationService.dart';
import '../../model/user.dart';
import '../../viewModel/chat/chattingListPage_viewModel.dart';
import '../../viewModel/discover/discoverPage_viewModel.dart';
import '../screens/chatBot/chatBotPage.dart';
import '../screens/first/homePage.dart';

class BottomNavBar extends StatefulWidget {
  final User user; // User 객체를 생성자에서 받도록 설정
  BottomNavBar({required this.user});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // User 객체를 각 페이지에 전달
    _pages = <Widget>[
      ChangeNotifierProvider(
        create: (_) => HomePageViewModel(discoverDatasource: DiscoverDatasource(), fortuneDataSource: FortuneDataSource(), postDataSource: PostDataSource()),
        child: HomePage(user: widget.user),
      ),

      ChangeNotifierProvider(
        create: (_) => DiscoverViewModel(datasource:DiscoverDatasource()),
        child: DiscoverPage(),
      ),

      ForumPage(user: widget.user),
      ChangeNotifierProvider(
          create: (_) => ChattingListViewModel(),
          child:  ChattingListPage(currentUserNickname: widget.user.nickname, user: widget.user,),
      ),
      MyPage(user: widget.user),
    ];
  }

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
          height: 100.0,
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
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: '찾아보기',
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
          MaterialPageRoute(builder: (context) => const ChatBotPage()),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        splashColor: Colors.transparent,
        child: Image.asset('assets/img/chatBot.png'),
      ),
    );
  }
}