import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Center(
          child: Text(
            _payload.toString().split('|')[0],
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                'Hello,Ahmed',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w900,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'You Have New Reminder ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode ? Colors.grey[300] : darkGreyClr,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: primaryClr,
              ),
              child: SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.text_format,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                   Text(
                     _payload.toString().split('|')[0],
                     style:
                   const  TextStyle(color: Colors.white,
                     fontSize: 20,),
                   ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.description,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _payload.toString().split('|')[1],
                      style:
                      const  TextStyle(color: Colors.white,
                        fontSize: 20,),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.access_time_sharp,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _payload.toString().split('|')[2],
                      style:
                      const  TextStyle(color: Colors.white,
                        fontSize: 20,),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
