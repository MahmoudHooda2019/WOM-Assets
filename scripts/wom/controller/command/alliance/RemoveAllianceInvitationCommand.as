package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.alliance.RemoveAllianceInvitationEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.friend.request.AllianceInvitationRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class RemoveAllianceInvitationCommand extends PCommand
   {
      
      [Inject]
      public var event:RemoveAllianceInvitationEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      public function RemoveAllianceInvitationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:int = 0;
         var _loc1_:* = undefined;
         var _loc4_:AllianceInvitationRequestInfo = null;
         var _loc5_:Number = event.allianceId;
         if(!isNaN(_loc5_))
         {
            _loc6_ = 0;
            while(_loc6_ < allianceInfo.invitations.length)
            {
               if(allianceInfo.invitations[_loc6_].allianceId == _loc5_)
               {
                  allianceInfo.invitations.splice(_loc6_,1);
               }
               _loc6_++;
            }
            if(10 in inboxInfo.requests)
            {
               _loc1_ = inboxInfo.requests[10];
               for each(var _loc2_ in _loc1_)
               {
                  for each(var _loc3_ in _loc2_)
                  {
                     if(_loc3_ is AllianceInvitationRequestInfo)
                     {
                        _loc4_ = _loc3_ as AllianceInvitationRequestInfo;
                        if(_loc4_.invitation.allianceId == _loc5_)
                        {
                           _loc2_.splice(_loc2_.indexOf(_loc3_),1);
                           if(10 in inboxInfo.counts)
                           {
                              inboxInfo.counts[10]--;
                           }
                           else
                           {
                              inboxInfo.counts[10] = 0;
                           }
                           break;
                        }
                     }
                  }
                  if(_loc2_.length <= 0)
                  {
                     _loc1_.splice(_loc1_.indexOf(_loc2_),1);
                     break;
                  }
               }
            }
         }
         inboxInfo.addFromClient["alliance"] = allianceInfo.invitations.length;
         dispatch(new ModelUpdateEvent("inboxCountUpdated"));
      }
   }
}

