package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.model.message.response.HireUnitResponse;
   
   public class HandleHireUnitResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleHireUnitResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:HireUnitResponse = messageReceivedEvent.message as HireUnitResponse;
         if(_loc1_.resultCode == 0 && _loc1_.unitAmounts.length > 0)
         {
            checkTutorialQuest50(_loc1_.unitAmounts);
         }
      }
      
      private function checkTutorialQuest50(param1:Vector.<UnitTypeAmountDTO>) : void
      {
         var _loc3_:TutorialInfo = null;
         var _loc4_:TutorialState = null;
         if(userInfo.tutorialsInfo.enabled)
         {
            _loc3_ = "bed" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["bed"] : null;
            if(_loc3_ != null && !_loc3_.isCompleted)
            {
               _loc4_ = _loc3_.states[_loc3_.states[0].additionalInfo["stateIndexHireUnit"]];
               if("unitTypeId" in _loc4_.additionalInfo)
               {
                  for each(var _loc2_ in param1)
                  {
                     if(_loc2_.id == _loc4_.additionalInfo["unitTypeId"])
                     {
                        if(!("progress" in _loc4_.additionalInfo))
                        {
                           _loc4_.additionalInfo["progress"] = 0;
                        }
                        var _loc5_:String = "progress";
                        var _loc6_:Number = _loc4_.additionalInfo[_loc5_] + _loc2_.amount;
                        _loc4_.additionalInfo[_loc5_] = _loc6_;
                        dispatch(new TutorialEvent("saveTutorialsToServer",_loc3_.tutorialId));
                        dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
                        break;
                     }
                  }
               }
            }
         }
      }
   }
}

