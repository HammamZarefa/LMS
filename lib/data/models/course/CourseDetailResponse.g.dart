// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseDetailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailResponse _$CourseDetailResponseFromJson(Map<String, dynamic> json) {
  return CourseDetailResponse(
    id: json['id'] as num,
    title: json['title'] as String,
    images: json['images'] == null
        ? null
        : ImagesBean.fromJson(json['images'] as Map<String, dynamic>),
    categories: (json['categories'] as List)?.map((e) => e as String)?.toList(),
    price: json['price'] == null
        ? null
        : PriceBean.fromJson(json['price'] as Map<String, dynamic>),
    rating: json['rating'] == null
        ? null
        : RatingBean.fromJson(json['rating'] as Map<String, dynamic>),
    featured: json['featured'],
    status: json['status'],
    author: json['author'] == null
        ? null
        : AuthorBean.fromJson(json['author'] as Map<String, dynamic>),
    url: json['url'] as String,
    description: json['description'] as String,
    meta: (json['meta'] as List)
        ?.map((e) =>
            e == null ? null : MetaBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    announcement: json['announcement'] as String,
    purchase_label: json['purchase_label'] as String,
    curriculum: (json['curriculum'] as List)
        ?.map((e) => e == null
            ? null
            : CurriculumBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    faq: (json['faq'] as List)
        ?.map((e) =>
            e == null ? null : FaqBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    is_favorite: json['is_favorite'] as bool,
    trial: json['trial'] as bool,
    first_lesson: json['first_lesson'] as num,
    first_lesson_type: json['first_lesson_type'] as String,
    has_access: json['has_access'] as bool,
    categories_object: (json['categories_object'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CourseDetailResponseToJson(
        CourseDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'images': instance.images,
      'categories': instance.categories,
      'price': instance.price,
      'rating': instance.rating,
      'featured': instance.featured,
      'status': instance.status,
      'author': instance.author,
      'url': instance.url,
      'description': instance.description,
      'meta': instance.meta,
      'announcement': instance.announcement,
      'purchase_label': instance.purchase_label,
      'curriculum': instance.curriculum,
      'faq': instance.faq,
      'is_favorite': instance.is_favorite,
      'trial': instance.trial,
      'first_lesson': instance.first_lesson,
      'first_lesson_type': instance.first_lesson_type,
      'has_access': instance.has_access,
      'categories_object': instance.categories_object,
    };

FaqBean _$FaqBeanFromJson(Map<String, dynamic> json) {
  return FaqBean(
    question: json['question'] as String,
    answer: json['answer'] as String,
  );
}

Map<String, dynamic> _$FaqBeanToJson(FaqBean instance) => <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
    };

CurriculumBean _$CurriculumBeanFromJson(Map<String, dynamic> json) {
  return CurriculumBean(
    type: json['type'] as String,
    view: json['view'] as String,
    label: json['label'] as String,
    meta: json['meta'] as String,
    lesson_id: json['lesson_id'],
    has_preview: json['has_preview'],
  );
}

Map<String, dynamic> _$CurriculumBeanToJson(CurriculumBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'view': instance.view,
      'label': instance.label,
      'meta': instance.meta,
      'lesson_id': instance.lesson_id,
      'has_preview': instance.has_preview,
    };

MetaBean _$MetaBeanFromJson(Map<String, dynamic> json) {
  return MetaBean(
    type: json['type'] as String,
    label: json['label'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$MetaBeanToJson(MetaBean instance) => <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'text': instance.text,
    };

AuthorBean _$AuthorBeanFromJson(Map<String, dynamic> json) {
  return AuthorBean(
    id: json['id'] as num,
    login: json['login'] as String,
    avatar_url: json['avatar_url'] as String,
    url: json['url'] as String,
    meta: json['meta'] == null
        ? null
        : AuthorMetaBean.fromJson(json['meta'] as Map<String, dynamic>),
    rating: json['rating'] == null
        ? null
        : AuthorRatingBean.fromJson(json['rating'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthorBeanToJson(AuthorBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'url': instance.url,
      'meta': instance.meta,
      'rating': instance.rating,
    };

AuthorMetaBean _$AuthorMetaBeanFromJson(Map<String, dynamic> json) {
  return AuthorMetaBean(
    facebook: json['facebook'] as String,
    twitter: json['twitter'] as String,
    instagram: json['instagram'] as String,
    google_plus: json['google-plus'] as String,
    position: json['position'] as String,
    description: json['description'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
  );
}

Map<String, dynamic> _$AuthorMetaBeanToJson(AuthorMetaBean instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'google-plus': instance.google_plus,
      'position': instance.position,
      'description': instance.description,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
    };

AuthorRatingBean _$AuthorRatingBeanFromJson(Map<String, dynamic> json) {
  return AuthorRatingBean(
    total: json['total'] as num,
    average: json['average'] as num,
    marks_num: json['marks_num'] as num,
    total_marks: json['total_marks'] as String,
    percent: json['percent'] as num,
  );
}

Map<String, dynamic> _$AuthorRatingBeanToJson(AuthorRatingBean instance) =>
    <String, dynamic>{
      'total': instance.total,
      'average': instance.average,
      'marks_num': instance.marks_num,
      'total_marks': instance.total_marks,
      'percent': instance.percent,
    };

RatingBean _$RatingBeanFromJson(Map<String, dynamic> json) {
  return RatingBean(
    total: json['total'] as num,
    average: json['average'] as num,
    percent: json['percent'] as num,
    details: json['details'] == null
        ? null
        : DetailsBean.fromJson(json['details'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RatingBeanToJson(RatingBean instance) =>
    <String, dynamic>{
      'total': instance.total,
      'average': instance.average,
      'percent': instance.percent,
      'details': instance.details,
    };

DetailsBean _$DetailsBeanFromJson(Map<String, dynamic> json) {
  return DetailsBean(
    one: json['1'] as num,
    two: json['2'] as num,
    three: json['3'] as num,
    four: json['4'] as num,
    five: json['5'] as num,
  );
}

Map<String, dynamic> _$DetailsBeanToJson(DetailsBean instance) =>
    <String, dynamic>{
      '1': instance.one,
      '2': instance.two,
      '3': instance.three,
      '4': instance.four,
      '5': instance.five,
    };

PriceBean _$PriceBeanFromJson(Map<String, dynamic> json) {
  return PriceBean(
    free: json['free'] as bool,
    price: json['price'] as String,
    old_price: json['old_price'],
  );
}

Map<String, dynamic> _$PriceBeanToJson(PriceBean instance) => <String, dynamic>{
      'free': instance.free,
      'price': instance.price,
      'old_price': instance.old_price,
    };

ImagesBean _$ImagesBeanFromJson(Map<String, dynamic> json) {
  return ImagesBean(
    full: json['full'] as String,
    small: json['small'] as String,
  );
}

Map<String, dynamic> _$ImagesBeanToJson(ImagesBean instance) =>
    <String, dynamic>{
      'full': instance.full,
      'small': instance.small,
    };
