import 'package:firerest/home-layout/home-cubit.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/styles/app-colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBottomSheet extends StatelessWidget {

  final TextEditingController categoryController;
  const BuildBottomSheet({Key? key, required this.categoryController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =HomeCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)/3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: cubit.categoryImg == null
                                  ? Image.asset(
                                  "assets/logo part 1.png",
                                  fit: BoxFit.cover)
                                  : Image(image: FileImage(
                                cubit.categoryImg!,),fit: BoxFit.cover,),
                            )
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: IconButton(
                                  onPressed: () {
                                    cubit.pickCategoryImg();
                                    print("object");
                                  },
                                  icon: const Icon (
                                    Icons.camera_alt, size: 15,))),
                        ),

                      ],
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(15)
                          ),
                          child: TextFormField(
                            controller: categoryController,
                            decoration: const InputDecoration(
                                hintText: "Category Name"
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  color: AppColor.mainColor,
                  onPressed: (){
                    cubit.uploadCategoryImg(
                        categoryName:categoryController.text
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"),)
              ],
            ),
          ),
        );
      }
    );
  }
}
