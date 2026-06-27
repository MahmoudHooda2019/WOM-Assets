package wom.model.dto.combat
{
   import flash.utils.Dictionary;
   
   public class PostNPCBattleInfo
   {
      
      private var _defenderInfo:PostBattleDefenderInfo;
      
      private var _lootedHarvestedResources:Array;
      
      private var _lootedUnharvestedResources:Dictionary;
      
      public function PostNPCBattleInfo(param1:PostBattleDefenderInfo, param2:Array, param3:Dictionary)
      {
         super();
         this._defenderInfo = param1;
         this._lootedHarvestedResources = param2;
         this._lootedUnharvestedResources = param3;
      }
      
      public function get defenderInfo() : PostBattleDefenderInfo
      {
         return _defenderInfo;
      }
      
      public function get lootedHarvestedResources() : Array
      {
         return _lootedHarvestedResources;
      }
      
      public function get lootedUnharvestedResources() : Dictionary
      {
         return _lootedUnharvestedResources;
      }
   }
}

