import 'package:capstonedesign/dataSource/chatting_dataSource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstonedesign/view/screens/chat/chattingDetailPage.dart';
import 'package:capstonedesign/view/widgets/infoBox.dart';
import '../../../viewModel/chat/chattingListPage_viewModel.dart';

class ChattingListPage extends StatelessWidget {
  final String currentUserNickname;

  ChattingListPage({
    required this.currentUserNickname,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChattingListViewModel(ChattingDataSource()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(92, 67, 239, 60),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "채팅하기",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'SejonghospitalBold',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Infobox("채팅 페이지입니다", "1:1 대화로 친구를 만들어봐요"),
              SizedBox(height: 40.0),
              Expanded(
                child: Consumer<ChattingListViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (viewModel.chatList.isEmpty) {
                      return Center(child: Text("채팅방이 없습니다."));
                    }

                    return ListView.builder(
                      itemCount: viewModel.chatList.length,
                      itemBuilder: (context, index) {
                        final chat = viewModel.chatList[index];
                        final otherUserNickname = chat.members.firstWhere(
                              (user) => user.nickname != currentUserNickname,
                        ).nickname;

                        return InkWell(
                          onTap: () async {
                            // 채팅방으로 이동
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChattingDetailPage(
                                  currentUserNickname: currentUserNickname,
                                  otherUserNickname: otherUserNickname,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text(otherUserNickname[0]), // 유저 닉네임 첫 글자
                                ),
                                SizedBox(width: 26.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        otherUserNickname,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        chat.lastMessage, // 마지막 메시지
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  _formatTime(chat.updatedAt ?? chat.createdAt), // 마지막 시간
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}"; // 시간 포맷
  }
}