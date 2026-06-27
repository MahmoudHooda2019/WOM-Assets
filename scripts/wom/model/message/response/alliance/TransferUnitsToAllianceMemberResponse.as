package wom.model.message.response.alliance
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class TransferUnitsToAllianceMemberResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _memberId:String;
      
      private var _units:Vector.<UnitTypeAmountDTO>;
      
      private var _memberUnits:Vector.<UnitTypeAmountDTO>;
      
      private var _allianceBarracksLevel:int;
      
      private var _availableBarracksCapacity:int;
      
      private var _source:int;
      
      private var _unitLevels:Dictionary;
      
      public function TransferUnitsToAllianceMemberResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _memberId = param1.memberId;
         _source = param1.source;
         _allianceBarracksLevel = param1.allianceBarracksLevel;
         _availableBarracksCapacity = param1.availableAllianceBarracksCapacity;
         _units = new Vector.<UnitTypeAmountDTO>();
         _memberUnits = new Vector.<UnitTypeAmountDTO>();
         if(param1.units)
         {
            for each(var _loc3_ in param1.units)
            {
               _units.push(new UnitTypeAmountDTO(_loc3_.id,_loc3_.amount));
            }
         }
         if(param1.memberUnits)
         {
            for each(_loc3_ in param1.memberUnits)
            {
               _memberUnits.push(new UnitTypeAmountDTO(_loc3_.id,_loc3_.amount));
            }
         }
         _unitLevels = new Dictionary();
         if(param1.unitLevels)
         {
            for(var _loc2_ in param1.unitLevels)
            {
               _unitLevels[_loc2_] = param1.unitLevels[_loc2_];
            }
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get source() : int
      {
         return _source;
      }
      
      public function get memberId() : String
      {
         return _memberId;
      }
      
      public function get units() : Vector.<UnitTypeAmountDTO>
      {
         return _units;
      }
      
      public function get memberUnits() : Vector.<UnitTypeAmountDTO>
      {
         return _memberUnits;
      }
      
      public function get allianceBarracksLevel() : int
      {
         return _allianceBarracksLevel;
      }
      
      public function get availableBarracksCapacity() : int
      {
         return _availableBarracksCapacity;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
   }
}

