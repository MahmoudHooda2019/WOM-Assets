package wom.model.dto.combat
{
   import flash.utils.Dictionary;
   import wom.model.game.Profile;
   
   public class PostBattleAttackerInfo
   {
      
      private var _profile:Profile;
      
      private var _beastHealth:Number;
      
      private var _lootedParts:Dictionary;
      
      public function PostBattleAttackerInfo(param1:Profile, param2:Number, param3:Dictionary)
      {
         super();
         _profile = param1;
         _beastHealth = param2;
         _lootedParts = param3;
      }
      
      public static function deserialize(param1:Object) : PostBattleAttackerInfo
      {
         var _loc3_:Number = Number(param1.beastHealth);
         var _loc2_:Dictionary = new Dictionary();
         for each(var _loc4_ in param1.lootedParts)
         {
            _loc2_[_loc4_.id] = _loc4_.amount;
         }
         return new PostBattleAttackerInfo(null,_loc3_,_loc2_);
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get beastHealth() : Number
      {
         return _beastHealth;
      }
      
      public function get lootedParts() : Dictionary
      {
         return _lootedParts;
      }
      
      public function serialize() : Object
      {
         var _loc1_:Array = [];
         for(var _loc2_ in _lootedParts)
         {
            _loc1_.push({
               "id":_loc2_,
               "amount":_lootedParts[_loc2_]
            });
         }
         return {
            "beastHealth":(_beastHealth == -1 ? null : _beastHealth),
            "lootedParts":_loc1_
         };
      }
   }
}

