package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.CityInfoDTO;
   import wom.model.game.Profile;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   
   public class StartVisitingCityResponse extends AbstractIncomingMessage
   {
      
      public static const SUCCESS:int = 0;
      
      public static const GENERAL_FAILURE:int = 1;
      
      public static const NO_SUCH_USER_TO_VISIT:int = 2;
      
      public static const NO_SUCH_CITY:int = 3;
      
      public static const VISITED_CITY_UNDER_ATTACK:int = 4;
      
      public static const CAN_NOT_VISIT_OWN_CITY:int = 5;
      
      public static const RESIDENT_TUTORIAL_IN_PROGRESS:int = 6;
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _interactable:Boolean;
      
      private var _landlord:Profile;
      
      private var _combatItemEffects:Vector.<ItemEffectInfo>;
      
      private var _guid:Number;
      
      private var _isOutOfReachForAttack:Boolean;
      
      private var _bpGainEnabled:Boolean;
      
      private var _city:CityInfoDTO;
      
      private var _version:int = -1;
      
      public function StartVisitingCityResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc5_:ItemEffectType = null;
         var _loc4_:Object = null;
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if(resultCode == 0)
         {
            if("guid" in param1 && param1.guid)
            {
               _guid = param1.guid;
            }
            if(param1.plyr && param1.plyr != null)
            {
               _landlord = new Profile(param1.plyr[0],param1.plyr[1],param1.plyr[2]);
            }
            else
            {
               _landlord = new Profile(null,null,null,param1.npcName,param1.npcClanId);
            }
            if(param1.view)
            {
               _loc2_ = param1.view.combatItems;
               _combatItemEffects = new Vector.<ItemEffectInfo>();
               for each(var _loc3_ in _loc2_)
               {
                  if(_loc3_ != null)
                  {
                     _loc5_ = ItemEffectType.determineItemEffectType(_loc3_.itemEffectType);
                     _combatItemEffects.push(new ItemEffectInfo(_loc5_,_loc3_.bonusPercent,_loc3_.dateStartedUsing,_loc3_.dateEndOfUsage,_loc3_.remainingDuration));
                  }
               }
               _loc4_ = param1.view;
               _interactable = param1.interactable;
               _city = new CityInfoDTO();
               _city.deserialize(_loc4_);
               if("version" in param1.view)
               {
                  _version = param1.view.version;
               }
            }
         }
         if("outOfReach" in param1)
         {
            _isOutOfReachForAttack = param1["outOfReach"];
         }
         _bpGainEnabled = true;
         if("bpGainEnabled" in param1)
         {
            _bpGainEnabled = param1["bpGainEnabled"];
         }
      }
      
      public function get version() : int
      {
         return _version;
      }
      
      public function get landlord() : Profile
      {
         return _landlord;
      }
      
      public function get city() : CityInfoDTO
      {
         return _city;
      }
      
      public function get combatItemEffects() : Vector.<ItemEffectInfo>
      {
         return _combatItemEffects;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get interactable() : Boolean
      {
         return _interactable;
      }
      
      public function get guid() : Number
      {
         return _guid;
      }
      
      public function get isOutOfReachForAttack() : Boolean
      {
         return _isOutOfReachForAttack;
      }
      
      public function get bpGainEnabled() : Boolean
      {
         return _bpGainEnabled;
      }
   }
}

