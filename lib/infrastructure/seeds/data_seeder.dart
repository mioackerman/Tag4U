import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
import 'package:tag4u/presentation/providers/place_providers.dart';
import 'package:uuid/uuid.dart';

/// Inserts dummy places (with descriptors) if the database is empty.
/// Safe to call on every app launch — exits immediately when data exists.
final dataSeedProvider = FutureProvider<void>((ref) async {
  final places = await ref.read(placesProvider.future);
  if (places.isNotEmpty) return; // already seeded

  const uuid = Uuid();
  final now = DateTime.now();

  // ── helper to build a PlaceNode ──────────────────────────────────────────

  PlaceNode place({
    required String name,
    required PlaceCategory category,
    String? address,
    int? priceLevel,
    double? personalScore,
    String? personalNote,
  }) {
    return PlaceNode(
      id: uuid.v4(),
      name: name,
      category: category,
      address: address,
      priceLevel: priceLevel,
      personalScore: personalScore,
      personalNote: personalNote,
      layer: PlaceLayer.personal,
      createdAt: now,
      updatedAt: now,
    );
  }

  // ── helper to build a SemanticDescriptor ────────────────────────────────

  SemanticDescriptor desc(
    String placeId,
    String text, {
    double weight = 1.0,
    DescriptorSource source = DescriptorSource.userDefined,
  }) {
    return SemanticDescriptor(
      id: uuid.v4(),
      placeNodeId: placeId,
      descriptor: text,
      source: source,
      weight: weight,
      createdAt: now,
    );
  }

  // ── Dummy places ──────────────────────────────────────────────────────────

  final p1 = place(
    name: '老四川火锅',
    category: PlaceCategory.restaurant,
    address: '红星路二段88号',
    priceLevel: 2,
    personalScore: 0.8,
    personalNote: '推荐牛油锅底',
  );
  final p2 = place(
    name: '东京清物料理',
    category: PlaceCategory.restaurant,
    address: '建国路99号',
    priceLevel: 3,
    personalScore: 0.6,
  );
  final p3 = place(
    name: '绿意素食坊',
    category: PlaceCategory.restaurant,
    address: '人民南路18号',
    priceLevel: 2,
    personalScore: 0.5,
  );
  final p4 = place(
    name: '粤味轩',
    category: PlaceCategory.restaurant,
    address: '天府大道100号',
    priceLevel: 3,
    personalScore: 0.7,
  );
  final p5 = place(
    name: '烤肉工厂',
    category: PlaceCategory.restaurant,
    address: '锦江区中纱帽街5号',
    priceLevel: 3,
    personalScore: 0.75,
  );
  final p6 = place(
    name: '西班牙小馆',
    category: PlaceCategory.restaurant,
    address: '玉林东路33号',
    priceLevel: 4,
    personalScore: 0.9,
    personalNote: '周末需提前订位',
  );
  final p7 = place(
    name: '意式比萨坊',
    category: PlaceCategory.restaurant,
    address: '武侯祠大街42号',
    priceLevel: 2,
    personalScore: 0.6,
  );
  final p8 = place(
    name: '本帮老字号',
    category: PlaceCategory.restaurant,
    address: '春熙路广场附近',
    priceLevel: 1,
    personalScore: 0.55,
  );

  final p9 = place(
    name: '晴天咖啡馆',
    category: PlaceCategory.cafe,
    address: '槐树街20号',
    priceLevel: 2,
    personalScore: 0.8,
    personalNote: '靠窗座位非常舒适',
  );
  final p10 = place(
    name: '暗调精品咖啡',
    category: PlaceCategory.cafe,
    address: '宽窄巷子北口',
    priceLevel: 3,
    personalScore: 0.7,
  );
  final p11 = place(
    name: '屋顶露台咖啡',
    category: PlaceCategory.cafe,
    address: '望平坊街区顶楼',
    priceLevel: 3,
    personalScore: 0.85,
  );
  final p12 = place(
    name: '威士忌酒吧',
    category: PlaceCategory.bar,
    address: '滨江路夜市街区',
    priceLevel: 4,
    personalScore: 0.7,
  );

  final p13 = place(
    name: '滨江绿道公园',
    category: PlaceCategory.park,
    address: '锦江河畔',
    personalScore: 0.6,
  );
  final p14 = place(
    name: '当代艺术馆',
    category: PlaceCategory.museum,
    address: '人民公园西侧',
    priceLevel: 1,
    personalScore: 0.65,
  );
  final p15 = place(
    name: '轰趴馆·大空间',
    category: PlaceCategory.hotel,
    address: '二环路内某楼',
    priceLevel: 3,
    personalScore: 0.75,
  );
  final p16 = place(
    name: '室内攀岩馆',
    category: PlaceCategory.outdoorActivity,
    address: '高新区体育中心旁',
    priceLevel: 2,
    personalScore: 0.7,
  );
  final p17 = place(
    name: '剧本杀工作室',
    category: PlaceCategory.other,
    address: '望平坊三楼',
    priceLevel: 2,
    personalScore: 0.8,
  );
  final p18 = place(
    name: '桌游馆',
    category: PlaceCategory.other,
    address: '锦里古街附近',
    priceLevel: 1,
    personalScore: 0.6,
  );
  final p19 = place(
    name: '万达影城',
    category: PlaceCategory.cinema,
    address: '万达广场6楼',
    priceLevel: 2,
    personalScore: 0.55,
  );
  final p20 = place(
    name: '郊外农庄·稻田',
    category: PlaceCategory.outdoorActivity,
    address: '龙泉驿区郊外',
    priceLevel: 2,
    personalScore: 0.65,
  );

  final allPlaces = [
    p1, p2, p3, p4, p5, p6, p7, p8,
    p9, p10, p11, p12,
    p13, p14, p15, p16, p17, p18, p19, p20,
  ];

  for (final p in allPlaces) {
    await ref.read(placesProvider.notifier).upsert(p);
  }

  // ── Descriptors for food places (shown in 菜式/口味) ──────────────────────

  final foodDescs = [
    // 老四川火锅
    desc(p1.id, '火锅'), desc(p1.id, '麻辣'), desc(p1.id, '川菜'),
    desc(p1.id, '热闹'), desc(p1.id, '适合聚餐'),
    // 东京清物料理
    desc(p2.id, '日料'), desc(p2.id, '清淡'), desc(p2.id, '刺身'),
    desc(p2.id, '安静'), desc(p2.id, '适合商务'),
    // 绿意素食坊
    desc(p3.id, '素食'), desc(p3.id, '清淡'), desc(p3.id, '健康'),
    desc(p3.id, '安静'),
    // 粤味轩
    desc(p4.id, '粤菜'), desc(p4.id, '海鲜'), desc(p4.id, '清淡'),
    desc(p4.id, '适合家庭'),
    // 烤肉工厂
    desc(p5.id, '烤肉'), desc(p5.id, '韩料'), desc(p5.id, '热闹'),
    desc(p5.id, '适合朋友聚会'),
    // 西班牙小馆
    desc(p6.id, '西餐'), desc(p6.id, '红酒'), desc(p6.id, '浪漫'),
    desc(p6.id, '适合约会'),
    // 意式比萨坊
    desc(p7.id, '意大利菜'), desc(p7.id, '比萨'), desc(p7.id, '休闲'),
    desc(p7.id, '性价比高'),
    // 本帮老字号
    desc(p8.id, '本帮菜'), desc(p8.id, '家常'), desc(p8.id, '亲民'),
    desc(p8.id, '传统'),
    // 晴天咖啡馆
    desc(p9.id, '咖啡'), desc(p9.id, '下午茶'), desc(p9.id, '有工位'),
    desc(p9.id, '安静'), desc(p9.id, '甜品'),
    // 暗调精品咖啡
    desc(p10.id, '精品咖啡'), desc(p10.id, '暗调'), desc(p10.id, '文艺'),
    desc(p10.id, '安静'),
    // 屋顶露台咖啡
    desc(p11.id, '咖啡'), desc(p11.id, '下午茶'), desc(p11.id, '甜品'),
    // 威士忌酒吧
    desc(p12.id, '威士忌'), desc(p12.id, '鸡尾酒'), desc(p12.id, '夜生活'),
    desc(p12.id, '成人'), desc(p12.id, '热闹'),
  ];

  // ── Descriptors for activity places (shown in 地点特征) ──────────────────

  final activityDescs = [
    // 屋顶露台咖啡 (also has place characteristic)
    desc(p11.id, '露台'), desc(p11.id, '景观好'), desc(p11.id, '户外'),
    // 滨江绿道公园
    desc(p13.id, '户外'), desc(p13.id, '绿化好'), desc(p13.id, '适合散步'),
    desc(p13.id, '亲子友好'), desc(p13.id, '免费'),
    // 当代艺术馆
    desc(p14.id, '文艺'), desc(p14.id, '安静'), desc(p14.id, '室内'),
    desc(p14.id, '适合约会'), desc(p14.id, '有格调'),
    // 轰趴馆
    desc(p15.id, '包场'), desc(p15.id, '热闹'), desc(p15.id, '适合聚会'),
    desc(p15.id, '大空间'), desc(p15.id, '私密'),
    // 室内攀岩
    desc(p16.id, '运动'), desc(p16.id, '刺激'), desc(p16.id, '室内'),
    desc(p16.id, '有挑战性'), desc(p16.id, '团建'),
    // 剧本杀工作室
    desc(p17.id, '剧本杀'), desc(p17.id, '互动'), desc(p17.id, '热闹'),
    desc(p17.id, '室内'), desc(p17.id, '适合朋友聚会'),
    // 桌游馆
    desc(p18.id, '桌游'), desc(p18.id, '休闲'), desc(p18.id, '室内'),
    desc(p18.id, '适合朋友'), desc(p18.id, '性价比高'),
    // 万达影城
    desc(p19.id, '电影'), desc(p19.id, '安静'), desc(p19.id, '室内'),
    desc(p19.id, '适合约会'),
    // 郊外农庄
    desc(p20.id, '户外'), desc(p20.id, '亲子友好'), desc(p20.id, '烧烤'),
    desc(p20.id, '大自然'), desc(p20.id, '远离市区'),
  ];

  final allDescs = [...foodDescs, ...activityDescs];
  for (final d in allDescs) {
    await ref
        .read(placeDescriptorsProvider(d.placeNodeId).notifier)
        .addDescriptor(d);
  }
});
