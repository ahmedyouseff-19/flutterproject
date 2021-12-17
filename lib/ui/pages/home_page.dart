import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../theme.dart';
import 'add_task_page.dart';
import 'notification_screen.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
          },
          icon: Icon(
            Get.isDarkMode ?
            Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),

          ),
          SizedBox(width: 20,)
        ],


      ),
      body:
      Column(
        children: [
          _addTaskBar(),
          _addDataBar(),
          const SizedBox(height: 6,),
          _showTasks(),
        ],


      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),
                style: SubHaedingStyle,),
              Text('Today', style: HaedingStyle,),
            ],
          ),
          MyButton(lable: '+ Add Task',
            onTap: () async {
              await Get.to(const AddTaskPage());
              _taskController.getTasks();
            },
          )
        ],
      ),
    );
  }

  _addDataBar() {
    return Container(
      margin: const EdgeInsets.only(top:6,left: 20),
      child:
      DatePicker(

        DateTime.now(),
        width: 70,
          height: 100,
        initialSelectedDate: _selectedDate,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle:  GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,),



        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color:  Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,),



        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color:  Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,),



        ),
        onDateChange: (nweDate){
          _selectedDate=nweDate;

        },
      ),

    );
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ?Axis.horizontal
            :Axis.vertical,
        itemBuilder:( BuildContext contex, int index)
      {
       var task = _taskController.tsaklist[index];



        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 1400),
          child: SlideAnimation(
            horizontalOffset: 300,
              child: FadeInAnimation(
                
              child: GestureDetector(
                  onTap: ()=> showBottomSheet(context, task),

              child: TaskTile(task: task),

              ),
          ),
            ),
        );
        },
        itemCount: _taskController.tsaklist.length,
      ),
    );

    /*return Expanded(
      child: GestureDetector(
        onTap: (){
          showBottomSheet(context,
              Task(

                title:"Title1",
                note:"note is empty",
                isCompleted:0,
                startTime:"20:30",
                endTime:"2:40",
                color:1,


              ),

          );
        },
        child: TaskTile(
            task: Task(

          title:"Title1",
          note:"note is empty",
          isCompleted:0,
          startTime:"20:30",
          endTime:"2:40",
          color:1,


        )),
      ),
      /*  child:Obx(
            (){

              if(_taskController.tsaklist.isEmpty){

                return _noTaskMsg();

              }
              else{
               return Container(height: 0,);

              }
            }

        ),*/



    );*/

  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
              ?Axis.horizontal
              : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(height: 6,)
                :const SizedBox(height: 300,),
                SvgPicture.asset('images/task.svg',
                height: 90,
                  semanticsLabel: 'Task',
                  color: primaryClr.withOpacity(0.5),
                  
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 10),
                  child: Text('You do not have any tasks yet ',
                  style: SubTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(height: 120,)
                    :const SizedBox(height: 180,),

              ],
            ),
          ),
        ),
      ],

    );


  }

showBottomSheet(BuildContext context , Task task){

    Get.bottomSheet(
      SingleChildScrollView(
        child:
        Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
            ?(task.isCompleted==1
          ?SizeConfig.screenHeight*0.6
              :SizeConfig.screenHeight*0.8)
          :(task.isCompleted==1
              ?SizeConfig.screenHeight*0.30
              :SizeConfig.screenHeight*0.39),
          color: Get.isDarkMode?darkHeaderClr : Colors.white ,

          child: Column(
                children: [
                  Flexible(child: Container(
                    height: 6,
                      width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode? Colors.grey[600]
                          :Colors.grey[300],
                    ),
                  ),
                  ),
                  SizedBox(height: 20,),
                  task.isCompleted==1?
                      Container()
                      :
                  _buildBottomSheet(
                    label: 'Task Completed',
                    onTap: (){
                      Get.back();

                    },
                    clr: primaryClr,

                  ),


                  _buildBottomSheet(
                    label: 'Delete Task',
                    onTap: (){
                      Get.back();

                    },
                    clr: primaryClr,

                  ),

                  Divider (color: Get.isDarkMode? Colors.grey:darkGreyClr),


                  _buildBottomSheet(
                    label: 'Cansel',
                    onTap: (){
                      Get.back();

                    },
                    clr: primaryClr,

                  ),
                  SizedBox(height: 20,),



                ],
          ),
        ),
      ),
    );

}

  _buildBottomSheet(
      { required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false })
  {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 4) ,
        height: 65,
        width: SizeConfig.screenWidth*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
              ? Get.isDarkMode
                ?Colors.grey[600]!
            : Colors.grey[300]!
                :clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ?Colors.transparent : clr,
        ),
        child: Center(
          child: Text(label, style:isClose? TitleStyle
              :TitleStyle.copyWith(color:Colors.white ),),
        ),


      ),
    );
  }



}