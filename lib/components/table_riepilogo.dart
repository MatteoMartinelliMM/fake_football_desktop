import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';

class TableRipeilogo extends StatefulWidget {
  final Player p;
  late final String title;
  final Map<EventType, List<int>> staticsByType;
  late final bool isSeason;

  TableRipeilogo.partita(this.p, this.staticsByType, {Key? key}) : super(key: key) {
    title = RIEPILOGO_PARTITA;
    isSeason = false;
  }

  TableRipeilogo.stagione(this.p, this.staticsByType, {Key? key}) : super(key: key) {
    title = RIEPILOGO_STAGIONE;
    isSeason = true;
  }

  @override
  State<TableRipeilogo> createState() => _TableRipeilogoState();
}

class _TableRipeilogoState extends State<TableRipeilogo> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: widget.p.isYellow ? Colors.black : Colors.white,
            child: Center(
              child: Text(widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: widget.p.isYellow ? Colors.white : Colors.black)),
            ),
          ),
          Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: _buildStaticsRow(context, widget.p),
          ),
        ],
      );

  List<TableRow> _buildStaticsRow(BuildContext context, Player p) {
    List<TableRow> rows = [];
    widget.staticsByType.keys.toList().forEach((k) => rows.add(TableRow(
        children: buildTableCell(context, widget.staticsByType[k]!, k, p),
        decoration: BoxDecoration(color: p.isYellow ? Colors.black : Colors.white))));
    return rows;
  }

  List<TableCell> buildTableCell(
      BuildContext context, List<int> statics, EventType type, Player p) {
    List<TableCell> cells = [];
    cells.add(TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: type.icon(),
        )));
    cells.add(TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Text(type.getLabel(),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: p.isYellow ? Colors.white : Colors.black)),
      ),
    ));
    if (statics.length != 1) {
      statics.forEachIndexed(
        (v, i) => cells.add(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              color: p.isYellow ? Colors.yellow : Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('${statics[i]}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: p.isYellow ? Colors.black : Colors.white)),
                    Text(
                        widget.isSeason
                            ? type.getResumeLabelSeason(i)
                            : type.getResumeLabelMatch(i),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: p.isYellow ? Colors.black : Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      cells.add(TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          color: p.isYellow ? Colors.yellow : Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${statics.first}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: p.isYellow ? Colors.black : Colors.white),
            ),
          ),
        ),
      ));
      cells.add((TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            color: p.isYellow ? Colors.yellow : Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: p.isYellow ? Colors.black : Colors.white)),
            ),
          ))));
    }
    return cells;
  }

  @override
  void initState() {
    super.initState();
  }
}
