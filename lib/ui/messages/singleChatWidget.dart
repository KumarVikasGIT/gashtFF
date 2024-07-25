
import 'package:flutter/material.dart';
import 'package:gasht/ui/messages/chatMessages.dart';


class SingleChatWidget extends StatefulWidget{
  const SingleChatWidget({super.key, this.chatMessage, this.chatTitle, this.seenStatusColor, this.imageUrl});

  @override
  State<SingleChatWidget> createState() => _SingleChatWidget ();
  final String? chatMessage;
  final String? chatTitle;
  final Color? seenStatusColor;
  final String? imageUrl;
}

class _SingleChatWidget extends State<SingleChatWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>   const ChatMessages(),//const PlayList( tag: 'Playlists',title:'Podcast'),
          ),
        );
      },
      child:  Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(widget.imageUrl!),
        ),
        Expanded(
          child: ListTile(
            title: Text('${widget.chatTitle}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Row(children: [
              Icon(
                widget.seenStatusColor == Colors.blue ? Icons.done_all : Icons.done,
                size: 15,
                color: widget.seenStatusColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    '${widget.chatMessage}',
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ]),
            trailing: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Yesterday',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),);
  }
  
}