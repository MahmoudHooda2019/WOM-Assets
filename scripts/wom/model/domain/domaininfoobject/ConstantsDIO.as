package wom.model.domain.domaininfoobject
{
   public class ConstantsDIO
   {
      
      private var _yardUnitPerSecond:Number;
      
      public function ConstantsDIO(param1:Number)
      {
         super();
         _yardUnitPerSecond = param1;
      }
      
      public function get yardUnitPerSecond() : Number
      {
         return _yardUnitPerSecond;
      }
   }
}

