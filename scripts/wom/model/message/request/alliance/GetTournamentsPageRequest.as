package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetTournamentsPageRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _pageOrder:int;
      
      private var _myAlliance:Boolean;
      
      private var _pageSize:int;
      
      public function GetTournamentsPageRequest(param1:int = 1, param2:Boolean = false, param3:int = 5)
      {
         super();
         _pageOrder = param1;
         _myAlliance = param2;
         _pageSize = param3;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {
            "myAlliance":_myAlliance,
            "pageSize":_pageSize
         };
         if(!_myAlliance)
         {
            _loc1_["pageOrder"] = _pageOrder;
         }
         return _loc1_;
      }
   }
}

