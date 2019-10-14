// Niels Elgaard Larsen 2019, GPL

using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;

var numStrokes= -1;
var startTime = -1;
var lastTime = -1;

class ButtonstrokeView extends WatchUi.View {
  var strokeText;
  var numStrokesText;
    function initialize() {
      View.initialize();
    }

    function onLayout(dc) {
      setLayout(Rez.Layouts.MainLayout(dc));
      strokeText = findDrawableById("stroke");
      numStrokesText = findDrawableById("numStrokes");
    }
    function onShow() {
    }

    function onUpdate(dc) {
      if (numStrokes>2 && lastTime > startTime) {
        var strokes=60000.0*numStrokes/(lastTime-startTime);
        strokeText.setText(strokes.format("%.1f"));
      }  else {
        strokeText.setText("");
      }
      if (numStrokes<=0) {
        numStrokesText.setText("start");
      } else {
        numStrokesText.setText(numStrokes.format("%d"));
      }
      View.onUpdate(dc);
    }

    function onHide() {
    }
}

class ButtonstrokeDelegate extends WatchUi.BehaviorDelegate {
  var strokes = null;
  var strokeStart=null;
  function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
    }

  function onTap(evt) {
    tick();
    return true;
  }

  function onKey(evt) {
    var key = evt.getKey();
    if (WatchUi.KEY_START == key || WatchUi.KEY_ENTER == key) {
      tick();
      return true;
    }
    return false;
  }

  function tick() {
    var tNow=System.getTimer();
    if (numStrokes<0) {
      numStrokes=0;
      startTime=tNow;
      lastTime=tNow;
    } else {
      if ((tNow-lastTime)>5000) {
        numStrokes=0;
        startTime=tNow;
        lastTime=tNow;
      } else {
        numStrokes++;
        lastTime=tNow;
      }
    }
    WatchUi.requestUpdate();
    return true;
  }
}
