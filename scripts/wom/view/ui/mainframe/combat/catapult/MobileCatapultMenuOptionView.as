package wom.view.ui.mainframe.combat.catapult
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileCatapultMenuOptionView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _type:int;
      
      private var _size:int;
      
      private var _cost:int;
      
      private var _sizeText:String;
      
      private var _catapultAssetName:String;
      
      private var _resourceAssetName:String;
      
      private var _image:DisplayObject;
      
      private var _button:MobileWomButton;
      
      public var optionsWindow:MobileCatapultMenuOptionsView;
      
      private var _available:Boolean = true;
      
      public function MobileCatapultMenuOptionView(param1:MobileCatapultMenuOptionsView, param2:int)
      {
         super();
         this.optionsWindow = param1;
         this._type = param1.type;
         this._size = param2;
         switch(_type - 1)
         {
            case 0:
               _catapultAssetName = "LumberSalvo";
               _resourceAssetName = "ResourceIconLumber";
               break;
            case 1:
               _catapultAssetName = "HurlingStone";
               _resourceAssetName = "ResourceIconStone";
               break;
            case 2:
               _catapultAssetName = "MightyRage";
               _resourceAssetName = "ResourceIconMight";
         }
         switch(param2)
         {
            case 0:
               var _loc3_:String = "ui.mainframe.combat.catapult.small";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               _catapultAssetName += "1";
               break;
            case 1:
               var _loc4_:String = "ui.mainframe.combat.catapult.medium";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               _catapultAssetName += "2";
               break;
            case 2:
               var _loc5_:String = "ui.mainframe.combat.catapult.large";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               _catapultAssetName += "3";
               break;
            case 3:
               var _loc6_:String = "ui.mainframe.combat.catapult.huge";
               _sizeText = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               _catapultAssetName += "4";
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
         _button.isEnabled = false;
         _available = false;
      }
      
      public function initLayout() : void
      {
         _image = assetRepository.getDisplayObject(_catapultAssetName);
         addChild(_image);
         _button = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _button.defaultIcon = assetRepository.getDisplayObject(_resourceAssetName);
         _button.width = 225;
         addChild(_button);
         _button.label = _sizeText;
         _button.rightLabel = "";
         drawLayout();
      }
      
      public function updateCost(param1:int) : void
      {
         this._cost = param1;
         _button.rightLabel = NumberUtil.prettyFormat(param1,null,null,null,3,11);
      }
      
      public function drawLayout() : void
      {
         _image.x = 2 + (76 - _image.width >> 1);
         _image.y = _button.height - _image.height >> 1;
         _button.x = 78;
      }
      
      public function get visibleHeight() : Number
      {
         return _button.height;
      }
      
      public function get image() : DisplayObject
      {
         return _image;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get size() : int
      {
         return _size;
      }
      
      public function get cost() : int
      {
         return _cost;
      }
      
      public function get available() : Boolean
      {
         return _available;
      }
      
      public function get button() : MobileWomButton
      {
         return _button;
      }
   }
}

