import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/serializable_model/allchats.dart';
import '../../net/http_client.dart';
import '../../provider/provider_provider.dart';
import '../chats/widgets/conversation_list.dart';

class AllChatsScreenProvider extends StatefulWidget {
  const AllChatsScreenProvider({Key? key}) : super(key: key);

  @override
  State<AllChatsScreenProvider> createState() => _AllChatsScreenProviderState();
}

class _AllChatsScreenProviderState extends State<AllChatsScreenProvider> {
  TextEditingController searchController = TextEditingController();
  late int cardViewed;
  bool alreadyowned = false;
  int otherpersonid = 0;
  String otherpersoname = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Chats",
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      )),
      body: Column(children: [
        SizedBox(height: ScreenUtil().setHeight(17)),
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 14.sp),
                        border: InputBorder.none),
                    controller: searchController,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    // messeges.add(Chat(
                    //     senderid: loggedinuser.user.id,
                    //     message: messegecontroller.text));
                    // setmessegesstate((() => {}));
                    // Map<String, dynamic> body = {
                    //   "user": loggedinuser.user.id,
                    //   "thread": threadid,
                    //   "receiver": otheruserid,
                    //   "message": messegecontroller.text
                    // };
                    // var jsonString = json.encode(body);
                    // mychannel.sink.add(jsonString);
                    // messegecontroller.clear();
                  },
                  child: CircleAvatar(
                    radius: 25.h,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          // height: 480.h,
          child: Consumer<ProviderProvider>(
              builder: (context, loggedinprovider, child) {
            return FutureBuilder(
                future: HttpClient()
                    .getallchats(loggedinprovider.provider.id.toString()),
                builder: (context, AsyncSnapshot<List<AllChats>> allchats) {
                  if (allchats.connectionState != ConnectionState.done) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 220.h),
                      child: const CircularProgressIndicator(),
                    ));
                  }
                  return ListView.builder(
                    itemCount: allchats.data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (loggedinprovider.provider.id ==
                          allchats.data![index].useroneid) {
                        otherpersonid = allchats.data![index].usertwoid;
                        otherpersoname = allchats.data![index].usertwoname;
                      } else {
                        otherpersonid = allchats.data![index].useroneid;
                        otherpersoname = allchats.data![index].useronename;
                      }
                      return Column(
                        children: [
                          ConversationList(
                            threadid: allchats.data![index].threadid,
                            userid: otherpersonid,
                            name: otherpersoname,
                            messageText: allchats.data![index].message,
                            imageUrl:
                                'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                            time: '12:21 pm',
                          ),
                          5.verticalSpace,
                          const Divider(thickness: 0.7)
                        ],
                      );
                    },
                  );
                });
          }),
        ),
      ]),
    );
  }
}
