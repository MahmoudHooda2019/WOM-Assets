package wom.model.dto.combat
{
   public class CatapultInfo
   {
      
      public var type:int;
      
      public var size:int;
      
      public function CatapultInfo(param1:int, param2:int)
      {
         super();
         this.type = param1;
         this.size = param2;
      }
      
      public function clone() : CatapultInfo
      {
         return new CatapultInfo(type,size);
      }
   }
}

