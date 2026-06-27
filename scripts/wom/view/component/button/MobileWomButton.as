package wom.view.component.button
{
   import feathers.core.FeathersControl;
   import feathers.core.IFeathersControl;
   import feathers.core.ITextRenderer;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPBitmapFontTextRenderer;
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import starling.events.EnterFrameEvent;
   import wom.view.getCaptionTextFormat;
   
   public class MobileWomButton extends MPButton
   {
      
      public static const INITIAL_PRESS_TIMER:int = 250;
      
      public static const NORMAL_PRESS_TIMER:int = 50;
      
      public static const SPED_PRESS_TIMER:int = 10;
      
      public static const SPEED_UP_PRESS_COUNT:int = 5;
      
      protected var _yMargin:int;
      
      private var _selectedSkinId:String;
      
      private var _disabledSkinId:String;
      
      private var _iconAndRightLabelMargin:int;
      
      private var _buttonTextFormat:MPBitmapFontTextFormat;
      
      protected var rightLabelTextRenderer:ITextRenderer;
      
      protected var _rightLabel:String = "";
      
      public var data:Object;
      
      private var _style:String;
      
      private var _color:String;
      
      private var _size:String;
      
      private var _disableTruncation:Boolean = false;
      
      public function MobileWomButton(param1:String, param2:String, param3:String, param4:MPBitmapFontTextFormat = null, param5:int = 0, param6:String = null, param7:String = null)
      {
         _selectedSkinId = param6;
         _disabledSkinId = param7;
         _yMargin = param5;
         _style = param1;
         _color = param2;
         _size = param3;
         if(param4 != null)
         {
            _buttonTextFormat = param4;
         }
         if(_buttonTextFormat == null)
         {
            _buttonTextFormat = getCaptionTextFormat(21);
         }
         _iconAndRightLabelMargin = -14;
         super(true);
      }
      
      public function set rightLabel(param1:String) : void
      {
         var _loc2_:String = param1;
         _rightLabel = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_);
         this.invalidate("data");
         if(_rightLabel == null || _rightLabel == "")
         {
            if(currentIcon != null && contains(currentIcon))
            {
               removeChild(currentIcon);
            }
            currentIcon = null;
            this.invalidate("size");
            this.invalidate("styles");
         }
      }
      
      override protected function createLabel() : void
      {
         super.createLabel();
         if(this.rightLabelTextRenderer)
         {
            this.removeChild(DisplayObject(this.rightLabelTextRenderer),true);
            this.rightLabelTextRenderer = null;
         }
         var _loc1_:Function = this._labelFactory != null ? this._labelFactory : FeathersControl.defaultTextRendererFactory;
         this.rightLabelTextRenderer = ITextRenderer(_loc1_());
         this.rightLabelTextRenderer.nameList.add(this.labelName);
         this.addChild(DisplayObject(this.rightLabelTextRenderer));
      }
      
      override protected function refreshLabel() : void
      {
         super.refreshLabel();
         this.rightLabelTextRenderer.text = this._rightLabel;
         this.rightLabelTextRenderer.visible = this._rightLabel && this._rightLabel.length > 0;
      }
      
      override protected function refreshLabelStyles() : void
      {
         var _loc3_:Object = null;
         super.refreshLabelStyles();
         var _loc4_:Object = this._labelPropertiesSelector.updateValue(this,this._currentState);
         var _loc2_:DisplayObject = DisplayObject(this.rightLabelTextRenderer);
         for(var _loc1_ in _loc4_)
         {
            if(_loc2_.hasOwnProperty(_loc1_))
            {
               _loc3_ = _loc4_[_loc1_];
               _loc2_[_loc1_] = _loc3_;
            }
         }
         if(labelTextRenderer && _buttonTextFormat.align == "center")
         {
            labelTextRenderer.width = width;
            labelTextRenderer["wordWrap"] = true;
         }
      }
      
      override protected function layoutContent() : void
      {
         if(_iconPosition != "top")
         {
            if(this.currentIcon is IFeathersControl)
            {
               IFeathersControl(this.currentIcon).validate();
            }
            this.refreshMaxLabelWidth(false);
            if(this._label && this.currentIcon && this._rightLabel)
            {
               this.labelTextRenderer.validate();
               this.rightLabelTextRenderer.validate();
               this.positionLabelAndIcon();
            }
            else if(this._label && this.currentIcon && !this._rightLabel)
            {
               this.labelTextRenderer.validate();
               this.positionLabelAndIcon();
            }
            else if(!this._label && !this._rightLabel && this.currentIcon)
            {
               this.currentIcon.x = width - currentIcon.width >> 1;
               this.currentIcon.y = (height - currentIcon.height) / 2 + (_currentState == "down" ? 3 : 0);
            }
            else if(this._label && !this.currentIcon)
            {
               autoSizeTextRenderers();
               this.labelTextRenderer.validate();
               labelTextRenderer.x = (width - labelTextRenderer.width >> 1) - 3;
               labelTextRenderer.y = (height - labelTextRenderer.height >> 1) + (_currentState == "down" ? 3 : 0);
            }
            else if(this._rightLabel && this.currentIcon)
            {
               this.rightLabelTextRenderer.validate();
               this.positionLabelAndIcon();
            }
            if(this.currentIcon)
            {
               if(this._iconPosition == "manual")
               {
                  this.currentIcon.x = this._paddingLeft;
                  this.currentIcon.y = this._paddingTop;
               }
               this.currentIcon.x += this._iconOffsetX;
               this.currentIcon.y += this._iconOffsetY;
            }
            if(this._label)
            {
               this.labelTextRenderer.x += this._labelOffsetX;
               this.labelTextRenderer.y += this._labelOffsetY;
            }
         }
         else
         {
            autoSizeTextRenderers();
            currentIcon.x = width - currentIcon.width >> 1;
            currentIcon.y = (height - currentIcon.height) / 2 + (_currentState == "down" ? 3 : 0);
            labelTextRenderer.validate();
            labelTextRenderer.x = (width - labelTextRenderer.width >> 1) - 2;
            labelTextRenderer.y = (height - labelTextRenderer.height) / 2 + (_currentState == "down" ? 3 : 0) + _yMargin;
         }
      }
      
      override protected function refreshMaxLabelWidth(param1:Boolean) : void
      {
         var _loc2_:Number = this.actualWidth;
         if(param1)
         {
            _loc2_ = isNaN(this.explicitWidth) ? this._maxWidth : this.explicitWidth;
         }
         var _loc3_:Number = this._gap == Infinity ? Math.min(this._paddingLeft,this._paddingRight) : this._gap;
         if(_disableTruncation)
         {
            this.labelTextRenderer.maxWidth = this.rightLabelTextRenderer.maxWidth = Infinity;
         }
         else if(this._label && this.currentIcon && this._rightLabel)
         {
            if(this._iconPosition == "left" || this._iconPosition == "leftBaseline" || this._iconPosition == "right" || this._iconPosition == "rightBaseline")
            {
               this.labelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight - this.currentIcon.width - _loc3_;
               this.rightLabelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight - this.currentIcon.width - _loc3_;
            }
            else
            {
               this.labelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight;
               this.rightLabelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight;
            }
         }
         else if(this.currentIcon && this._rightLabel)
         {
            if(this._iconPosition == "left" || this._iconPosition == "leftBaseline" || this._iconPosition == "right" || this._iconPosition == "rightBaseline")
            {
               this.rightLabelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight - this.currentIcon.width - _loc3_ - iconAndRightLabelMargin;
            }
            else
            {
               this.rightLabelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight;
            }
         }
         else if(this._label && !this.currentIcon)
         {
            this.labelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight;
         }
      }
      
      override protected function positionLabelAndIcon() : void
      {
         var _loc1_:Number = this._paddingLeft;
         var _loc3_:Number = Number(currentIcon == null ? 0 : currentIcon.width + 2 * _loc1_ + (rightLabelTextRenderer.visible ? _iconAndRightLabelMargin : 0));
         autoSizeTextRenderers();
         if(labelTextRenderer.visible == false || _label == null || _label == "")
         {
            labelTextRenderer.width = 0;
            labelTextRenderer.height = 0;
         }
         var _loc2_:Number = Number(rightLabelTextRenderer.width);
         if(rightLabelTextRenderer.visible == false || _rightLabel == null || _rightLabel == "")
         {
            rightLabelTextRenderer.width = 0;
            rightLabelTextRenderer.height = 0;
            labelTextRenderer.x = Math.round((width - labelTextRenderer.width - _loc3_) / 2);
            labelTextRenderer.width = labelTextRenderer.width;
         }
         else
         {
            rightLabelTextRenderer.width = _loc2_ >> 0;
            rightLabelTextRenderer.height = rightLabelTextRenderer.height;
            labelTextRenderer.x = Math.round((width - labelTextRenderer.width - _loc3_ - (rightLabelTextRenderer as MPBitmapFontTextRenderer).characterBatchWidth) / 2) + (currentIcon != null && Boolean(rightLabelTextRenderer.visible) ? -iconAndRightLabelMargin >> 1 : 0);
         }
         labelTextRenderer.y = Math.round((height - labelTextRenderer.height) / 2) + (_currentState == "down" ? 3 : 0) + _yMargin;
         if(currentIcon != null)
         {
            if((labelTextRenderer.text == null || labelTextRenderer.text == "") && (rightLabelTextRenderer.text == null || rightLabelTextRenderer.text == ""))
            {
               currentIcon.x = (width - currentIcon.width) / 2;
            }
            else if(labelTextRenderer.text == null || labelTextRenderer.text == "")
            {
               currentIcon.x = Math.round((width - (rightLabelTextRenderer.width + _loc1_ + currentIcon.width)) / 2 - (_iconAndRightLabelMargin >> 1));
            }
            else
            {
               currentIcon.x = Math.round(labelTextRenderer.x + labelTextRenderer.width + _loc1_);
            }
            currentIcon.y = (height - currentIcon.height + _loc1_ >> 1) + (_currentState == "down" ? 3 : 0) + _yMargin;
            rightLabelTextRenderer.x = currentIcon.x + currentIcon.width + _iconAndRightLabelMargin;
            rightLabelTextRenderer.y = labelTextRenderer.y;
         }
         labelTextRenderer.y = (height - labelTextRenderer.height + 2 * _loc1_ >> 1) + (_currentState == "down" ? 3 : 0) + _yMargin;
         if(!labelTextRenderer.visible)
         {
            rightLabelTextRenderer.y = (height - rightLabelTextRenderer.height + 2 * _loc1_ >> 1) + (_currentState == "down" ? 3 : 0) + _yMargin;
         }
         else
         {
            rightLabelTextRenderer.y = labelTextRenderer.y;
         }
         if(_iconPosition == "top")
         {
            currentIcon.y = (height - currentIcon.height) / 2 + (_currentState == "down" ? 3 : 0);
            labelTextRenderer.y += _yMargin + (_currentState == "down" ? 3 : 0);
         }
      }
      
      protected function autoSizeTextRenderers() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Boolean = false;
         var _loc3_:MPBitmapFontTextFormat = null;
         var _loc4_:Number = this._paddingLeft;
         var _loc5_:Number = determinePaddedIconWidth();
         if(labelTextRenderer.width == 0 && (labelTextRenderer.text != "" || labelTextRenderer.text != null))
         {
            addEventListener("enterFrame",onEnterFrame);
         }
         labelTextRenderer.visible = label.length > 0;
         rightLabelTextRenderer.visible = _rightLabel.length > 0;
         _loc2_ = (labelTextRenderer && labelTextRenderer.visible && labelTextRenderer.width > 0 ? (labelTextRenderer as MPBitmapFontTextRenderer).characterBatchWidth : 0) + (rightLabelTextRenderer && rightLabelTextRenderer.visible && rightLabelTextRenderer.width > 0 ? (rightLabelTextRenderer as MPBitmapFontTextRenderer).characterBatchWidth : 0) + _loc5_;
         if(_loc2_ != _loc5_)
         {
            _loc1_ = defaultLabelProperties.textFormat.size <= 16;
            while(_loc2_ > width - _loc4_ * 2 + 4 && !_loc1_)
            {
               _loc3_ = defaultLabelProperties.textFormat;
               _loc3_ = getCaptionTextFormat(_loc3_.size - 1,_loc3_.align,_loc3_.color);
               defaultLabelProperties.textFormat = _buttonTextFormat = _loc3_;
               refreshLabelStyles();
               labelTextRenderer.validate();
               rightLabelTextRenderer.validate();
               if(defaultLabelProperties.textFormat.size <= 16)
               {
                  _loc1_ = true;
               }
               _loc2_ = (labelTextRenderer && labelTextRenderer.visible && labelTextRenderer.width > 0 ? (labelTextRenderer as MPBitmapFontTextRenderer).characterBatchWidth : 0) + (rightLabelTextRenderer && rightLabelTextRenderer.visible && rightLabelTextRenderer.width > 0 ? (rightLabelTextRenderer as MPBitmapFontTextRenderer).characterBatchWidth : 0) + _loc5_;
            }
         }
      }
      
      override public function set label(param1:String) : void
      {
         var _loc2_:String = param1;
         super.label = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_);
      }
      
      private function onEnterFrame(param1:EnterFrameEvent) : void
      {
         removeEventListener("enterFrame",onEnterFrame);
         layoutContent();
      }
      
      protected function determinePaddedIconWidth() : Number
      {
         return currentIcon == null || _iconPosition == "top" ? 0 : currentIcon.width + (labelTextRenderer.visible ? this._paddingLeft : 0) + (rightLabelTextRenderer.visible ? _iconAndRightLabelMargin : 0);
      }
      
      public function get rightLabel() : String
      {
         return _rightLabel;
      }
      
      public function get yMargin() : int
      {
         return _yMargin;
      }
      
      public function set yMargin(param1:int) : void
      {
         _yMargin = param1;
      }
      
      public function get color() : String
      {
         return _color;
      }
      
      public function get size() : String
      {
         return _size;
      }
      
      public function get buttonTextFormat() : MPBitmapFontTextFormat
      {
         return _buttonTextFormat;
      }
      
      public function set buttonTextFormat(param1:MPBitmapFontTextFormat) : void
      {
         _buttonTextFormat = param1;
         defaultLabelProperties.textFormat = _buttonTextFormat;
         invalidate("textRenderer");
      }
      
      public function get style() : String
      {
         return _style;
      }
      
      public function get iconAndRightLabelMargin() : int
      {
         return _iconAndRightLabelMargin;
      }
      
      public function set iconAndRightLabelMargin(param1:int) : void
      {
         _iconAndRightLabelMargin = param1;
      }
      
      public function get selectedSkinId() : String
      {
         return _selectedSkinId;
      }
      
      public function get disabledSkinId() : String
      {
         return _disabledSkinId;
      }
      
      public function get disableTruncation() : Boolean
      {
         return _disableTruncation;
      }
      
      public function set disableTruncation(param1:Boolean) : void
      {
         _disableTruncation = param1;
      }
   }
}

