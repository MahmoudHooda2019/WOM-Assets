package wom.view.ui.mainframe.combat.catapult
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class CatapultMenuOptionsView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public var optionViews:Vector.<CatapultMenuOptionView>;
      
      public var type:int;
      
      private var _typeText:String;
      
      private var _typeTextField:CaptionTextField;
      
      private var _background:DisplayObject;
      
      public var catapultMenuView:CatapultMenuView;
      
      public function CatapultMenuOptionsView(param1:CatapultMenuView, param2:int)
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
         optionViews = new Vector.<CatapultMenuOptionView>();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc4_:CatapultMenuOptionView = null;
         _background = assetRepository.getDisplayObject("AvatarBackgroundSkin");
         _background.width = 129;
         _background.height = 174;
         addChild(_background);
         _typeTextField = new CaptionTextField();
         _typeTextField.width = _background.width;
         _typeTextField.height = 25;
         _typeTextField.defaultTextFormat = WomTextFormats.CENTER_20;
         _typeTextField.text = _typeText;
         addChild(_typeTextField);
         var _loc3_:CatapultMenuOptionView = new CatapultMenuOptionView(this,0);
         optionViews.push(_loc3_);
         addChild(_loc3_);
         var _loc1_:CatapultMenuOptionView = new CatapultMenuOptionView(this,1);
         optionViews.push(_loc1_);
         addChild(_loc1_);
         var _loc2_:CatapultMenuOptionView = new CatapultMenuOptionView(this,2);
         optionViews.push(_loc2_);
         addChild(_loc2_);
         if(type != 1)
         {
            _loc4_ = new CatapultMenuOptionView(this,3);
            optionViews.push(_loc4_);
            addChild(_loc4_);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc3_:int = 0;
         var _loc2_:CatapultMenuOptionView = null;
         var _loc1_:int = 2;
         _background.x = 0;
         _background.y = 0;
         AlignmentUtil.alignAccordingToPositionOf(_typeTextField,_background,0,-12);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(optionViews[0],_background,8);
         _loc3_ = 1;
         while(_loc3_ < optionViews.length)
         {
            _loc2_ = optionViews[_loc3_ - 1];
            AlignmentUtil.alignHeightSpecifiedBelowOf(optionViews[_loc3_],_loc2_,_loc1_,_loc2_.visibleHeight);
            _loc3_++;
         }
      }
      
      public function get background() : DisplayObject
      {
         return _background;
      }
   }
}

