import 'package:flutter/material.dart';

// Custom class storing data related to items in the WidgetTabBar.
class WidgetTabBarItem {
  final String text;
  final IconData iconData;
  final Widget child;

  WidgetTabBarItem(this.text, this.iconData, this.child);

  Widget getTab(bool isSelected) => Container(
        alignment: Alignment.topCenter,
        height: 65,
        child: Tab(
          iconMargin: const EdgeInsets.only(bottom: 7),
          text: text,
          icon: Icon(iconData, color: isSelected ? Colors.blue : Colors.grey),
        ),
      );
}

class WidgetTabBar extends StatefulWidget {
  const WidgetTabBar(this.tabs, {Key? key}) : super(key: key);

  final List<WidgetTabBarItem> tabs;

  @override
  _WidgetTabBarState createState() => _WidgetTabBarState();
}

class _WidgetTabBarState extends State<WidgetTabBar> with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this);
    _controller!.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 1.0,
            controller: _controller,
            // Converting to map allows controller to use its index (key)
            tabs: widget.tabs
                .asMap()
                .entries
                .map<Widget>((entry) => entry.value.getTab(_controller!.index == entry.key))
                .toList(),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          // TabBarView displays the widgets generated in the WidgetTabBarItem associated with the current selection
          child: TabBarView(
            controller: _controller,
            children: widget.tabs.map<Widget>((e) => e.child).toList(),
          ),
        )
      ],
    );
  }
}
