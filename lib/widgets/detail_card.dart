import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/todo_models.dart';
import '../style.dart';
import 'animated_percent.dart';

class HeroProgress extends StatelessWidget {
  const HeroProgress({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'progress_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${category.totalItems} задач',
            style: Style.mainTasksTextStyle,
          ),
          SizedBox(
            height: Style.halfPadding,
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: NeumorphicProgress(
                    percent: category.percent,
                    height: 8,
                    duration: Duration(milliseconds: 300),
                    style: ProgressStyle(
                        depth: NeumorphicTheme.depth(
                            context) // TODO: fix depth and others
                        )),
              ),
              SizedBox(
                width: Style.mainPadding,
              ),
              Container(
                width: 40,
                alignment: Alignment.centerRight,
                child: AnimatedPercent(
                  category.percent,
                  style: Style.mainTasksTextStyle,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Text(
        category.title,
        style: Style.cardTitleTextStyle,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HeroIcon extends StatelessWidget {
  const HeroIcon({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'icon_${category.id}',
      child: Neumorphic(
        padding: EdgeInsets.all(16),
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle()
        ),
        child: FaIcon(
          category.icon,
          color: Style.primaryColor,
          size: 32,
        ),
      ),
    );
  }
}

Widget flightShuttleBuilderFix(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  ///fix overflow flex
  return SingleChildScrollView(
    //fix missed style
    child: DefaultTextStyle(
        style: DefaultTextStyle.of(fromHeroContext).style,
        child: fromHeroContext.widget),
  );
}
