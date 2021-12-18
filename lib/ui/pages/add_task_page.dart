import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _slectedDate =DateTime.now();
  String _startTime = DateFormat('hh:mm:a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm:a')
      .format(DateTime.now().add(const Duration(minutes: 15))).toString();
  int _slectedRemind =5;
  List<int> remindList=[5,10,15,20];
  String _slectedRepeat ='None';
  List<String> repeatList=['None' , 'Daily' , 'Weekly' ,'Monthly' ];
    int _slectedColor =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(

              children: [
                Text('Add Task' , style:HaedingStyle),
                 InputField(
                  title: 'title',
                  hint: 'Enter Your Task Title',
                  controller: _titleController,
                ),
                const SizedBox(height: 10,),
                InputField(
                  title: 'Note',
                  hint: 'enter some Note',
                  controller: _noteController,
                ),
                const SizedBox(height: 10,),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_slectedDate),
                 widget: IconButton(onPressed: ()=>_getDateFromUser(),
                 icon: const Icon(Icons.calendar_today_outlined ,
                 color: Colors.grey,
                 )),
                ),
                Row(
                  children: [
                    Expanded(child:
                    InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(onPressed: ()=>_getTimeFromUser(isStartTime: true),
                          icon: const Icon(Icons.access_time_rounded ,
                            color: Colors.grey,
                          )),
                    ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(child:
                    InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(onPressed: ()=>_getTimeFromUser(isStartTime: false),
                          icon: const Icon(Icons.access_time_rounded ,
                            color: Colors.grey,
                          )),
                    ),
                    ),
                  ],
                  
                ),
                const SizedBox(height: 10,),
                InputField(
                  title: 'Remind',
                  hint: '$_slectedRemind minutes early',
                  widget:
                  Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: remindList.map<DropdownMenuItem<String>>(
                              (int value) => DropdownMenuItem(
                          value: value.toString(),
                          child: Text(' $value',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          ),),).toList(),

                        icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,),
                        elevation: 4,
                        underline: Container(height: 0,),
                        style: SubTitleStyle,
                        onChanged: (String? newValue){
                          setState(() {
                            _slectedRemind =int.parse(newValue!);
                          });
                        } ,
                      ),
                      const SizedBox(width: 6.0,),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                InputField(
                  title: 'Repeat',
                  hint: '$_slectedRepeat',
                  widget:
                  Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList.map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                            value: value,
                            child: Text( value,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),),).toList(),

                        icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.grey,),
                        elevation: 4,
                        underline: Container(height: 0,),
                        style: SubTitleStyle,
                        onChanged: (String? newValue){
                          setState(() {
                            _slectedRepeat =newValue!;
                          });
                        } ,
                      ),
                      const SizedBox(width: 6.0,)
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     _colorPalette(),

                     MyButton(lable: "Crate Task",
                         onTap: (){
                           _validateDate();
                         },),
                   ],

                 ),

              ],

            ),

        ),
      ),
    );
  }

  AppBar _appBar() {
     return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_sharp, size: 24 ,
          color: primaryClr,),
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
       actions: const [
         CircleAvatar(
           backgroundImage : AssetImage('images/person.jpeg'),

         ),
         SizedBox(width: 20,)
       ],


    );
  }

_validateDate(){
   if( _titleController.text.isNotEmpty &&_noteController.text.isNotEmpty )
     {
       _addTasksToDb();
       Get.back();
     } else if( _titleController.text.isEmpty ||_noteController.text.isEmpty ){
     Get.snackbar(
       'required', 
       'All fields are required !!',
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Get.isDarkMode ? Colors.grey[900]:Colors.white70,
       colorText: pinkClr,
       icon: const Icon(Icons.warning_amber_rounded ,color: pinkClr,),
     );

   }else {
     print('########## WARING ##################');
   }

}
  _addTasksToDb()async{
int value =await _taskController.addTask (
       task : Task(
        title: _titleController.text,
         note: _noteController.text,
         isCompleted: 0,
         date: DateFormat.yMd().format(_slectedDate),
         startTime: _startTime,
         endTime: _endTime,
         color: _slectedColor,
         remind: _slectedRemind,
         repeat: _slectedRepeat,
      ),
);
print('$value');

  }

  Column _colorPalette() {
    return Column(
                     children: [
                       Text('Colores', style: TitleStyle,),
                     const SizedBox(height: 8.0,),
                       Wrap(
                         children:
                         List.generate(3,
                               (index) =>
                                   GestureDetector(
                                   onTap: (){
                                     setState(() {
                                       _slectedColor =index;
                                     });
                                   },
                                   child: Padding(
                                     padding: const EdgeInsets.only(right: 8.0),
                                     child: CircleAvatar(
                                       child: _slectedColor==index?
                                       Icon(Icons.done,
                                       size: 16,
                                       color: Colors.white,):null,
                                       backgroundColor: index==0?
                                       primaryClr :
                                           index==1?
                                               pinkClr :
                                                   orangeClr,
                                       radius: 15,

                                     ),
                                   ),
                                 ),
                         )
                       ),

                     ],
                   );
  }

  _getDateFromUser()async{
  DateTime? _pickedDate = await showDatePicker(context: context,
        initialDate: _slectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030),

    );
  if(_pickedDate!= null)setState(() =>_slectedDate = _pickedDate);
  else print('something is wrong');

  }

  _getTimeFromUser({required bool isStartTime}) async{
    TimeOfDay? _pickedTime = await showTimePicker(context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),

);
  String _formtingTime =_pickedTime!.format(context) ;
    if(isStartTime)
      setState(() =>_startTime = _formtingTime);
    else if(!isStartTime)
      setState(() =>_endTime = _formtingTime);


else print('time selector canceld');


  }

}



