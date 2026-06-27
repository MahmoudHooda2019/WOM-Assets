package wom.view.component.progressbar
{
   import fl.core.UIComponent;
   import fl.events.ComponentEvent;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.component.PProgressBar;
   import wom.view.component.CaptionTextField;
   
   public class WomProgressBar extends PProgressBar
   {
      
      protected var _textField:TextField;
      
      protected var _align:String = "left";
      
      protected var _textMarginX:int;
      
      public function WomProgressBar()
      {
         super();
         this.indeterminate = false;
         this.mode = "manual";
         _textMarginX = 8;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _textField = new CaptionTextField(captionFilter);
         _textField.type = "dynamic";
         updateTextFormat();
         _textField.text = "";
         addChild(_textField);
      }
      
      private function updateTextFormat() : void
      {
         var _loc1_:TextFormat = _textField.defaultTextFormat;
         _loc1_.align = _align;
         _loc1_.size = textSize;
         _loc1_.color = 16511189;
         _textField.defaultTextFormat = _loc1_;
      }
      
      protected function get captionFilter() : GlowFilter
      {
         return null;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         var _loc1_:Number = Number(getStyleValue("barPadding"));
         track.height = getStyleValue("trackSkin") as DisplayObject ? (getStyleValue("trackSkin") as DisplayObject).height : 0;
         indeterminateBar.width = 0;
         indeterminateBar.drawNow();
         determinateBar.height = track.height - _loc1_ * 2;
         determinateBar.y = _loc1_;
         _textField.width = width - 16;
         _textField.height = _textField.textHeight == 0 ? determinateBar.height - _loc1_ * 2 : _textField.textHeight + 4;
         _textField.x = _textMarginX;
         _textField.y = determinateBar.y + (determinateBar.height - _textField.height >> 1);
      }
      
      override protected function drawBars() : void
      {
         var _loc2_:DisplayObject = determinateBar;
         var _loc1_:DisplayObject = indeterminateBar;
         determinateBar = getDisplayObjectInstance(getStyleValue("barSkin"));
         addChildAt(determinateBar,1);
         indeterminateBar = getDisplayObjectInstance(getStyleValue("indeterminateBar")) as UIComponent;
         indeterminateBar.setStyle("indeterminateSkin",getStyleValue("indeterminateSkin"));
         addChildAt(indeterminateBar,1);
         if(_loc2_ != null && _loc2_ != determinateBar)
         {
            removeChild(_loc2_);
         }
         if(_loc1_ != null && _loc1_ != determinateBar)
         {
            removeChild(_loc1_);
         }
      }
      
      public function set progressText(param1:String) : void
      {
         if(_textField.text != param1)
         {
            _textField.text = param1;
            dispatchEvent(new ComponentEvent("labelChange"));
         }
         invalidate("size");
         invalidate("styles");
      }
      
      public function set align(param1:String) : void
      {
         _align = param1;
         updateTextFormat();
      }
      
      public function set textMarginX(param1:int) : void
      {
         _textMarginX = param1;
      }
      
      public function get textSize() : int
      {
         return 16;
      }
   }
}

