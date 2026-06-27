package wom.view.mediator.ui.tooltip
{
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.view.ui.tooltip.MobileExperiencePointsTooltipView;
   
   public class MobileExperiencePointsTooltipViewMediator extends MobileBaseTooltipViewMediator
   {
      
      [Inject]
      public var view:MobileExperiencePointsTooltipView;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileExperiencePointsTooltipViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("experiencePointsUpdated",onExperiencePointsUpdated,ModelUpdateEvent);
         onExperiencePointsUpdated(null);
      }
      
      private function onExperiencePointsUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc2_:int = 0;
         if(userInfo.experiencePoints)
         {
            _loc2_ = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
            view.updateWithData(userInfo.experiencePoints,ExperienceUtil.calculateExperienceOfLevel(_loc2_ + 1) - userInfo.experiencePoints);
         }
      }
   }
}

