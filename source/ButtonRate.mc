using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;
(:glance)
class ButtonRate extends Application.AppBase {
  function initialize() {
    AppBase.initialize();
  }
  public function getInitialView() as Array<Views or InputDelegates>? {
    return [ new ButtonRootView(), new ButtonRootDelegate()];
  }
   public function getGlanceView() {
     return [ new ButtonRateGlance()];
   }
}
