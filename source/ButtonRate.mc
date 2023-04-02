import Toybox.Lang;
using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;


(:glance)
class ButtonRate extends Application.AppBase {
  function initialize() {
    AppBase.initialize();
  }
  public function getInitialView() as Array<Toybox.WatchUi.Views or Toybox.WatchUi.InputDelegates>? {
    return [ new ButtonRootView(), new ButtonRootDelegate()];
  }
   public function getGlanceView() {
     return [ new ButtonRateGlance()];
   }
}
