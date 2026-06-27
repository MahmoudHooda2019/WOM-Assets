package wom.model.game.friend.request
{
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.Profile;
   
   public class PartRequestInfo extends RequestInfo
   {
      
      private var _partDIO:PartTypeDIO;
      
      public function PartRequestInfo(param1:Number, param2:Number, param3:int, param4:Profile, param5:String, param6:PartTypeDIO)
      {
         super(param1,param2,param3,param4,param5);
         _partDIO = param6;
      }
      
      public function get partDIO() : PartTypeDIO
      {
         return _partDIO;
      }
   }
}

