package wom.view.mediator.ui.mainframe.city.chat
{
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.model.game.UserInfo;
   import wom.view.ui.mainframe.city.chat.MobileChatMutePanel;
   
   public class MobileChatMutePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileChatMutePanel;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileChatMutePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         eventMap.mapStarlingListener(view.closeButton,"touch",onCloseButtonClicked,TouchEvent);
         eventMap.mapStarlingListener(view.muteButton,"touch",onMuteButtonClicked,TouchEvent);
      }
      
      private function onMuteButtonClicked(param1:TouchEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Touch = param1.getTouch(view.muteButton,"ended");
         if(_loc2_)
         {
            _loc3_ = view.senderPid;
            if(userInfo.profile.gameId != _loc3_)
            {
               userInfo.mutedUsers[_loc3_] = true;
            }
            view.visible = false;
         }
      }
      
      private function onCloseButtonClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.closeButton,"ended");
         if(_loc2_)
         {
            view.visible = false;
         }
      }
   }
}

