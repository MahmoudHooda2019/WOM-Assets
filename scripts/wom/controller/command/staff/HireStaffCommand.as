package wom.controller.command.staff
{
   import flash.utils.Dictionary;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.staff.HireStaffEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.Profile;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.model.message.request.HireStaffRequest;
   
   public class HireStaffCommand extends PCommand
   {
      
      [Inject]
      public var event:HireStaffEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function HireStaffCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc7_:* = undefined;
         var _loc4_:* = null;
         for each(_loc4_ in city.buildings)
         {
            if(_loc4_.buildingTypeId == 10)
            {
               _loc7_ = _loc4_.staffs != null ? _loc4_.staffs : new Vector.<StaffInfo>();
               break;
            }
         }
         var _loc3_:Profile = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(var _loc2_ in _loc7_)
         {
            if(_loc2_.profile.platformId != null || _loc2_.profile.avatar != null)
            {
               _loc1_[_loc2_.profile.platformId ? _loc2_.profile.platformId : _loc2_.profile.avatar] = true;
            }
         }
         var _loc5_:Vector.<FriendInfo> = new Vector.<FriendInfo>();
         for each(var _loc6_ in documentConfiguration.friends)
         {
            if((_loc6_.profile.platformId != null || _loc6_.profile.avatar != null) && _loc6_.profile.gameId == null && !(_loc6_.profile.platformId in _loc1_ || _loc6_.profile.avatar in _loc1_))
            {
               _loc5_.push(_loc6_);
            }
         }
         if(_loc5_.length > 0)
         {
            _loc3_ = _loc5_.splice(_loc5_.length * Math.random(),1)[0].profile;
         }
         soundPlayer.playSfxById("PurchaseSuccessful");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new HireStaffRequest(_loc4_.instanceId,event.staffId,_loc3_)));
      }
   }
}

