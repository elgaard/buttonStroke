// Niels Elgaard Larsen 2022, GPL

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

 class RateMenu2Delegate extends WatchUi.Menu2InputDelegate {
     public function initialize(ctl as BRCtl) {
         Menu2InputDelegate.initialize();
     }
     // public function onSelect(item as MenuItem) as Void {
     //   System.println( "SELECT2: ");
     //   ctl.tick();
     //   WatchUi.requestUpdate();
     // }
     // public function onBack() as Void {
     //   System.println("onBack Menu2Del");
     //   if (ctl.numStrokes>0) {
     // 	 ctl.restart();
     // 	 //WatchUi.requestUpdate();
     //   }
     //}
 }


class ButtonRateView extends WatchUi.View {
  private var strokeText = null;
  private var numStrokesText as Text?;
  private var ctl as BRCtl;
  function initialize(mctl as BTCtl) {
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
      System.println( "UPD: "+dc.getWidth()+","+dc.getHeight());
	
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


class ButtonRateDelegate extends WatchUi.BehaviorDelegate {
  var ctl as BRCtl;
  public function initialize(mctl) {
    ctl=mctl;
    BehaviorDelegate.initialize();
  }
  public function onMenu() as Boolean {
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
    System.println("onBack BRDel: ");
    if (ctl.numStrokes>0) {
      ctl.restart();
      WatchUi.requestUpdate();
      return true;
    }
    return false;
  }
  public function onSelect() as Boolean {
    System.println( "SELECT: BRdel");
    ctl.tick();
    //System.println("Tick: ns="+ $.numStrokes+ " t1="+$.startTime+" t2="+$.lastTime);
    WatchUi.requestUpdate();
    return true;
  }
}
