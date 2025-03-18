
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Views/Pages/Widgets/home_build_animated_client_cards.dart';
import '../Views/Pages/Widgets/homebuild_row_action_buttons.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../helper/constans.dart';
import '../models/customer.dart';
import 'custom_title_in_home_page.dart';

class Homebuildmaincontent extends StatelessWidget {
   const Homebuildmaincontent({super.key, required this.customers});

    final List<Customer> customers;
    
  @override
  Widget build(BuildContext context) {
     double averageProgress = customers.isEmpty 
    ? 0.0 
    : customers.where((c) => c.electronicMeterHasBeenRead).length/ customers.length;
   
     
    return RefreshIndicator(
      onRefresh: ()
      async{
        
       
        BlocProvider.of<HomeCubit>(context).getDataAndCheckPermission();

      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Homebuildrowactionbuttons(),
             const SizedBox(height: 20),
              // شريط التقدم الذي يعبر عن معدل التقدم
              LinearProgressIndicator(
                value: averageProgress,
                backgroundColor: kColorFoured,
                valueColor :const  AlwaysStoppedAnimation<Color>(kColorPrimer),
                minHeight: 8,
              ),
             const  SizedBox(height: 20),
           const   Customtitleinhomepage(title: ' لم يتم التحصيل '),
             const  SizedBox(height: 20),
               Homebuildanimatedclientcards(customers: customers, ),
              
            ],
          ),
        ),
      ),
    );
  }
}