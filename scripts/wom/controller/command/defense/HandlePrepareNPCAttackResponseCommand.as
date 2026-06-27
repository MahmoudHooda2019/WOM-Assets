package wom.controller.command.defense
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.UserInfo;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.defense.UnitBatchInfoDTO;
   import wom.model.game.quest.QuestInfo;
   import wom.model.message.request.StartNPCAttackRequest;
   import wom.model.message.response.PrepareNPCAttackResponse;
   import wom.model.resource.WomAssetRepository;
   import wom.view.screen.popups.npcattack.mobile.MobileNPCAttackPopup;
   
   public class HandlePrepareNPCAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function HandlePrepareNPCAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:PrepareNPCAttackResponse = messageReceivedEvent.message as PrepareNPCAttackResponse;
         userInfo.npcAttackPrepared = true;
         if(userInfo.npcAttackStatus != NPCAttackStatus.DELAY)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.ASK;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
         }
         var _loc6_:Dictionary = new Dictionary();
         for each(var _loc4_ in _loc1_.batches)
         {
            if(!(_loc4_.batch.id in _loc6_))
            {
               _loc6_[_loc4_.batch.id] = 0;
            }
            var _loc7_:int = _loc4_.batch.id;
            var _loc8_:Number = _loc6_[_loc7_] + _loc4_.batch.amount;
            _loc6_[_loc7_] = _loc8_;
         }
         var _loc3_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         var _loc5_:Vector.<String> = new Vector.<String>();
         for(var _loc2_ in _loc6_)
         {
            _loc3_.push(new UnitTypeAmountDTO(int(_loc2_),_loc6_[_loc2_]));
            _loc5_.push("U" + _loc2_ + "Motion");
         }
         assetRepository.preload(_loc5_);
         _loc3_.sort(compareUnitTypesOnHireCosts);
         if(!checkTutorialQuest20() && userInfo.npcAttackStatus == NPCAttackStatus.ASK)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileNPCAttackPopup(_loc1_.npcName,_loc3_)));
         }
      }
      
      private function compareUnitTypesOnHireCosts(param1:UnitTypeAmountDTO, param2:UnitTypeAmountDTO) : int
      {
         var _loc5_:UnitTypeDIO = domainInfo.getUnit(param1.id);
         var _loc4_:UnitTypeDIO = domainInfo.getUnit(param2.id);
         var _loc3_:int = ((_loc5_.hiringCostsPerLevel[0] as Vector.<ResourceAmountDTO>)[0] as ResourceAmountDTO).resourceAmount;
         var _loc6_:int = ((_loc4_.hiringCostsPerLevel[0] as Vector.<ResourceAmountDTO>)[0] as ResourceAmountDTO).resourceAmount;
         if(_loc3_ > _loc6_)
         {
            return -1;
         }
         if(_loc3_ < _loc6_)
         {
            return 1;
         }
         return 0;
      }
      
      private function checkTutorialQuest20() : Boolean
      {
         for each(var _loc1_ in userInfo.quests)
         {
            if(_loc1_.questId == 20 && !_loc1_.completed)
            {
               userInfo.canReceiveNPCAttacks = false;
               userInfo.npcAttackStatus = NPCAttackStatus.INIT_ATTACK;
               dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
               dispatch(new OutgoingMessageEvent("outgoingMessage",new StartNPCAttackRequest()));
               return true;
            }
         }
         return false;
      }
   }
}

