import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firetuto/screens/auth/login_screen.dart';
import 'package:firetuto/screens/posts/add_posts.dart';
import 'package:firetuto/utils/utils.dart';
import 'package:flutter/material.dart';

//ignore_for_file:prefer_const_constructors

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Page"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {
                  
                });
              },
            ),
          )
          ,
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                    

                    //search filter logic
                  final title = snapshot.child('title').value.toString();
                  if(searchFilter.text.isEmpty){
                     return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(itemBuilder: (context) =>[
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                        leading: Icon(Icons.edit),
                        onTap:(){
                        
                          Navigator.pop(context);
                          showMyDialog(title,snapshot.child('id').value.toString() );
                        } ,
                        title: Text('Edit'),
                      )),

                    //delete concept

                      PopupMenuItem(value: 1,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          ref.child(snapshot.child('id').value.toString()).remove();
                        },
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      )),
                    ] ,
                    icon: Icon(Icons.more_vert),
                    ),
                  );
                  }
                  else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())){
                       return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                  }
                  else{
                    return Container(
                      child: Text('No Result found'),
                    );
                  }

                  //search filter ends

                }),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }


//for edit/update

Future <void> showMyDialog(String title, String id ) async{
  editController.text = title;
  return showDialog(context:context ,
  
   builder: ( BuildContext context){
    return AlertDialog(
      title: Text('Update'),
      content: Container(
        child: TextField(
          controller: editController,
          decoration: InputDecoration(
            hintText: 'Edit Here!!'
          ),
          
        ),
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
          ref.child(id).update({
            'title': editController.text.toString()
          }).then((value){
            Utils().toastMessage('Post Updated');
          }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });
        }, child: Text('Update'),),

        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('Cancel'),)
      ],
    );
  });
}

//editing completed

}

//by using stream builder 
          // Expanded(
          //     child: StreamBuilder(
          //           stream: ref.onValue,
          //           builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //         if (!snapshot.hasData) {
          //           return CircularProgressIndicator();
          //         }           
          //           else {
          //           Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //           List<dynamic> list = [];
          //           list.clear();
          //           list = map.values.toList();
          //                 return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(list[index]['Description']),
          //               subtitle: Text(list[index]['id']),
          //               // title: Text("Hello"),

          //             );
          //           });
          //     }     
          //   },
          // )
          // ),