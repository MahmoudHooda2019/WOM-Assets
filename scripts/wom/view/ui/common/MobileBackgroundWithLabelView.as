package wom.view.ui.common
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileBackgroundWithLabelView extends Sprite implements View
   {
      
      private var visibleWidth:int;
      
      private var visibleHeight:int;
      
      private var background:DisplayObject;
      
      private var textField:MPTextField;
      
      private var _text:String;
      
      public function MobileBackgroundWithLabelView(param1:int, param2:int, param3:String, param4:DisplayObject)
      {
         super();
         this.background = param4;
         this.visibleWidth = param1;
         this.visibleHeight = param2;
         this._text = param3;
         init();
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background.width = visibleWidth;
         background.height = visibleHeight;
         addChild(background);
         textField = new MobileWomTextField();
         textField.textRendererProperties.textFormat = getWomTextFormat(21,"center",16777215);
         textField.width = background.width;
         addChild(textField);
         textField.text = _text;
      }
      
      public function drawLayout() : void
      {
         textField.validate();
         MobileAlignmentUtil.alignMiddleYAxisOf(textField,background);
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
         textField.text = _text;
         drawLayout();
      }
   }
}

