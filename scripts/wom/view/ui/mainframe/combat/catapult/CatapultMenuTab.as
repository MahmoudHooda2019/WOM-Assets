package wom.view.ui.mainframe.combat.catapult
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.component.PTextField;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import wom.view.component.WomTextField;
   import wom.view.ui.mainframe.city.tooltip.AttachableTooltipView;
   
   public class CatapultMenuTab extends Sprite implements View
   {
      
      private var _catapultViews:Vector.<CatapultMenuView>;
      
      private var _tooltip:Sprite;
      
      private var tooltipTextField:TextField;
      
      private var _currentTooltipTarget:CatapultMenuView;
      
      public var activeCatapultMenuOptions:CatapultMenuOptionsView;
      
      public function CatapultMenuTab()
      {
         super();
         _catapultViews = new Vector.<CatapultMenuView>();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:CatapultMenuView = new CatapultMenuView(this,1);
         addChild(_loc1_);
         _catapultViews.push(_loc1_);
         var _loc2_:CatapultMenuView = new CatapultMenuView(this,2);
         addChild(_loc2_);
         _catapultViews.push(_loc2_);
         var _loc3_:CatapultMenuView = new CatapultMenuView(this,3);
         addChild(_loc3_);
         _catapultViews.push(_loc3_);
         _tooltip = new Sprite();
         tooltipTextField = new WomTextField();
         drawLayout();
      }
      
      public function fillTooltips() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:PTextField = null;
         var _loc4_:AttachableTooltipView = null;
         for each(var _loc1_ in catapultViews)
         {
            _loc2_ = new Sprite();
            _loc3_ = new WomTextField();
            _loc3_.extraCharWidth = 1.5;
            _loc1_.fillTooltipSprite(_loc2_,_loc3_);
            _loc4_ = new AttachableTooltipView(this,_loc1_,null,null,_loc2_,(_loc1_.visibleWidth - _loc2_.width) / 2,-_loc2_.height + 12);
            _loc1_.setTooltipParameters(_loc4_,_loc2_,_loc3_);
         }
      }
      
      public function showTooltipForView(param1:CatapultMenuView, param2:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(param2 && !param1.catapultMenuOptions.visible)
         {
            _loc3_ = param1.buttonState == 4;
            if(!contains(_tooltip))
            {
               param1.fillTooltipSprite(_tooltip,tooltipTextField);
               addChild(_tooltip);
            }
            _tooltip.x = param1.x + (param1.visibleWidth - _tooltip.width) / 2;
            _tooltip.y = param1.y - _tooltip.height + (_loc3_ ? 12 : 0);
            _currentTooltipTarget = param1;
            tooltipTextField.text = param1.tooltipText;
            _tooltip.visible = true;
         }
         else if(tooltipTextField && _currentTooltipTarget != null && _currentTooltipTarget.resourceType == param1.resourceType)
         {
            tooltipTextField.text = param1.tooltipText;
         }
      }
      
      public function closeTooltip() : void
      {
         _tooltip.visible = false;
         _currentTooltipTarget = null;
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _catapultViews.length)
         {
            if(_loc1_ == 0)
            {
               _catapultViews[_loc1_].x = 6;
               _catapultViews[_loc1_].y = 5;
            }
            else
            {
               AlignmentUtil.alignWidthSpecifiedRightOf(_catapultViews[_loc1_],_catapultViews[_loc1_ - 1],68,0);
            }
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
         _catapultViews = new Vector.<CatapultMenuView>();
      }
      
      public function get catapultViews() : Vector.<CatapultMenuView>
      {
         return _catapultViews;
      }
      
      public function get tooltip() : Sprite
      {
         return _tooltip;
      }
      
      public function get currentTooltipTarget() : CatapultMenuView
      {
         return _currentTooltipTarget;
      }
   }
}

