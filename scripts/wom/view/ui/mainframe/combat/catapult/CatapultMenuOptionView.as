package wom.view.ui.mainframe.combat.catapult
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueSmallButton;
   
   public class CatapultMenuOptionView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public var type:int;
      
      public var size:int;
      
      public var cost:int;
      
      private var _sizeText:String;
      
      private var _assetName:String;
      
      private var _background:DisplayObject;
      
      private var _image:DisplayObject;
      
      private var _button:Button;
      
      private var _sizeTextField:TextField;
      
      private var _costTextField:TextField;
      
      private const _imagePlaceHolder:int = 47;
      
      public var optionsWindow:CatapultMenuOptionsView;
      
      public var available:Boolean = true;
      
      public function CatapultMenuOptionView(param1:CatapultMenuOptionsView, param2:int)
      {
         super();
         this.optionsWindow = param1;
         this.type = param1.type;
         this.size = param2;
         switch(type - 1)
         {
            case 0:
               _assetName = "LumberSalvo";
               break;
            case 1:
               _assetName = "StoneBomb";
               break;
            case 2:
               _assetName = "MightyBoost";
         }
         switch(param2)
         {
            case 0:
               var _loc3_:String = "ui.mainframe.combat.catapult.small";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               _assetName += "Small";
               break;
            case 1:
               var _loc4_:String = "ui.mainframe.combat.catapult.medium";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               _assetName += "Medium";
               break;
            case 2:
               var _loc5_:String = "ui.mainframe.combat.catapult.large";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               _assetName += "Large";
               break;
            case 3:
               var _loc6_:String = "ui.mainframe.combat.catapult.huge";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               _assetName += "Xlarge";
         }
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function disable() : void
      {
         image.alpha = 0.5;
         sizeTextField.alpha = 0.5;
         costTextField.alpha = 0.5;
         background.alpha = 0.5;
         available = false;
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("TooltipInnerBackground");
         _background.width = 115;
         _background.height = 38;
         addChild(_background);
         _image = assetRepository.getDisplayObject(_assetName);
         addChild(_image);
         _button = new WomBlueSmallButton();
         _button.width = 65;
         _button.label = "";
         addChild(_button);
         _sizeTextField = new WomTextField();
         _sizeTextField.width = 65;
         _sizeTextField.height = 15;
         _sizeTextField.defaultTextFormat = WomTextFormats.CENTER_14;
         _sizeTextField.text = _sizeText;
         _button.addChild(_sizeTextField);
         _costTextField = new CaptionTextField(WomTextFormats.BLUE_BUTTON_FILTER);
         _costTextField.width = 65;
         _costTextField.height = 15;
         _costTextField.defaultTextFormat = WomTextFormats.CENTER_16;
         _button.addChild(_costTextField);
         drawLayout();
      }
      
      public function updateCost(param1:int) : void
      {
         this.cost = param1;
         _costTextField.text = NumberUtil.prettyFormat(param1,null,null,null,3,11);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_image,_background,(47 - _image.width) / 2);
         AlignmentUtil.alignAccordingToPositionOf(_button,_background,47,4);
         _sizeTextField.y = -1;
         _costTextField.y = 11;
      }
      
      public function get visibleHeight() : Number
      {
         return _background.height;
      }
      
      public function get background() : DisplayObject
      {
         return _background;
      }
      
      public function get image() : DisplayObject
      {
         return _image;
      }
      
      public function get sizeTextField() : TextField
      {
         return _sizeTextField;
      }
      
      public function get costTextField() : TextField
      {
         return _costTextField;
      }
   }
}

