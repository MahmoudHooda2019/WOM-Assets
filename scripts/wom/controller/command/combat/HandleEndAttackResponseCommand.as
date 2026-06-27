package wom.controller.command.combat
{
   import flash.external.ExternalInterface;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.game.Profile;
   import wom.model.game.TutorialDefender;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.attack.CatapultTimeUtil;
   import wom.model.game.report.AttackLog;
   import wom.model.game.report.MobileAttackLog;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.response.EndAttackResponse;
   
   public class HandleEndAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleEndAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Profile = null;
         var _loc1_:EndAttackResponse = event.message as EndAttackResponse;
         if(_loc1_.resultCode == 0)
         {
            userInfo.npcAttackPrepared = false;
            userInfo.catapultActivationRemainingTimes = CatapultTimeUtil.calculateCatapultRemainingTimes(userInfo.catapultActivationRemainingTimes,_loc1_.lastCatapultFiredTimes);
            if(_loc1_.battleReport != null)
            {
               if(!(_loc1_.battleReport.attackLogId in userInfo.battleReports))
               {
                  userInfo.battleReports[_loc1_.battleReport.attackLogId] = _loc1_.battleReport;
               }
               if(userInfo.attackLogs == null)
               {
                  userInfo.attackLogs = new Vector.<AttackLog>();
               }
               _loc2_ = false;
               for each(var _loc4_ in userInfo.attackLogs)
               {
                  if(_loc4_.id == _loc1_.battleReport.attackLogId)
                  {
                     _loc2_ = true;
                     break;
                  }
               }
               _loc3_ = _loc1_.battleReport.tutorialAttack ? TutorialDefender.PROFILE : _loc1_.defender;
               if(!_loc2_)
               {
                  userInfo.attackLogs.push(new MobileAttackLog(_loc1_.battleReport.attackLogId,userInfo.profile,allianceInfo.myAllianceSummary,_loc3_,_loc1_.defenderAlliance,_loc1_.attackDurationInMillis,_loc1_.attackStartTimeInMillis,true,_loc1_.battleReport.isQuickAttack,_loc1_.star,_loc1_.battlePointDifference,_loc1_.eventPoints,_loc1_.battleReport.attackerLevel,_loc1_.battleReport.defenderLevel,_loc1_.battleReport.tutorialAttack));
                  if(_loc3_.npcClan == "NPC-6" && _loc1_.star > 0)
                  {
                     markDefeatedEventNPCs(_loc3_.npcId);
                  }
               }
               dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(24,{
                  "logId":_loc1_.battleReport.attackLogId,
                  "startInMillis":_loc1_.attackStartTimeInMillis,
                  "afterAttack":true,
                  "attacker":userInfo.profile,
                  "defender":_loc3_
               })));
               if(userInfo.mandatoryTutorialCompleted && userInfo.tutorialsInfo != null)
               {
                  if(_loc3_.isNpc)
                  {
                     if(!userInfo.tutorialsInfo.additionalInfo.firstNpcBattle)
                     {
                        userInfo.tutorialsInfo.additionalInfo.firstNpcBattle = true;
                        dispatch(new TutorialEvent("saveTutorialsToServer"));
                        if(ExternalInterface.available)
                        {
                           ExternalInterface.call("WOM.buybuddy.track",4);
                        }
                     }
                  }
                  else if(!userInfo.tutorialsInfo.additionalInfo.firstPvPBattle)
                  {
                     userInfo.tutorialsInfo.additionalInfo.firstPvPBattle = true;
                     dispatch(new TutorialEvent("saveTutorialsToServer"));
                     if(ExternalInterface.available)
                     {
                        ExternalInterface.call("WOM.buybuddy.track",5);
                     }
                  }
               }
            }
         }
      }
      
      private function markDefeatedEventNPCs(param1:String) : void
      {
         for each(var _loc2_ in userInfo.attackLogs)
         {
            if(_loc2_.defender.npcClan == "NPC-6" && _loc2_.defender.npcId == param1)
            {
               _loc2_.npcDefeated = true;
            }
         }
      }
   }
}

