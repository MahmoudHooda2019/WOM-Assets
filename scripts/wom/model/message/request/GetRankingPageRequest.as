package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetRankingPageRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public static const MOBILE_PAGE_SIZE:int = 50;
      
      private var _rankedGameUid:String;
      
      private var _pageOrder:int;
      
      private var _lastPage:Boolean;
      
      private var _sortCriteria:int;
      
      private var _pageSize:Object;
      
      public function GetRankingPageRequest(param1:String, param2:int, param3:Boolean, param4:int, param5:Object = null)
      {
         super();
         _rankedGameUid = param1;
         _pageOrder = param2;
         _lastPage = param3;
         _sortCriteria = param4;
         _pageSize = param5;
      }
      
      override public function serialize() : Object
      {
         return {
            "rankedGameUid":_rankedGameUid,
            "pageOrder":_pageOrder,
            "lastPage":_lastPage,
            "sortCriteria":_sortCriteria,
            "pageSize":_pageSize
         };
      }
   }
}

