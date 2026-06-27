package wom.controller.command.visit
{
   import flash.utils.Dictionary;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.GameModeType;
   import wom.model.message.request.StartVisitingCityRequest;
   import wom.model.message.request.StartVisitingNPCCityRequest;
   
   public class StartVisitCommand extends PersistAttackInformationCommand
   {
      
      [Inject]
      public var event:StartVisitEvent;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function StartVisitCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            persistAttackingInformation();
            userInfo.redirectToMap = event.fromMap;
            userInfo.mapInCampaignMode = event.fromCampaign;
         }
         visitInfo.isScout = event.isScout;
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["initiateVisit"] = {
            "npc":event.npc,
            "gameId":event.profile.gameId
         };
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING,_loc1_,onLoadingComplete));
      }
      
      protected function onLoadingComplete() : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",event.npc ? new StartVisitingNPCCityRequest(event.profile.gameId) : new StartVisitingCityRequest(event.profile.gameId)));
      }
   }
}

