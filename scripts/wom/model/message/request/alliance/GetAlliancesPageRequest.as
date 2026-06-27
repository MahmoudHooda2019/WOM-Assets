package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   
   public class GetAlliancesPageRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public static const MOBILE_PAGE_SIZE:int = 50;
      
      private var _sortType:AllianceSortType;
      
      private var _sortDirection:AllianceSortDirection;
      
      private var _pageOrder:int;
      
      private var _myPage:Boolean;
      
      private var _allianceId:Number;
      
      private var _lastPage:Boolean;
      
      private var _pageSize:Object;
      
      public function GetAlliancesPageRequest(param1:AllianceSortType = null, param2:AllianceSortDirection = null, param3:int = 1, param4:Boolean = false, param5:Boolean = false, param6:Number = -1, param7:Object = null)
      {
         super();
         _sortType = param1 != null ? param1 : AllianceSortType.RANK;
         _sortDirection = param2 != null ? param2 : AllianceSortDirection.ASC;
         _pageOrder = param3;
         _myPage = param4;
         _lastPage = param5;
         _allianceId = param6;
         _pageSize = param7;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {
            "sortType":_sortType.id,
            "sortDirection":_sortDirection.value,
            "myPage":_myPage,
            "lastPage":_lastPage,
            "pageSize":_pageSize
         };
         if(_allianceId != -1)
         {
            _loc1_["allianceId"] = _allianceId;
         }
         if(!_myPage)
         {
            _loc1_["pageOrder"] = _pageOrder;
         }
         return _loc1_;
      }
   }
}

