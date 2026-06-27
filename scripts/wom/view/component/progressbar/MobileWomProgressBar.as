package wom.view.component.progressbar
{
   import feathers.core.ITextRenderer;
   import feathers.core.PropertyProxy;
   import feathers.skins.StateWithToggleValueSelector;
   import flash.filters.GlowFilter;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPBitmapFontTextRenderer;
   import peak.component.mobile.MPProgressBar;
   import starling.display.DisplayObject;
   
   public class MobileWomProgressBar extends MPProgressBar
   {
      
      protected var labelTextRenderer:ITextRenderer;
      
      protected var _align:String = "left";
      
      protected var _label:String = null;
      
      protected var _textMarginX:int;
      
      protected var _labelPropertiesSelector:StateWithToggleValueSelector = new StateWithToggleValueSelector();
      
      protected var _backgroundSkinId:String;
      
      protected var _fillSkinId:String;
      
      protected var _fillPadding:int;
      
      protected var _textFormat:MPBitmapFontTextFormat;
      
      protected var _explicitTextWidth:int = -1;
      
      public function MobileWomProgressBar(param1:String, param2:String, param3:int, param4:MPBitmapFontTextFormat, param5:int = -1)
      {
         _backgroundSkinId = param1;
         _fillSkinId = param2;
         _fillPadding = param3;
         _textFormat = param4;
         super();
         _textMarginX = 8;
         _explicitTextWidth = param5;
      }
      
      protected function get captionFilter() : GlowFilter
      {
         return null;
      }
      
      public function get defaultLabelProperties() : Object
      {
         var _loc1_:PropertyProxy = PropertyProxy(this._labelPropertiesSelector.defaultValue);
         if(!_loc1_)
         {
            _loc1_ = new PropertyProxy(childProperties_onChange);
            this._labelPropertiesSelector.defaultValue = _loc1_;
         }
         return _loc1_;
      }
      
      public function set defaultLabelProperties(param1:Object) : void
      {
         if(!(param1 is PropertyProxy))
         {
            param1 = PropertyProxy.fromObject(param1);
         }
         var _loc2_:PropertyProxy = PropertyProxy(this._labelPropertiesSelector.defaultValue);
         if(_loc2_)
         {
            _loc2_.removeOnChangeCallback(childProperties_onChange);
         }
         this._labelPropertiesSelector.defaultValue = param1;
         if(param1)
         {
            PropertyProxy(param1).addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      protected function refreshLabelStyles() : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = this._labelPropertiesSelector.updateValue(this,"up");
         var _loc2_:DisplayObject = DisplayObject(this.labelTextRenderer);
         for(var _loc1_ in _loc4_)
         {
            if(_loc2_.hasOwnProperty(_loc1_))
            {
               _loc3_ = _loc4_[_loc1_];
               _loc2_[_loc1_] = _loc3_;
            }
         }
      }
      
      protected function childProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function createLabel() : void
      {
         if(this.labelTextRenderer)
         {
            this.removeChild(DisplayObject(this.labelTextRenderer),true);
            this.labelTextRenderer = null;
         }
         this.labelTextRenderer = new MPBitmapFontTextRenderer();
         this.labelTextRenderer.nameList.add("feathers-progressbar-label");
         if(_explicitTextWidth != -1)
         {
            this.labelTextRenderer.width = _explicitTextWidth;
         }
         this.addChild(DisplayObject(this.labelTextRenderer));
      }
      
      protected function refreshLabel() : void
      {
         this.labelTextRenderer.text = this._label;
         this.labelTextRenderer.visible = this._label !== null && this._label.length > 0;
         this.labelTextRenderer.isEnabled = this._isEnabled;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         if(this._label == param1)
         {
            return;
         }
         this._label = param1;
         this.invalidate("data");
      }
      
      public function set align(param1:String) : void
      {
         _align = param1;
         invalidate("data");
      }
      
      public function set textMarginX(param1:int) : void
      {
         _textMarginX = param1;
      }
      
      public function get textSize() : int
      {
         return 16;
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = this.isInvalid("textRenderer");
         var _loc3_:Boolean = this.isInvalid("state");
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc2_:Boolean = this.isInvalid("data");
         if(_loc1_)
         {
            this.createLabel();
         }
         if(_loc1_ || _loc3_ || _loc2_)
         {
            this.refreshLabel();
         }
         if(_loc1_ || _loc4_ || _loc3_)
         {
            this.refreshLabelStyles();
         }
         labelTextRenderer.validate();
         labelTextRenderer.x = align == "left" ? _textMarginX : this.width - labelTextRenderer.width >> 1;
         labelTextRenderer.y = this.height - labelTextRenderer.height + 4 >> 1;
      }
      
      public function get backgroundSkinId() : String
      {
         return _backgroundSkinId;
      }
      
      public function get fillSkinId() : String
      {
         return _fillSkinId;
      }
      
      public function get fillPadding() : int
      {
         return _fillPadding;
      }
      
      public function get textFormat() : MPBitmapFontTextFormat
      {
         return _textFormat;
      }
      
      public function get align() : String
      {
         return _align;
      }
   }
}

