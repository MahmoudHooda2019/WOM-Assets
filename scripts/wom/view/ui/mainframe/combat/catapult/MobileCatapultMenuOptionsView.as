package wom.view.ui.mainframe.combat.catapult
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCatapultMenuOptionsView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      public var optionViews:Vector.<MobileCatapultMenuOptionView>;
      
      public var type:int;
      
      private var _typeText:String;
      
      private var _typeTextField:MobileCaptionTextField;
      
      private var _background:DisplayObject;
      
      public var catapultMenuView:MobileCatapultMenuView;
      
      public function MobileCatapultMenuOptionsView(param1:MobileCatapultMenuView, param2:int)
      {
         super();
         this.catapultMenuView = param1;
         this.type = param2;
         switch(param2 - 1)
         {
            case 0:
               var _loc3_:String = "ui.mainframe.combat.catapult.lumbersalvo";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case 1:
               var _loc4_:String = "ui.mainframe.combat.catapult.hurlingstones";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 2:
               var _loc5_:String = "ui.mainframe.combat.catapult.mightyrage";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         optionViews = new Vector.<MobileCatapultMenuOptionView>();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc4_:MobileCatapultMenuOptionView = null;
         _background = assetRepository.getDisplayObject("BackgroundTransparentPanel");
         _background.width = 315;
         _background.height = 343;
         addChild(_background);
         _typeTextField = new MobileCaptionTextField();
         _typeTextField.width = _background.width;
         _typeTextField.height = 35;
         _typeTextField.textRendererProperties.textFormat = getCaptionTextFormat(46,"center");
         _typeTextField.text = _typeText;
         addChild(_typeTextField);
         var _loc3_:MobileCatapultMenuOptionView = new MobileCatapultMenuOptionView(this,0);
         optionViews.push(_loc3_);
         addChild(_loc3_);
         var _loc1_:MobileCatapultMenuOptionView = new MobileCatapultMenuOptionView(this,1);
         optionViews.push(_loc1_);
         addChild(_loc1_);
         var _loc2_:MobileCatapultMenuOptionView = new MobileCatapultMenuOptionView(this,2);
         optionViews.push(_loc2_);
         addChild(_loc2_);
         if(type != 1)
         {
            _loc4_ = new MobileCatapultMenuOptionView(this,3);
            optionViews.push(_loc4_);
            addChild(_loc4_);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc3_:int = 0;
         var _loc2_:MobileCatapultMenuOptionView = null;
         var _loc1_:int = 8;
         _background.x = 0;
         _background.y = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(_typeTextField,_background,0,-15);
         MobileAlignmentUtil.alignAccordingToPositionOf(optionViews[0],_background,0,39);
         _loc3_ = 1;
         while(_loc3_ < optionViews.length)
         {
            _loc2_ = optionViews[_loc3_ - 1];
            MobileAlignmentUtil.alignHeightSpecifiedBelowOf(optionViews[_loc3_],_loc2_,_loc1_,_loc2_.visibleHeight);
            _loc3_++;
         }
      }
      
      public function get background() : DisplayObject
      {
         return _background;
      }
   }
}

