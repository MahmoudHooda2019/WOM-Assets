package wom.view.mediator.screen.popups.congratulations
{
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.viral.WallPostParams;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.levelup.MobileLevelupPopup;
   
   public class MobileLevelupPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileLevelupPopup;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileLevelupPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.level = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onShareButtonClicked,Event);
         soundPlayer.playSfxById("LevelUp");
         view.lightAnimation.rotate(10);
      }
      
      private function onShareButtonClicked() : void
      {
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(5,view.level)));
         closeWindow();
      }
   }
}

