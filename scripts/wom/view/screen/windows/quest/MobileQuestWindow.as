package wom.view.screen.windows.quest
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileQuestWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 820;
      
      private static const WINDOW_HEIGHT:int = 538;
      
      private var _questViews:Vector.<MobileQuestRowView>;
      
      public function MobileQuestWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(820,538,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.quest.mobileheader";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _questViews = new Vector.<MobileQuestRowView>();
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < _questViews.length)
         {
            if(_loc2_ == 0)
            {
               _questViews[_loc2_].x = 37;
               _questViews[_loc2_].y = 49;
            }
            else
            {
               MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_questViews[_loc2_],_loc1_,14,143);
            }
            _loc1_ = _questViews[_loc2_];
            _loc2_++;
         }
      }
      
      public function updateWithQuests(param1:Vector.<QuestInfo>, param2:int = 3) : void
      {
         var _loc4_:MobileQuestRowView = null;
         var _loc3_:int = 0;
         clearQuests();
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = new MobileQuestRowView(param1[_loc3_]);
            addChild(_loc4_);
            _questViews.push(_loc4_);
            _loc3_++;
         }
         drawLayout();
      }
      
      private function clearQuests() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _questViews.length)
         {
            if(contains(_questViews[_loc1_]))
            {
               removeChild(_questViews[_loc1_]);
            }
            _loc1_++;
         }
         _questViews.splice(0,_questViews.length);
      }
      
      public function get questViews() : Vector.<MobileQuestRowView>
      {
         return _questViews;
      }
   }
}

