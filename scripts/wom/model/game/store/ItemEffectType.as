package wom.model.game.store
{
   public class ItemEffectType
   {
      
      public static const UNKNOWN:ItemEffectType = new ItemEffectType(0,"Unknown",false,false);
      
      public static const FASTER_UPGRADE:ItemEffectType = new ItemEffectType(1,"FasterUpgrade",false,true);
      
      public static const PRODUCTION_BOOST:ItemEffectType = new ItemEffectType(2,"ProductionBoost",false,true);
      
      public static const HIRING_BOOST:ItemEffectType = new ItemEffectType(3,"HiringBoost",false,false);
      
      public static const EXTRA_BARRACKS:ItemEffectType = new ItemEffectType(4,"ExtraBarracks",true,true);
      
      public static const BATTLE_PROTECTION:ItemEffectType = new ItemEffectType(5,"BattleProtection",false,true);
      
      public static const MERCENARY_DAMAGE_BOOST:ItemEffectType = new ItemEffectType(6,"MercenaryDamageBoost",false,true);
      
      public static const MERCENARY_ARMOR_BOOST:ItemEffectType = new ItemEffectType(7,"MercenaryArmorBoost",false,true);
      
      public static const MERCENARY_SPEED_BOOST:ItemEffectType = new ItemEffectType(8,"MercenarySpeedBoost",false,true);
      
      public static const TOWER_DAMAGE_BOOST:ItemEffectType = new ItemEffectType(9,"TowerDamageBoost",false,true);
      
      public static const BEGINNER_PROTECTION:ItemEffectType = new ItemEffectType(10,"BeginnerProtection",false,true);
      
      private var _id:int;
      
      private var _name:String;
      
      private var _cumulative:Boolean;
      
      private var _percentage:Boolean;
      
      public function ItemEffectType(param1:int, param2:String, param3:Boolean, param4:Boolean)
      {
         super();
         _id = param1;
         _name = param2;
         _cumulative = param3;
         _percentage = param4;
      }
      
      public static function determineItemEffectType(param1:int) : ItemEffectType
      {
         var _loc2_:ItemEffectType = ItemEffectType.UNKNOWN;
         switch(param1)
         {
            case FASTER_UPGRADE.id:
               _loc2_ = ItemEffectType.FASTER_UPGRADE;
               break;
            case PRODUCTION_BOOST.id:
               _loc2_ = ItemEffectType.PRODUCTION_BOOST;
               break;
            case HIRING_BOOST.id:
               _loc2_ = ItemEffectType.HIRING_BOOST;
               break;
            case EXTRA_BARRACKS.id:
               _loc2_ = ItemEffectType.EXTRA_BARRACKS;
               break;
            case BATTLE_PROTECTION.id:
               _loc2_ = ItemEffectType.BATTLE_PROTECTION;
               break;
            case MERCENARY_DAMAGE_BOOST.id:
               _loc2_ = ItemEffectType.MERCENARY_DAMAGE_BOOST;
               break;
            case MERCENARY_ARMOR_BOOST.id:
               _loc2_ = ItemEffectType.MERCENARY_ARMOR_BOOST;
               break;
            case MERCENARY_SPEED_BOOST.id:
               _loc2_ = ItemEffectType.MERCENARY_SPEED_BOOST;
               break;
            case TOWER_DAMAGE_BOOST.id:
               _loc2_ = ItemEffectType.TOWER_DAMAGE_BOOST;
               break;
            case BEGINNER_PROTECTION.id:
               _loc2_ = ItemEffectType.BEGINNER_PROTECTION;
               break;
            default:
               _loc2_ = ItemEffectType.UNKNOWN;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get cumulative() : Boolean
      {
         return _cumulative;
      }
      
      public function get percentage() : Boolean
      {
         return _percentage;
      }
   }
}

