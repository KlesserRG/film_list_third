import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/frontend/mobile/add_and_edit_page/add_and_edit_page.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page.dart';
import 'package:film_list_third/frontend/mobile/settings_page/settings_page.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';            
              
@AutoRouterConfig()      
class AppRouter extends _$AppRouter {      
    
  @override      
  List<AutoRoute> get routes => [      
    AutoRoute(page: MainRoute.page, path: '/'),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: AddAndEditRoute.page),
   ];    
 } 