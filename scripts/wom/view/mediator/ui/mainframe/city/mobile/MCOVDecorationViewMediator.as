package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.DecorationInfo;
   import wom.view.screen.windows.recycle.MobileRecycleDecorationWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVDecorationView;
   
   public class MCOVDecorationViewMediator extends MobileConstructableOptionsViewMediator
   {
      
      [Inject]
      public var decorationView:MCOVDecorationView;
      
      private var decorationInfo:DecorationInfo;
      
      private var decorationTypeDIO:DecorationTypeDIO;
      
      public function MCOVDecorationViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(decorationView.recycleButton,"triggered",onSellClicked);
      }
      
      override protected function updateView() : void
      {
         var _temp_2:* = baseView;
         var _temp_1:* = 1;
         var _loc1_:String = "domain.decoration." + decorationInfo.decorationTypeId + (decorationInfo.subType ? "." + decorationInfo.subType : "") + ".name";
         _temp_2.updateLevelAndName(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_));
         decorationView.setPrice(decorationTypeDIO.sellPrice);
      }
      
      override protected function updateData() : void
      {
         for each(decorationInfo in city.decorations)
         {
            if(decorationInfo.instanceId == decorationView.instanceId)
            {
               break;
            }
         }
         decorationTypeDIO = domainInfo.getDecoration(decorationInfo.decorationTypeId);
      }
      
      private function onSellClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRecycleDecorationWindow(decorationView.instanceId)));
      }
   }
}

