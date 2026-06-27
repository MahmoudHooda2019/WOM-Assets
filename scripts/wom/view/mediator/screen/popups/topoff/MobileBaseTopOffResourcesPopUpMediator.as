package wom.view.mediator.screen.popups.topoff
{
   import starling.events.Event;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.topoff.MobileBaseTopOffResourcesPopUp;
   
   public class MobileBaseTopOffResourcesPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var mainView:MobileBaseTopOffResourcesPopUp;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileBaseTopOffResourcesPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         mainView.requiredGold = calculateRequiredGold();
         super.onRegister();
         eventMap.mapStarlingListener(mainView.actionButton,"triggered",onConfirmButtonClicked,Event);
      }
      
      protected function onConfirmButtonClicked(param1:Event) : void
      {
         if(mainView.requiredGold > userInfo.numberOfGolds)
         {
            mainView.addWindowEnumeration(new WindowEnumeration(0,{"womview":mainView}));
            mainView.addWindowEnumeration(new WindowEnumeration(42,{"type":MonetizationType.NOT_ENOUGH_GOLD}));
            closeWindow();
         }
      }
      
      public function calculateRequiredGold() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for each(var _loc1_ in mainView.missingResourcesArray)
         {
            _loc3_ = int(_loc1_.amount);
            if(_loc3_ > 0)
            {
               _loc2_ += _loc3_;
            }
         }
         return StoreUtil.resourcePrice(_loc2_);
      }
   }
}

