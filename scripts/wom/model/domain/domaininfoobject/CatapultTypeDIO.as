package wom.model.domain.domaininfoobject
{
   import wom.model.dto.CatapultEffectTypeDTO;
   import wom.model.dto.ResourceAmountDTO;
   
   public class CatapultTypeDIO
   {
      
      public static const LUMBER_SALVO:int = 1;
      
      public static const HURLING_STONES:int = 2;
      
      public static const MIGHTY_RAGE:int = 3;
      
      public static const ACID_RAIN:int = 4;
      
      public static const ICE_SHARDS:int = 5;
      
      public static const HEAL_AURA:int = 6;
      
      public static const SMALL:int = 0;
      
      public static const MEDIUM:int = 1;
      
      public static const LARGE:int = 2;
      
      public static const XLARGE:int = 3;
      
      private var _id:int;
      
      private var _name:String;
      
      private var _maxStage:int;
      
      private var _rangesPerStaqe:Vector.<int>;
      
      private var _resourceCosts:Vector.<Vector.<ResourceAmountDTO>>;
      
      private var _activationTimesPerStage:Vector.<int>;
      
      private var _effectValues:Vector.<CatapultEffectTypeDTO>;
      
      private var _upgradeTimesInSecs:Vector.<int>;
      
      public function CatapultTypeDIO(param1:int, param2:String, param3:int, param4:Vector.<int>, param5:Vector.<Vector.<ResourceAmountDTO>>, param6:Vector.<int>, param7:Vector.<CatapultEffectTypeDTO>, param8:Vector.<int>)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._maxStage = param3;
         this._rangesPerStaqe = param4;
         this._resourceCosts = param5;
         this._activationTimesPerStage = param6;
         this._effectValues = param7;
         this._upgradeTimesInSecs = param8;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get maxStage() : int
      {
         return _maxStage;
      }
      
      public function set maxStage(param1:int) : void
      {
         _maxStage = param1;
      }
      
      public function get rangesPerStaqe() : Vector.<int>
      {
         return _rangesPerStaqe;
      }
      
      public function set rangesPerStaqe(param1:Vector.<int>) : void
      {
         _rangesPerStaqe = param1;
      }
      
      public function get resourceCosts() : Vector.<Vector.<ResourceAmountDTO>>
      {
         return _resourceCosts;
      }
      
      public function set resourceCosts(param1:Vector.<Vector.<ResourceAmountDTO>>) : void
      {
         _resourceCosts = param1;
      }
      
      public function get activationTimesPerStage() : Vector.<int>
      {
         return _activationTimesPerStage;
      }
      
      public function set activationTimesPerStage(param1:Vector.<int>) : void
      {
         _activationTimesPerStage = param1;
      }
      
      public function get effectValues() : Vector.<CatapultEffectTypeDTO>
      {
         return _effectValues;
      }
      
      public function set effectValues(param1:Vector.<CatapultEffectTypeDTO>) : void
      {
         _effectValues = param1;
      }
      
      public function get upgradeTimesInSecs() : Vector.<int>
      {
         return _upgradeTimesInSecs;
      }
   }
}

