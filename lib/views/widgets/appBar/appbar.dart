import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:searchfield/searchfield.dart';

// ignore: must_be_immutable
class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  PageAppBar({Key? key, required this.type, this.title}) : super(key: key);

  final String type;
  final String? title;

  dynamic data;

  @override
  Size get preferredSize => const Size.fromHeight(105); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    data = GlobalVariable.elearningSearchData ?? [];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/appBarBackground.png'), // Replace this with the path to your background image
          fit: BoxFit.cover, // Adjust the image fit to cover the entire container
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(58), // Radius to make the corners round
        ),
      ),
      child: AppBar(
        title: SizedBox(
          height: preferredSize.height, // Set the height of the SizedBox to the preferredSize height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              type == 'search'
                  ? SearchBar(data: data)
                  : Title(
                      title: title ?? "",
                    ),
            ],
          ),
        ),
        toolbarHeight: preferredSize.height, // Set the toolbar height to the preferredSize height
        elevation: 0, // Remove shadow from the AppBar
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: whiteColor, fontFamily: 'Poppins', fontSize: 16, fontWeight: bold),
    );
  }
}

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({super.key, this.data});

  List<dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 330,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: SearchField(
          hint: "Cari E-learning",
          searchInputDecoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: primaryColor, width: 2), borderRadius: BorderRadius.circular(100)),
            hintStyle: const TextStyle(
              fontSize: 13,
              color: secondaryColor,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: secondaryColor,
            ),
          ),
          itemHeight: 50,
          maxSuggestionsInViewPort: 6,
          suggestionsDecoration: SuggestionDecoration(padding: const EdgeInsets.all(4), borderRadius: const BorderRadius.all(Radius.circular(10))),
          onSuggestionTap: (value) {
            ElearningCoursePageController elearningCoursePageController = Get.find();
            elearningCoursePageController.setElearningCourseId(value.item.toString());

            Get.toNamed(RouteName.elearningCoursePage);
          },
          suggestions: data!
              .map((e) => SearchFieldListItem(e.judul,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      e.judul,
                      style: blackTextStyle.copyWith(fontSize: 13, fontWeight: medium),
                    ),
                  ),
                  item: e.elearningCourseId))
              .toList(),
        ),
      ),
    );
  }
}
