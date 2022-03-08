using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;
(:glance)
class ButtonRate extends Application.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  function onStart(state) {
  }
  
  function onStop(state) {
  }

  public function getInitialView() as Array<Views or InputDelegates>? {
    //    return [ new ButtonRateView(ctl), new ButtonRateDelegate(ctl) ];
    return [ new ButtonRootView()];
    //return [ new ButtonRateView(ctl), new RateMenu2Delegate(ctl) ] as Array<Views or InputDelegates>;
    //return [ new ButtonRateView(ctl)] as Array<Views or InputDelegates>;
  }
   public function getGlanceView() {
     return [ new ButtonRateGlance()];
   }
}
