import 'package:flutter/material.dart';
import 'package:section1/common/const/colors.dart';

class RatingCard extends StatelessWidget {
  // NetworkImage
  // AssetImage
  // CircleAvator
  final ImageProvider avatarImage;

  // 리스트로 위젯 이미지를 보여줄 때
  final List<Image> images;

  // 별점
  final int rating;

  // 이메일
  final String email;

  // 리뷰내용
  final String content;

  const RatingCard(
      {required this.avatarImage,
      required this.images,
      required this.rating,
      required this.email,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        _Body(),
        _Images(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;

  const _Header(
      {required this.avatarImage,
      required this.email,
      required this.rating,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avatarImage,
          radius: 12.0,
        ),
        const SizedBox(width: 8.0,),
        // 나머지 공강 차지
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // 풀어 넣ㅇ르 때는 ... 쓰기
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star: Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _Images extends StatelessWidget {
  const _Images({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
