import 'package:example/data/showcases/button_showcases.dart';
import 'package:example/data/showcases/card_showcases.dart';
import 'package:example/data/showcases/misc_showcases.dart';
import 'package:example/data/showcases/nav_showcases.dart';
import 'package:example/models/showcase_item.dart';

/// The master list of all showcases, aggregated from specialized files.
/// This is the single source of truth for the ShowcaseScreen.
final List<ShowcaseItem> allShowcases = [
  ...buttonShowcases,
  ...cardShowcases,
  ...navShowcases,
  ...miscShowcases,
];
