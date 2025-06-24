import 'package:flutter/material.dart';
import 'package:messe/components/my_sidebar.dart';
import 'package:messe/components/user_tile.dart';
import 'package:messe/services/auth/auth_service.dart';
import 'package:messe/services/chat/chat_service.dart';
import 'package:messe/pages/chat_page.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService =  AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MySidebar(), 
      body: _buildUserList()  //sidebar
    );
  }

  // build a list of users except for the current logged in user
Widget _buildUserList() {
  return StreamBuilder(
    stream: _chatService.getUsersStream(),
    builder: (context, snapshot) {
      // error
      if (snapshot.hasError) {
        return const Text("Error");
      }

      // loading..
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading..");
      }

      // return list view
      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
      ); // ListView
    },
  ); // StreamBuilder
}


//build individual list tile for user
Widget _buildUserListItem(
  Map<String, dynamic> userData, BuildContext context){

    if(userData["email"] != _authService.getCurrentUser()!.email){    //does not show current user in the list of users
          return UserTile(
      text: userData["email"],
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverID: userData["uid"],
            ), 
            ),
         );
      },
    );
    }

    else{
      return Container();
    }

  }
}

