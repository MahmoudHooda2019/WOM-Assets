package wom.view.component
{
   import flash.text.TextFormat;
   import peak.component.PTabButton;
   
   public class WomTabButton extends PTabButton
   {
      
      public static const WIDTH:int = 141;
      
      public static const TAB_BUTTON_STYLES:Object = {
         "upSkin":"upSkin",
         "downSkin":"downSkin",
         "overSkin":"overSkin",
         "disabledSkin":"disabledSkin",
         "selectedUpSkin":"selectedUpSkin",
         "selectedDownSkin":"selectedDownSkin",
         "selectedOverSkin":"selectedOverSkin",
         "selectedDisabledSkin":"selectedDisabledSkin",
         "textFormat":"textFormat",
         "textPadding":"textPadding"
      };
      
      protected var buttonWidth:int;
      
      public function WomTabButton(param1:int = 141)
      {
         buttonWidth = param1;
         super(true);
         this.textField.filters = [WomTextFormats.TAB_FILTER];
      }
      
      override protected function draw() : void
      {
         this.width = selected ? buttonWidth + selectedWidthOffset : buttonWidth;
         super.draw();
         var _loc1_:Number = Number(getStyleValue("textPadding"));
         _loc1_ = selected ? _loc1_ + 8 : _loc1_;
         var _loc2_:Number = textField.textWidth + 4;
         if(_loc2_ != 4)
         {
            while(_loc2_ > 0 && _loc2_ > width - _loc1_ * 2)
            {
               if(textField)
               {
                  textField.defaultTextFormat = new TextFormat(null,int(textField.defaultTextFormat.size) - 1);
               }
               textField.setTextFormat(textField.defaultTextFormat);
               _loc2_ = textField.textWidth + 4;
            }
            drawLayout();
         }
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         textField.y = height - (textField.textHeight + 4) >> 1;
         if(selected)
         {
            this.textField.y += textOffsetY;
         }
      }
      
      protected function get textOffsetY() : int
      {
         return -2;
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         this.width = background.width;
         this.height = background.height;
      }
      
      override protected function drawTextFormat() : void
      {
         super.drawTextFormat();
         this.textField.defaultTextFormat = textFormat;
         this.textField.setTextFormat(textFormat);
      }
      
      protected function get selectedWidthOffset() : int
      {
         return 16;
      }
      
      protected function get textFormat() : TextFormat
      {
         return WomTextFormats.CAPTION_CENTER_20_CONDENSED;
      }
   }
}

