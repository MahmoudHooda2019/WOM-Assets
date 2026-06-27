package wom.model.game.help
{
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.Profile;
   
   public class HelpInfo
   {
      
      public static const INVALID_HELP_TYPE:int = 0;
      
      public static const BANK_RESOURCES:int = 1;
      
      public static const SPEED_UP_UPGRADE:int = 2;
      
      public static const SPEED_UP_FORTIFICATION:int = 3;
      
      public static const SPEED_UP_REPAIRS:int = 4;
      
      public static const SPEED_UP_RECRUITMENT:int = 5;
      
      public static const SPEED_UP_TRAINING:int = 6;
      
      public static const helpTypes:Array = [1,2,3,4,5,6];
      
      private var _helper:Profile;
      
      private var _helpType:int;
      
      private var _buildingInstanceId:int;
      
      private var _buildingTypeId:int;
      
      private var _durationReductionInMillis:Number;
      
      private var _bankedResources:ResourceAmountDTO;
      
      public function HelpInfo(param1:Profile, param2:int, param3:int, param4:Number, param5:ResourceAmountDTO)
      {
         super();
         _helper = param1;
         _helpType = param2;
         _buildingInstanceId = param3;
         _durationReductionInMillis = param4;
         _bankedResources = param5;
      }
      
      public static function createHelpInfo(param1:Object) : HelpInfo
      {
         return new HelpInfo(new Profile(param1.helper[0],param1.helper[1],param1.helper[2]),param1.helpType,param1.buildingInstanceId,param1.durationReductionInMillis,"bankedResources" in param1 && param1.bankedResources != null ? new ResourceAmountDTO(param1.bankedResources.id,param1.bankedResources.amount) : null);
      }
      
      public function get helper() : Profile
      {
         return _helper;
      }
      
      public function get helpType() : int
      {
         return _helpType;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get durationReductionInMillis() : Number
      {
         return _durationReductionInMillis;
      }
      
      public function get bankedResources() : ResourceAmountDTO
      {
         return _bankedResources;
      }
      
      public function get buildingTypeId() : int
      {
         return _buildingTypeId;
      }
      
      public function set buildingTypeId(param1:int) : void
      {
         _buildingTypeId = param1;
      }
      
      public function clone() : HelpInfo
      {
         var _loc1_:HelpInfo = new HelpInfo(_helper,_helpType,_buildingInstanceId,_durationReductionInMillis,_bankedResources);
         _loc1_.buildingTypeId = _buildingTypeId;
         return _loc1_;
      }
   }
}

