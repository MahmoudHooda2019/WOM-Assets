package wom.controller.event.alliance
{
   import flash.events.Event;
   import wom.model.game.alliance.AllianceDetailInfo;
   
   public class BrowseAllianceEvent extends Event
   {
      
      public static const GENERAL_INFO:String = "generalInfo";
      
      public static const MEMBERS:String = "members";
      
      public static const BACK_TO_ALLIANCES:String = "backToAlliances";
      
      public static const CREATE_ALLIANCE_CLICKED:String = "createAllianceClicked";
      
      private var _alliance:AllianceDetailInfo;
      
      public function BrowseAllianceEvent(param1:String, param2:AllianceDetailInfo)
      {
         super(param1);
         _alliance = param2;
      }
      
      override public function clone() : Event
      {
         return new BrowseAllianceEvent(type,_alliance);
      }
      
      public function get alliance() : AllianceDetailInfo
      {
         return _alliance;
      }
   }
}

