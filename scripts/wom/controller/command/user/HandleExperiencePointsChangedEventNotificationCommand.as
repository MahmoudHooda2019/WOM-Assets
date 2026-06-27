package wom.controller.command.user
{
   import flash.external.ExternalInterface;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.friend.DefaultFriendInfo;
   import wom.model.message.notification.ExperiencePointsChangedEventNotification;
   import wom.model.resource.WomAssetRepository;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.popups.levelup.MobileLevelupPopup;
   import wom.view.screen.popups.passafriend.MobilePassAFriendPopUp;
   
   public class HandleExperiencePointsChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var womDocumentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function HandleExperiencePointsChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:* = undefined;
         var _loc5_:ExperiencePointsChangedEventNotification = messageReceivedEvent.message as ExperiencePointsChangedEventNotification;
         var _loc7_:int = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
         var _loc8_:int = ExperienceUtil.calculateLevelOfExperience(_loc5_.experiencePoints);
         var _loc1_:DefaultFriendInfo = null;
         for each(var _loc6_ in womDocumentConfiguration.womFriends)
         {
            if(userInfo.experiencePoints < _loc6_.experiencePoints && _loc5_.experiencePoints > _loc6_.experiencePoints)
            {
               if(_loc1_ != null && _loc6_.experiencePoints > _loc1_.experiencePoints)
               {
                  _loc1_ = _loc6_;
               }
               else
               {
                  _loc1_ = _loc6_;
               }
            }
         }
         var _loc4_:Number = ExperienceUtil.calculateExperienceOfLevel(_loc8_);
         var _loc3_:Number = ExperienceUtil.calculateExperienceOfLevel(_loc8_ + 1);
         userInfo.experiencePoints = _loc5_.experiencePoints;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("experiencePointsUpdated"));
         if(_loc8_ > _loc7_ && userInfo.mandatoryTutorialCompleted)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileLevelupPopup(_loc8_)));
         }
         else if((userInfo.experiencePoints - _loc4_) / (_loc3_ - _loc4_) > 0.9)
         {
            _loc2_ = new Vector.<String>();
            _loc2_.push("WorkerHappy");
            _loc2_.push("LevelUpImage");
            _loc2_.push("LevelUpLevel");
            assetRepository.preload(_loc2_);
         }
         if(_loc8_ > _loc7_ && _loc8_ == 3 && ExternalInterface.available)
         {
            ExternalInterface.call("WOM.buybuddy.track",3);
         }
         if(userInfo.mandatoryTutorialCompleted && _loc1_ != null)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobilePassAFriendPopUp(userInfo.profile,facebookAPIManager.getUserNameByProfile(userInfo.profile),userInfo.experiencePoints,_loc1_.profile,facebookAPIManager.getUserNameByProfile(_loc1_.profile),_loc1_.experiencePoints)));
         }
      }
   }
}

