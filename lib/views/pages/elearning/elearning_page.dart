import 'package:flutter/material.dart';
import 'package:myplanet/controllers/elearnings/elearning_course_controller.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';

class ElearningPage extends StatefulWidget {
  const ElearningPage({super.key});

  @override
  State<ElearningPage> createState() => _ElearningPageState();
}

class _ElearningPageState extends State<ElearningPage> {
  Future<ElearningCourse>? _userCoursesFuture;

  @override
  void initState() {
    super.initState();

    _userCoursesFuture = ElearningCourseController.fetchUserCourses();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: const PageAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, 
            children: [
              const PageAppBar(),
    
              FutureBuilder(
                future: _userCoursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Error: Data Load Failed',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    if (snapshot.data != null) {
                      var elearningCourses = snapshot.data!;  
                      elearningCourses.data!.sort((course1, course2) => (course2.elearningCourseId ?? 0).compareTo(course1.elearningCourseId ?? 0));
    
                      return SizedBox(
                        height: 0.72 * MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: (elearningCourses.data!.length / 2).ceil(),
                            itemBuilder: (context, index) {
                              final course1 = elearningCourses.data![index * 2];
                              final course2 = (index * 2 + 1 < elearningCourses.data!.length) ? elearningCourses.data![index * 2 + 1] : null;
                    
                              return SizedBox(
                                height: 240,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CardVerticalWidget(
                                        thumbnail: course1.thumbnail,
                                        title: course1.judul,
                                        subTitle: '${(course1.totalLesson ?? 0) + (course1.totalTest ?? 0)} lessons • ',
                                        subTitle2: course1.createdBy,
                                        rating: course1.averageRating,
                                        ratingCount: course1.responseCount,
                                      ),
                                    ),
                                    if (course2 != null)
                                      const SizedBox(width: 8),
                                    if (course2 != null)
                                      Expanded(
                                        child: CardVerticalWidget(
                                          thumbnail: course2.thumbnail,
                                          title: course2.judul,
                                          subTitle: '${(course2.totalLesson ?? 0) + (course2.totalTest ?? 0)} lessons • ',
                                          subTitle2: course2.createdBy,
                                          rating: course2.averageRating,
                                          ratingCount: course2.responseCount,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Text('No data available.');
                    }
                  }
                },
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}