package wom.model.game.store
{
   public class ItemEffectInfo
   {
      
      private var _type:ItemEffectType;
      
      private var _bonusPercent:int;
      
      private var _dateStartedUsing:Number;
      
      private var _dateEndOfUsage:Number;
      
      private var _durationRemaining:Number;
      
      private var _creationDate:Number;
      
      public function ItemEffectInfo(param1:ItemEffectType, param2:int, param3:Number, param4:Number, param5:Number)
      {
         super();
         this._type = param1;
         this._bonusPercent = param2;
         this._dateStartedUsing = param3;
         this._dateEndOfUsage = param4;
         _durationRemaining = param5;
         _creationDate = new Date().getTime();
      }
      
      public function get type() : ItemEffectType
      {
         return _type;
      }
      
      public function get bonusPercent() : int
      {
         return _bonusPercent;
      }
      
      public function get dateStartedUsing() : Number
      {
         return _dateStartedUsing;
      }
      
      public function get dateEndOfUsage() : Number
      {
         return _dateEndOfUsage;
      }
      
      public function get bonusModifier() : Number
      {
         return (100 + _bonusPercent * (_type == ItemEffectType.MERCENARY_ARMOR_BOOST ? -1 : 1)) / 100;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
      
      public function get creationDate() : Number
      {
         return _creationDate;
      }
   }
}

