package wom.view.ui.mainframe.city
{
   import peak.display.View;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.resource.ResourceType;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileResourcePanel extends FlatteningSprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var background:DisplayObject;
      
      private var _resourceBars:Array;
      
      protected var _combatMode:Boolean;
      
      private var _hideBackground:Boolean;
      
      private var ongoingResourceBarAnimationCount:int;
      
      private var _addResourceAction:Function;
      
      public function MobileResourcePanel(param1:Boolean, param2:Boolean = false, param3:Function = null)
      {
         super();
         _combatMode = param1;
         _hideBackground = param2;
         _addResourceAction = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         ongoingResourceBarAnimationCount = 0;
         background = assetRepository.getDisplayObject("BackgroundYellowPanel");
         background.width = 558;
         background.height = 45;
         background.visible = !_hideBackground;
         addChild(background);
         _resourceBars = [];
         addResourceBar(ResourceType.LUMBER);
         addResourceBar(ResourceType.STONE);
         addResourceBar(ResourceType.IRON);
         addResourceBar(ResourceType.MIGHT);
         drawLayout();
      }
      
      protected function addResourceBar(param1:ResourceType) : void
      {
         var _loc2_:MobileResourceBar = new MobileResourceBar(param1,_combatMode,_addResourceAction);
         addChild(_loc2_);
         _resourceBars[param1.id] = _loc2_;
      }
      
      public function drawLayout() : void
      {
         var _loc3_:Boolean = true;
         var _loc2_:DisplayObject = null;
         for each(var _loc1_ in _resourceBars)
         {
            if(_loc3_)
            {
               _loc3_ = false;
               _loc1_.x = 8;
               _loc1_.y = 4;
            }
            else
            {
               MobileAlignmentUtil.alignRightOf(_loc1_,_loc2_,8);
            }
            _loc2_ = _loc1_;
         }
      }
      
      public function updateWithResourceInfo(param1:Array, param2:int, param3:GameModeType, param4:Boolean) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:MobileResourceBar = null;
         unflatten();
         ongoingResourceBarAnimationCount = 0;
         for each(var _loc7_ in ResourceType.resourceTypes)
         {
            _loc6_ = Number(param3 == GameModeType.ATTACK || param3 == GameModeType.TUSK_HORN ? param1[_loc7_.id] + 1 : param2 / 4);
            _loc5_ = _resourceBars[_loc7_.id] as MobileResourceBar;
            _loc5_.updateWithResourceAmount(param1[_loc7_.id],_loc6_,param4);
            if(_loc5_.ongoingAnimation)
            {
               ongoingResourceBarAnimationCount = ongoingResourceBarAnimationCount + 1;
            }
         }
         if(ongoingResourceBarAnimationCount == 0)
         {
            drawLayout();
            flatten();
         }
      }
      
      public function updateScreenMode(param1:Boolean) : void
      {
         for each(var _loc2_ in _resourceBars)
         {
            _loc2_.updateScreenMode(param1);
         }
      }
      
      public function animationCompletedForResourceBar() : void
      {
         if(--ongoingResourceBarAnimationCount <= 0)
         {
            flatten();
         }
      }
      
      public function get visibleWidth() : int
      {
         return background.width;
      }
      
      public function get resourceBars() : Array
      {
         return _resourceBars;
      }
   }
}

