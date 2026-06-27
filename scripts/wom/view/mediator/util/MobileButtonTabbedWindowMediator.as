package wom.view.mediator.util
{
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.model.game.UserInfo;
   import wom.view.util.MobileButtonTabbedWindow;
   
   public class MobileButtonTabbedWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var buttonTabbedWindow:MobileButtonTabbedWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileButtonTabbedWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         mapTabButtons();
      }
      
      protected function mapTabButtons() : void
      {
         for each(var _loc1_ in buttonTabbedWindow.tabButtons)
         {
            eventMap.mapStarlingListener(_loc1_,"triggered",onTabButtonClicked,Event);
         }
      }
      
      protected function onTabButtonClicked(param1:Event) : void
      {
         buttonTabbedWindow.activateTabByButton(param1.target as MPButton);
      }
   }
}

