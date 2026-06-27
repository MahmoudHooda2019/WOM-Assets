package wom.view.mediator.screen.windows.tavern
{
   import com.greensock.TweenMax;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.tavern.TavernInfo;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.tavern.MobileTavernUnlockPanel;
   import wom.view.screen.windows.tavern.unlock.MobileTavernUnlockedCardView;
   
   public class MobileTavernUnlockPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileTavernUnlockPanel;
      
      [Inject]
      public var tavernInfo:TavernInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileTavernUnlockPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("tavernCardUnlocked",onTavernCardUnlocked,ModelUpdateEvent);
         tavernCardUnlocked(false);
      }
      
      private function tavernCardUnlocked(param1:Boolean) : void
      {
         var _loc3_:MobileTavernUnlockedCardView = null;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = view.unlockedCardViews[_loc4_];
            _loc2_ = _loc3_.update(tavernInfo.unlockedCards[_loc4_] ? domainInfo.getUnlockedTavernItem(_loc4_) : null,param1);
            if(_loc2_)
            {
               TweenMax.to(_loc3_.background,0.5,{
                  "glowFilter":{
                     "color":3368703,
                     "alpha":1,
                     "blurX":10,
                     "blurY":10,
                     "strength":2
                  },
                  "repeat":5,
                  "yoyo":true
               });
            }
            _loc4_++;
         }
      }
      
      private function onTavernCardUnlocked(param1:ModelUpdateEvent) : void
      {
         tavernCardUnlocked(true);
      }
   }
}

