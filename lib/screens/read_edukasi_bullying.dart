import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spanticom/screens/view_zoom_image.dart';
import 'package:spanticom/theme/colors/light_colors.dart';

class read_edukasi_bullying extends StatelessWidget {
  const read_edukasi_bullying({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final List<String> galleryItems = List.generate(
        12, (index) => "assets/images/edukasiBullying/${(index + 1)}.jpg");
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: galleryItems
                .map((item) => Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Get.to(view_zoom_image(item)),
                          child: Image.asset(
                            item,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// PhotoView(
//                       maxScale: 0.9,
//                       // minScale: 0.5,
//                       minScale: PhotoViewComputedScale.contained * 0.8,
//                       imageProvider: AssetImage(item),
//                     ),
 