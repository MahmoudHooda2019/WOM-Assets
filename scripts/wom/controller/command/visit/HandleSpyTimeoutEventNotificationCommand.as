package wom.controller.command.visit
{
   import wom.controller.command.city.CityLoaderCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.VisitInfo;
   import wom.model.game.friend.FriendInfo;
   
   public class HandleSpyTimeoutEventNotificationCommand extends CityLoaderCommand
   {
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function HandleSpyTimeoutEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         city.spyEnabled = false;
         coreManager.endSpying();
         var _loc1_:Boolean = false;
         if(!visitInfo.landlord.isNpc)
         {
            for each(var _loc3_ in documentConfiguration.friends)
            {
               if(_loc3_.profile.gameId == visitInfo.landlord.gameId)
               {
                  _loc1_ = true;
                  break;
               }
            }
         }
         var _loc2_:Boolean = _loc1_ || visitInfo.landlord.isNpc && visitInfo.landlord.npcId == "NPC_5";
         if(_loc2_)
         {
            coreManager.determineHelpableStatusOfBuildings();
         }
         dispatch(new ModelUpdateEvent("spyStatusChange"));
      }
   }
}

