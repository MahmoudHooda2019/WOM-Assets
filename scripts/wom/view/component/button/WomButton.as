package wom.view.component.button
{
   import fl.events.ComponentEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.component.PButton;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class WomButton extends PButton
   {
      
      public static const INITIAL_PRESS_TIMER:int = 250;
      
      public static const NORMAL_PRESS_TIMER:int = 50;
      
      public static const SPED_PRESS_TIMER:int = 10;
      
      public static const SPEED_UP_PRESS_COUNT:int = 5;
      
      protected var _buttonTextFormat:TextFormat;
      
      protected var rightTextField:TextField;
      
      protected var _rightLabel:String = "";
      
      public var data:Object;
      
      public function WomButton()
      {
         if(_buttonTextFormat == null)
         {
            _buttonTextFormat = WomTextFormats.CAPTION_16;
         }
         super(true);
         this.height = 39;
         this.textField.width = 0;
         this.textField.height = 0;
      }
      
      public function set rightLabel(param1:String) : void
      {
         _rightLabel = param1;
         if(rightTextField.text != _rightLabel)
         {
            rightTextField.text = _rightLabel;
            dispatchEvent(new ComponentEvent("labelChange"));
         }
         if(_rightLabel == null || _rightLabel == "")
         {
            if(icon != null && contains(icon))
            {
               removeChild(icon);
            }
            icon = null;
         }
         invalidate("size");
         invalidate("styles");
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:TextFormat = null;
         var _loc5_:Number = NaN;
         super.drawLayout();
         var _loc4_:Number = Number(getStyleValue("textPadding"));
         textField.height = textField.textHeight + 4;
         var _loc6_:Number = textField.textWidth + 4;
         var _loc7_:Number = icon == null ? 0 : icon.width + 2 * _loc4_;
         textField.visible = label.length > 0;
         rightTextField.visible = _rightLabel.length > 0;
         var _loc2_:Number = (textField && textField.visible && textField.textWidth > 0 ? textField.textWidth + 4 : 0) + (rightTextField && rightTextField.visible && rightTextField.textWidth > 0 ? rightTextField.textWidth + 4 : 0) + _loc7_;
         if(_loc2_ != _loc7_)
         {
            _loc1_ = textField.defaultTextFormat.size <= 12;
            while(_loc2_ > width - _loc4_ * 2 && !_loc1_)
            {
               _loc3_ = textField.defaultTextFormat;
               _loc3_.size = int(_loc3_.size) - 1;
               textField.defaultTextFormat = _buttonTextFormat = _loc3_;
               textField.setTextFormat(textField.defaultTextFormat);
               if(rightTextField)
               {
                  rightTextField.defaultTextFormat = _loc3_;
                  rightTextField.setTextFormat(rightTextField.defaultTextFormat);
               }
               if(textField.defaultTextFormat.size <= 12)
               {
                  _loc1_ = true;
               }
               _loc2_ = (textField && textField.visible && textField.textWidth > 0 ? textField.textWidth + 4 : 0) + (rightTextField && rightTextField.visible && rightTextField.textWidth > 0 ? rightTextField.textWidth + 4 : 0) + _loc7_;
            }
         }
         if(textField.visible == false || _label == null || _label == "")
         {
            textField.width = 0;
            textField.height = 0;
         }
         else
         {
            _loc5_ = Math.max(0,Math.min(_loc6_,width - _loc7_ - 2 * _loc4_));
            textField.width = _loc5_;
         }
         _loc6_ = rightTextField.textWidth + 4;
         if(rightTextField.visible == false || _rightLabel == null || _rightLabel == "")
         {
            rightTextField.width = 0;
            rightTextField.height = 0;
            textField.x = Math.round((width - (textField.textWidth + 4) - _loc7_) / 2);
            textField.width = textField.textWidth + 4;
         }
         else
         {
            rightTextField.width = _loc6_;
            rightTextField.height = rightTextField.textHeight + 4;
            textField.x = Math.round((width - (textField.textWidth + 4) - _loc7_ - (rightTextField.textWidth + 4)) / 2);
         }
         background.width = width;
         background.height = height;
         textField.y = Math.round((height - textField.height) / 2);
         if(icon != null)
         {
            if((textField.text == null || textField.text == "") && (rightTextField.text == null || rightTextField.text == ""))
            {
               icon.x = (width - icon.width) / 2;
            }
            else if(textField.text == null || textField.text == "")
            {
               icon.x = Math.round((width - (rightTextField.textWidth + 4 + _loc4_ + icon.width)) / 2);
            }
            else
            {
               icon.x = Math.round(textField.x + textField.textWidth + 4 + _loc4_);
            }
            icon.y = (height - icon.height) / 2;
            rightTextField.x = icon.x + icon.width + _loc4_;
            rightTextField.y = textField.y;
         }
         textField.y = (height - textField.textHeight - 4) / 2 << 0;
         rightTextField.y = (height - rightTextField.textHeight - 4) / 2 << 0;
      }
      
      override protected function drawTextFormat() : void
      {
         super.drawTextFormat();
         this.textField.alpha = enabled ? 1 : 0.5;
         this.textField.defaultTextFormat = _buttonTextFormat;
         this.textField.setTextFormat(_buttonTextFormat);
         rightTextField.alpha = enabled ? 1 : 0.5;
         rightTextField.defaultTextFormat = _buttonTextFormat;
         rightTextField.setTextFormat(_buttonTextFormat);
      }
      
      override protected function configUI() : void
      {
         isLivePreview = checkLivePreview();
         var _loc2_:Number = rotation;
         rotation = 0;
         var _loc1_:Number = super.width;
         var _loc3_:Number = super.height;
         super.scaleX = super.scaleY = 1;
         setSize(_loc1_,_loc3_);
         move(super.x,super.y);
         rotation = _loc2_;
         startWidth = _loc1_;
         startHeight = _loc3_;
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         textField = new CaptionTextField(captionFilter);
         textField.type = "dynamic";
         textField.selectable = false;
         addChild(textField);
         rightTextField = new CaptionTextField(captionFilter);
         rightTextField.type = "dynamic";
         rightTextField.selectable = false;
         rightTextField.width = 0;
         rightTextField.height = 0;
         addChild(rightTextField);
      }
      
      public function get rightLabel() : String
      {
         return _rightLabel;
      }
      
      protected function get captionFilter() : GlowFilter
      {
         return null;
      }
   }
}

