import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Authentication/Screens/Sign-Up/signupfeild.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Screens/Navbar%20Screen/navbar.dart';
import 'package:rentel_round/Services/auth_services.dart';



class EditProfile extends StatefulWidget {

final Auth auth;
  EditProfile({required this.auth,super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

TextEditingController shopnameController = TextEditingController();
TextEditingController shopownernameController = TextEditingController();
TextEditingController shoplocationController = TextEditingController();
TextEditingController shopphonenoController = TextEditingController();
TextEditingController emailController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
String? _image;

class _EditProfileState extends State<EditProfile> {



  SignUpFeilds feilds = SignUpFeilds();
  final ImagePicker _picker = ImagePicker();


  Future<void> pickImage() async{
    final XFile? pickedimg = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedimg!=null){
      setState(() {
        _image = pickedimg.path;
      });

    }
  }
  @override
  void initState() {
   shopnameController = TextEditingController(text: widget.auth.shopname);
   shopownernameController = TextEditingController(text: widget.auth.shopownername);
  shoplocationController = TextEditingController(text: widget.auth.shoplocation);
    shopphonenoController = TextEditingController(text: widget.auth.phonenumer.toString());
     emailController = TextEditingController(text: widget.auth.email);
     _image = widget.auth.image;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle:true,
        title: Text("EDIT YOUR SHOP DETAILS",
          style: TextStyle(
              fontFamily: "fredoka"
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.close)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.purple.shade100,
                        child: _image == null?const Icon(Icons.image):Image(image: FileImage(File(_image!)))

                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      await pickImage();
                    },
                    child: const Text(
                      "UPLOAD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("shop name", "enter your shop name", shopnameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid name';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("shop owner name", "enter your shop owner name", shopownernameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid shop owner name';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),feilds.feild("shop location", "enter your shop location", shoplocationController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a location';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("phone number", "enter your phone number", shopphonenoController,(value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid phone number';
                    }
                    if(value.length!=10){
                      return 'Enter A 10 digit number';
                    }
                    return null;
                  },TextInputType.phone,[FilteringTextInputFormatter.digitsOnly]),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("email", "enter your email", emailController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: ()  {

                      if(_formKey.currentState!.validate()){
                        _showDialogue("Press OK to edit profile", "OK", ()async{
                          Auth auth = Auth(
                            shopname: shopnameController.text,
                            shopownername: shopownernameController.text,
                            shoplocation: shoplocationController.text,
                            phonenumer: int.parse(shopphonenoController.text),
                            email: emailController.text,
                            image: _image!,
                            status: true,
                          );
                          await AuthServices().updateUser(auth);
                          await AuthServices().getUser("USER");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text("User profile edited!")));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBar(auth: auth,)),(route) => false,);
                        }, context);

                        if(_image==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload an image")));
                          return;
                        }

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill the above details!")));
                      }
                    },
                    child: const Text(
                      "EDIT SHOP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showDialogue(String messege,String btnName,VoidCallback btnfn,BuildContext context){
    showDialog(context: context,builder: (context) {
      return AlertDialog(
        title: Text(messege),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("CANCEL")),
          ElevatedButton(onPressed: btnfn, child: Text(btnName))
        ],
      );
    });

  }
}
