// Niels Elgaard Larsen 2023, GPL
import Toybox.Lang;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

(:glance)
class ButtonstrokeGlance extends WatchUi.GlanceView {
  function initialize() {
    GlanceView.initialize();
  }
  public function onUpdate(dc) as Void {
    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED);
    dc.clear();
    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
    dc.drawText(dc.getWidth()/2,dc.getHeight() *.5, Graphics.FONT_SMALL, "button\nrate", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
  }
}


class ButtonstrokeApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }
    function getInitialView() {
        return [ new ButtonstrokeView(), new ButtonstrokeDelegate() ];
    }
   public function getGlanceView() {
     return [ new ButtonstrokeGlance()];
   }
}
