import 'package:flutter/material.dart';
class ExpansionPanelItem {
  ExpansionPanelItem({
    required this.headerValue,
    required this.icon,
    required this.expandedValue,
    this.isExpanded = false,
  });

  String headerValue;
  IconData icon;
  String expandedValue;
  bool isExpanded;
}

class ExpansionPanelDemo extends StatefulWidget {
  const ExpansionPanelDemo({super.key});

  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  final List<ExpansionPanelItem> _data = generateItemss(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expansion Panel Demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      elevation: 1,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((ExpansionPanelItem item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Icon(item.icon),
              title: Text(
                item.headerValue,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

List<ExpansionPanelItem> generateItemss(int panelItems) {
  return List<ExpansionPanelItem>.generate(panelItems, (int index) {
    return ExpansionPanelItem(
      headerValue: 'Panel $index',
      icon: Icons.door_sliding_outlined,
      expandedValue: 'This is the expanded content for panel $index.',
    );
  });
}
