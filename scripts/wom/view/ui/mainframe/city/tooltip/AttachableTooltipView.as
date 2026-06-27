package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class AttachableTooltipView extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _targetObject:DisplayObject;
      
      private var _tooltipText:String;
      
      private var _tooltipView:Sprite;
      
      private var _tooltipTextField:TextField;
      
      private var _tooltipBG:DisplayObject;
      
      private var _tooltipPin:DisplayObject;
      
      private var _tooltipTextFormat:TextFormat;
      
      private var _manageInsideTooltip:Boolean;
      
      private var _addToSprite:Sprite;
      
      private var _maxWidth:int = 200;
      
      private var _xMargin:int;
      
      private var _yMargin:int;
      
      public function AttachableTooltipView(param1:Sprite, param2:DisplayObject, param3:String, param4:TextFormat = null, param5:Sprite = null, param6:int = 0, param7:int = 0)
      {
         super();
         _targetObject = param2;
         _xMargin = param6;
         _yMargin = param7;
         _tooltipText = param3;
         _tooltipView = param5;
         _tooltipTextFormat = param4;
         _addToSprite = param1;
         param1.addChild(this);
      }
      
      [PostConstruct]
      public function initLayout() : void
      {
         if(!_tooltipView)
         {
            _tooltipView = new Sprite();
            _tooltipBG = assetRepository.getDisplayObject("TooltipBackgroundSkin");
            _tooltipView.addChild(_tooltipBG);
            _tooltipPin = assetRepository.getDisplayObject("TooltipsBottomPin");
            _tooltipView.addChild(_tooltipPin);
            _manageInsideTooltip = true;
            if(!_tooltipTextFormat)
            {
               _tooltipTextFormat = WomTextFormats.CENTER_16;
            }
            _tooltipTextField = new WomTextField();
            _tooltipTextField.autoSize = "left";
            _tooltipTextField.defaultTextFormat = _tooltipTextFormat;
            _tooltipTextField.multiline = true;
            _tooltipTextField.wordWrap = true;
            _tooltipTextField.width = _maxWidth;
            _tooltipTextField.text = _tooltipText;
            _tooltipView.addChild(_tooltipTextField);
         }
         else
         {
            _manageInsideTooltip = false;
         }
         _tooltipView.visible = false;
         addChild(_tooltipView);
         tabEnabled = false;
         drawLayout();
      }
      
      public function updateTooltipAlignmentAccordingToObject(param1:int, param2:int) : void
      {
         _xMargin = param1;
         _yMargin = param2;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(this,_targetObject,_xMargin,_yMargin);
         if(_manageInsideTooltip)
         {
            _tooltipBG.width = int(_tooltipTextField.width + 10);
            _tooltipBG.height = int(_tooltipTextField.height + 12);
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_tooltipPin,_tooltipBG,_tooltipBG.height + 5 - _tooltipPin.height);
            AlignmentUtil.alignAccordingToPositionOf(_tooltipTextField,_tooltipBG,2,5);
         }
      }
      
      public function updateTooltipVisibility(param1:Boolean) : void
      {
         _tooltipView.visible = param1;
      }
      
      public function updateEnablingOfTooltip(param1:Boolean) : void
      {
         if(!param1)
         {
            if(_addToSprite && _addToSprite.contains(this))
            {
               updateTooltipVisibility(false);
               _addToSprite.removeChild(this);
            }
         }
         else if(_addToSprite && !_addToSprite.contains(this))
         {
            _addToSprite.addChild(this);
         }
      }
      
      public function get targetObject() : DisplayObject
      {
         return _targetObject;
      }
      
      public function get tooltipView() : Sprite
      {
         return _tooltipView;
      }
      
      public function updateDisplayObject(param1:DisplayObject) : void
      {
         _targetObject = param1;
         dispatchEvent(new Event("change"));
         drawLayout();
      }
      
      public function set tooltipText(param1:String) : void
      {
         _tooltipText = param1;
         _tooltipTextField.text = _tooltipText;
         drawLayout();
      }
      
      public function set tooltipView(param1:Sprite) : void
      {
         _tooltipView = param1;
      }
   }
}

