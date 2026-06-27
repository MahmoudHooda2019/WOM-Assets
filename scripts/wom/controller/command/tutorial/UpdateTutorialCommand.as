package wom.controller.command.tutorial
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.tutorial.TutorialAdditionalInfo;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.message.request.UpdateTutorialRequest;
   
   public class UpdateTutorialCommand extends PCommand
   {
      
      [Inject]
      public var event:TutorialEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function UpdateTutorialCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"Tutorial info change will be sent to server");
         var _loc1_:Object = {};
         _loc1_.tutorials = createTutorials();
         _loc1_.enabled = userInfo.tutorialsInfo.enabled;
         _loc1_.additionalInfo = createAdditionalInfoObject();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new UpdateTutorialRequest(PJSON.encode(_loc1_))));
      }
      
      private function createTutorials() : Vector.<Object>
      {
         var _loc4_:TutorialInfo = null;
         var _loc5_:* = undefined;
         var _loc1_:int = 0;
         var _loc6_:* = undefined;
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         for(var _loc3_ in userInfo.tutorialsInfo.tutorials)
         {
            _loc4_ = userInfo.tutorialsInfo.tutorials[_loc3_];
            if(_loc4_.isCompleted)
            {
               _loc2_.push({
                  "id":_loc4_.tutorialId,
                  "isCompleted":true
               });
            }
            else
            {
               _loc5_ = new Vector.<Object>();
               _loc1_ = 0;
               while(_loc1_ < _loc4_.states.length)
               {
                  _loc6_ = new Vector.<Object>();
                  for(var _loc7_ in _loc4_.states[_loc1_].additionalInfo)
                  {
                     _loc6_.push({
                        "key":_loc7_,
                        "val":_loc4_.states[_loc1_].additionalInfo[_loc7_]
                     });
                  }
                  _loc5_.push({
                     "index":_loc1_,
                     "additionalInfo":_loc6_
                  });
                  _loc1_++;
               }
               _loc2_.push({
                  "id":_loc4_.tutorialId,
                  "isCompleted":_loc4_.isCompleted,
                  "currentStateIndex":_loc4_.currentStateIndex,
                  "states":_loc5_
               });
            }
         }
         return _loc2_;
      }
      
      private function createAdditionalInfoObject() : Object
      {
         var _loc1_:TutorialAdditionalInfo = userInfo.tutorialsInfo.additionalInfo;
         return {
            "tempVar1":_loc1_.tempVar1,
            "firstNpcBattle":_loc1_.firstNpcBattle,
            "firstPvPBattle":_loc1_.firstPvPBattle,
            "beastCageStatus":_loc1_.beastCageStatus,
            "completedAchievements":_loc1_.completedAchievements
         };
      }
   }
}

