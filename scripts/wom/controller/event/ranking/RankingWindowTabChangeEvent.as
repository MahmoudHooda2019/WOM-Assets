package wom.controller.event.ranking
{
   import flash.events.Event;
   import starling.display.Sprite;
   
   public class RankingWindowTabChangeEvent extends Event
   {
      
      public static const RANKING_TAB_CHANGED:String = "rankingTabChanged";
      
      private var _activePanel:Sprite;
      
      public function RankingWindowTabChangeEvent(param1:String, param2:Sprite)
      {
         super(param1);
         _activePanel = param2;
      }
      
      override public function clone() : Event
      {
         return new RankingWindowTabChangeEvent(type,_activePanel);
      }
      
      public function get activePanel() : Sprite
      {
         return _activePanel;
      }
   }
}

