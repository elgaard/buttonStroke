using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class ButtonstrokeApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        if(getProperty("color") == null) {
            setProperty("color", Graphics.COLOR_RED);
        }
    }

    function onStop(state) {
    }

    function getInitialView() {
        return [ new ButtonstrokeView(), new ButtonstrokeDelegate() ];
    }
}
