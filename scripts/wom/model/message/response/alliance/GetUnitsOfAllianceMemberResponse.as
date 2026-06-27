package wom.model.message.response.alliance
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class GetUnitsOfAllianceMemberResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _memberId:String;
      
      private var _allianceBarracksLevel:int;
      
      private var _availableBarracksCapacity:int;
      
      private var _units:Vector.<UnitTypeAmountDTO>;
      
      private var _unitLevels:Dictionary;
      
      public function GetUnitsOfAllianceMemberResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _memberId = param1.memberId;
         _allianceBarracksLevel = param1.allianceBarracksLevel;
         _availableBarracksCapacity = param1.availableAllianceBarracksCapacity;
         _units = new Vector.<UnitTypeAmountDTO>();
         if(param1.units)
         {
            for each(var _loc3_ in param1.units)
            {
               _units.push(new UnitTypeAmountDTO(_loc3_.id,_loc3_.amount));
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
      
      public function get memberId() : String
      {
         return _memberId;
      }
      
      public function get allianceBarracksLevel() : int
      {
         return _allianceBarracksLevel;
      }
      
      public function get availableBarracksCapacity() : int
      {
         return _availableBarracksCapacity;
      }
      
      public function get units() : Vector.<UnitTypeAmountDTO>
      {
         return _units;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
   }
}

