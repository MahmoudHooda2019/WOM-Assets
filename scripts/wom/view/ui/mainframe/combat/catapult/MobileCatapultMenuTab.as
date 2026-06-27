package wom.view.ui.mainframe.combat.catapult
{
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   
   public class MobileCatapultMenuTab extends Sprite implements View
   {
      
      private var _catapultViews:Vector.<MobileCatapultMenuView>;
      
      public var activeCatapultMenuOptions:MobileCatapultMenuOptionsView;
      
      public function MobileCatapultMenuTab()
      {
         super();
         _catapultViews = new Vector.<MobileCatapultMenuView>();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:MobileCatapultMenuView = new MobileCatapultMenuView(this,1);
         addChild(_loc1_);
         _catapultViews.push(_loc1_);
         var _loc2_:MobileCatapultMenuView = new MobileCatapultMenuView(this,2);
         addChild(_loc2_);
         _catapultViews.push(_loc2_);
         var _loc3_:MobileCatapultMenuView = new MobileCatapultMenuView(this,3);
         addChild(_loc3_);
         _catapultViews.push(_loc3_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _catapultViews.length)
         {
            if(_loc1_ == 0)
            {
               _catapultViews[_loc1_].x = 13;
               _catapultViews[_loc1_].y = 10;
            }
            else
            {
               MobileAlignmentUtil.alignWidthSpecifiedRightOf(_catapultViews[_loc1_],_catapultViews[_loc1_ - 1],97,0);
            }
            _catapultViews[_loc1_].catapultMenuOptions.x = -_catapultViews[_loc1_].x;
            _catapultViews[_loc1_].catapultMenuOptions.y = -_catapultViews[_loc1_].catapultMenuOptions.background.height - 13;
            _loc1_++;
         }
      }
      
      public function clearCatapults() : void
      {
         if(_catapultViews)
         {
            while(_catapultViews.length > 0)
            {
               removeChild(_catapultViews.pop());
            }
         }
         _catapultViews = new Vector.<MobileCatapultMenuView>();
      }
      
      public function get catapultViews() : Vector.<MobileCatapultMenuView>
      {
         return _catapultViews;
      }
   }
}

