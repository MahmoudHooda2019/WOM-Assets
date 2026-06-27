package wom.model.dto.combat
{
   public class TriggeredExplosiveInfo
   {
      
      private var _typeId:int;
      
      private var _occurenceTimeInMillis:Number;
      
      public function TriggeredExplosiveInfo(param1:int, param2:Number)
      {
         super();
         _typeId = param1;
         _occurenceTimeInMillis = param2;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get occurenceTimeInMillis() : Number
      {
         return _occurenceTimeInMillis;
      }
   }
}

