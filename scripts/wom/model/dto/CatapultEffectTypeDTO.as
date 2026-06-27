package wom.model.dto
{
   public class CatapultEffectTypeDTO
   {
      
      private var _effectType:String;
      
      private var _effectValuesPerStage:Vector.<Number>;
      
      public function CatapultEffectTypeDTO(param1:String, param2:Vector.<Number>)
      {
         super();
         this._effectType = param1;
         this._effectValuesPerStage = param2;
      }
      
      public function get effectType() : String
      {
         return _effectType;
      }
      
      public function set effectType(param1:String) : void
      {
         _effectType = param1;
      }
      
      public function get effectValuesPerStage() : Vector.<Number>
      {
         return _effectValuesPerStage;
      }
      
      public function set effectValuesPerStage(param1:Vector.<Number>) : void
      {
         _effectValuesPerStage = param1;
      }
   }
}

