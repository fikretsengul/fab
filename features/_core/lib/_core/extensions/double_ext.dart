import 'package:flutter/material.dart';

extension PaddingsDoubleExt on double {
  EdgeInsets only({
    bool l = false,
    bool r = false,
    bool t = false,
    bool b = false,
  }) =>
      EdgeInsets.fromLTRB(
        l ? this : 0,
        t ? this : 0,
        r ? this : 0,
        b ? this : 0,
      );
  EdgeInsets get left => EdgeInsets.only(left: this);
  EdgeInsets get right => EdgeInsets.only(right: this);
  EdgeInsets get top => EdgeInsets.only(top: this);
  EdgeInsets get bottom => EdgeInsets.only(bottom: this);
  EdgeInsets get all => EdgeInsets.all(this);
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: this);
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: this);
}

/* extension RadiusesDoubleExt on double {
  BorderRadius only({
    bool tl = false,
    bool tr = false,
    bool bl = false,
    bool br = false,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(tl ? this : 0),
        topRight: Radius.circular(tr ? this : 0),
        bottomLeft: Radius.circular(bl ? this : 0),
        bottomRight: Radius.circular(br ? this : 0),
      );
  BorderRadius get topLeft => BorderRadius.only(topLeft: Radius.circular(this));
  BorderRadius get topRight => BorderRadius.only(topRight: Radius.circular(this));
  BorderRadius get bottomLeft => BorderRadius.only(bottomLeft: Radius.circular(this));
  BorderRadius get bottomRight => BorderRadius.only(bottomRight: Radius.circular(this));
  BorderRadius get horizontal => BorderRadius.horizontal(left: Radius.circular(this), right: Radius.circular(this));
  BorderRadius get vertical => BorderRadius.vertical(top: Radius.circular(this), bottom: Radius.circular(this));
  BorderRadius get circularBorder => BorderRadius.all(Radius.circular(this));
  Radius get circularRadius => Radius.circular(this);
} */
