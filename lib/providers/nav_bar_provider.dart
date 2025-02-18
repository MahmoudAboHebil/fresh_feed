import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/navbar_item.dart';

final navBarProvider = StateProvider<NavbarItem>((ref) => NavbarItem.Home);
