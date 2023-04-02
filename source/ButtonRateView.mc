// Niels Elgaard Larsen 2023, GPL
import Toybox.Lang;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Graphics;

(:glance)
class ButtonRateGlance extends WatchUi.GlanceView {
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

public class BRCtl {
  public var numStrokes= -1;
  public var startTime = -1;
  public var lastTime = -1;

  public function tick() {
    //System.println("Tick: ns="+ $.numStrokes+ " t1="+$.startTime+" t2="+$.lastTime);
    var tNow=System.getTimer();
    if (numStrokes<0) {
      numStrokes=0;
      startTime=tNow;
      lastTime=tNow;
    } else {
      if ((tNow-lastTime)>60000) {
        numStrokes=0;
        startTime=tNow;
        lastTime=tNow;
      } else {
        numStrokes++;
        lastTime=tNow;
      }
    }
  }
  public function restart() as Void {
    numStrokes= -1;
    startTime = -1;
    lastTime = -1;
  }
}

class ButtonRootView extends WatchUi.View {
  function initialize() {
    View.initialize();
  }

  function  onUpdate(dc)  {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    dc.clear();
    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
    dc.drawText(dc.getWidth()/2,dc.getHeight()/2, Graphics.FONT_LARGE, "button rate", Graphics.TEXT_JUSTIFY_CENTER);
  }


  function  onLayout(dc as Graphics.Dc) as Void {
    var ctl = new BRCtl();
    WatchUi.pushView(new ButtonRateView(ctl), new ButtonRateDelegate(ctl), WatchUi.SLIDE_IMMEDIATE);
  }
}

class ButtonRateView extends WatchUi.View {
  private var ctl as BRCtl;
  function initialize(mctl as BRCtl) {
    View.initialize();
    ctl=mctl;
  }
  public function onShow() {
    ctl.restart();
  }

  public function onStart() as Void {
    ctl.restart();
  }
  public function onHide() as Void {
    ctl.restart();
  }

  public function onUpdate(dc) as Void {
      var numTxt;
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
      dc.clear();
      dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
      // System.println( "UPD: "+dc.getWidth()+","+dc.getHeight());

      if (ctl.numStrokes>2 && ctl.lastTime > ctl.startTime) {
        var strokes=60000.0 * ctl.numStrokes/(ctl.lastTime-ctl.startTime);
        dc.drawText(dc.getWidth()/2,dc.getHeight() *.4, Graphics.FONT_NUMBER_THAI_HOT, strokes.format("%.1f"), Graphics.TEXT_JUSTIFY_CENTER);
      }
      if (ctl.numStrokes<0) {
        numTxt="start\nbutton rate";
      } else if (ctl.numStrokes==0) {
        numTxt="started";
      } else {
        numTxt="#"+ctl.numStrokes.format("%d");
      }
      dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
      dc.drawText(dc.getWidth()/2,dc.getHeight() *.2, Graphics.FONT_LARGE, numTxt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      //View.onUpdate(dc);
    }
}


class ButtonRootDelegate extends WatchUi.BehaviorDelegate {
  public function initialize() {
    BehaviorDelegate.initialize();
  }
  public function onSelect() as Boolean {
    var ctl = new BRCtl();
    WatchUi.pushView(new ButtonRateView(ctl), new ButtonRateDelegate(ctl), WatchUi.SLIDE_IMMEDIATE);
    return true;
  }
}

  class ButtonRateDelegate extends WatchUi.BehaviorDelegate {
  var ctl as BRCtl;
  public function initialize(mctl) {
    ctl=mctl;
    BehaviorDelegate.initialize();
  }

  public function onTap(evt) as Boolean {
    ctl.tick();
    return true;
  }
  public function onHold(evt) as Boolean {
    ctl.restart();
    WatchUi.requestUpdate();
    return true;
  }
  public function onBack() as Boolean {
    if (ctl.numStrokes>0) {
      ctl.restart();
      WatchUi.requestUpdate();
      return true;
    }
    return false;
  }
  public function onSelect() as Boolean {
    ctl.tick();
    WatchUi.requestUpdate();
    return true;
  }
}
