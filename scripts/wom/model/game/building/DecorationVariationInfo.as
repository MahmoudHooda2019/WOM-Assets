package wom.model.game.building
{
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   
   public class DecorationVariationInfo
   {
      
      private var _dio:DecorationTypeDIO;
      
      private var _kind:String;
      
      public function DecorationVariationInfo(param1:DecorationTypeDIO, param2:String)
      {
         super();
         _dio = param1;
         _kind = param2;
      }
      
      public function get dio() : DecorationTypeDIO
      {
         return _dio;
      }
      
      public function get kind() : String
      {
         return _kind;
      }
   }
}

