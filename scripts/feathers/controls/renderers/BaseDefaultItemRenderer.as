package feathers.controls.renderers
{
   import feathers.controls.Button;
   import feathers.controls.ImageLoader;
   import feathers.controls.Scroller;
   import feathers.controls.text.BitmapFontTextRenderer;
   import feathers.core.FeathersControl;
   import feathers.core.IFeathersControl;
   import feathers.core.ITextRenderer;
   import feathers.core.PropertyProxy;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class BaseDefaultItemRenderer extends Button
   {
      
      public static const DEFAULT_CHILD_NAME_ACCESSORY_LABEL:String = "feathers-item-renderer-accessory-label";
      
      public static const ACCESSORY_POSITION_TOP:String = "top";
      
      public static const ACCESSORY_POSITION_RIGHT:String = "right";
      
      public static const ACCESSORY_POSITION_BOTTOM:String = "bottom";
      
      public static const ACCESSORY_POSITION_LEFT:String = "left";
      
      public static const ACCESSORY_POSITION_MANUAL:String = "manual";
      
      public static const LAYOUT_ORDER_LABEL_ACCESSORY_ICON:String = "labelAccessoryIcon";
      
      public static const LAYOUT_ORDER_LABEL_ICON_ACCESSORY:String = "labelIconAccessory";
      
      protected static var DOWN_STATE_DELAY_MS:int = 250;
      
      private static const HELPER_POINT:Point = new Point();
      
      protected var accessoryLabelName:String = "feathers-item-renderer-accessory-label";
      
      protected var iconImage:ImageLoader;
      
      protected var accessoryImage:ImageLoader;
      
      protected var accessoryLabel:ITextRenderer;
      
      protected var accessory:DisplayObject;
      
      protected var _data:Object;
      
      protected var _owner:Scroller;
      
      protected var _delayedCurrentState:String;
      
      protected var _stateDelayTimer:Timer;
      
      protected var _useStateDelayTimer:Boolean = true;
      
      protected var isSelectableWithoutToggle:Boolean = true;
      
      protected var _itemHasLabel:Boolean = true;
      
      protected var _itemHasIcon:Boolean = true;
      
      protected var _itemHasAccessory:Boolean = true;
      
      protected var _accessoryPosition:String = "right";
      
      protected var _layoutOrder:String = "labelIconAccessory";
      
      protected var _accessoryOffsetX:Number = 0;
      
      protected var _accessoryOffsetY:Number = 0;
      
      protected var _accessoryGap:Number = NaN;
      
      protected var accessoryTouchPointID:int = -1;
      
      protected var _stopScrollingOnAccessoryTouch:Boolean = true;
      
      protected var _delayTextureCreationOnScroll:Boolean = false;
      
      protected var _labelField:String = "label";
      
      protected var _labelFunction:Function;
      
      protected var _iconField:String = "icon";
      
      protected var _iconFunction:Function;
      
      protected var _iconSourceField:String = "iconSource";
      
      protected var _iconSourceFunction:Function;
      
      protected var _accessoryField:String = "accessory";
      
      protected var _accessoryFunction:Function;
      
      protected var _accessorySourceField:String = "accessorySource";
      
      protected var _accessorySourceFunction:Function;
      
      protected var _accessoryLabelField:String = "accessoryLabel";
      
      protected var _accessoryLabelFunction:Function;
      
      protected var _iconLoaderFactory:Function = defaultLoaderFactory;
      
      protected var _accessoryLoaderFactory:Function = defaultLoaderFactory;
      
      protected var _accessoryLabelFactory:Function;
      
      protected var _accessoryLabelProperties:PropertyProxy;
      
      protected var _ignoreAccessoryResizes:Boolean = false;
      
      public function BaseDefaultItemRenderer()
      {
         super();
         this.isFocusEnabled = false;
         this.isQuickHitAreaEnabled = false;
         this.addEventListener("triggered",itemRenderer_triggeredHandler);
      }
      
      protected static function defaultLoaderFactory() : ImageLoader
      {
         return new ImageLoader();
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         this.invalidate("data");
      }
      
      public function get useStateDelayTimer() : Boolean
      {
         return this._useStateDelayTimer;
      }
      
      public function set useStateDelayTimer(param1:Boolean) : void
      {
         this._useStateDelayTimer = param1;
      }
      
      public function get itemHasLabel() : Boolean
      {
         return this._itemHasLabel;
      }
      
      public function set itemHasLabel(param1:Boolean) : void
      {
         if(this._itemHasLabel == param1)
         {
            return;
         }
         this._itemHasLabel = param1;
         this.invalidate("data");
      }
      
      public function get itemHasIcon() : Boolean
      {
         return this._itemHasIcon;
      }
      
      public function set itemHasIcon(param1:Boolean) : void
      {
         if(this._itemHasIcon == param1)
         {
            return;
         }
         this._itemHasIcon = param1;
         this.invalidate("data");
      }
      
      public function get itemHasAccessory() : Boolean
      {
         return this._itemHasAccessory;
      }
      
      public function set itemHasAccessory(param1:Boolean) : void
      {
         if(this._itemHasAccessory == param1)
         {
            return;
         }
         this._itemHasAccessory = param1;
         this.invalidate("data");
      }
      
      public function get accessoryPosition() : String
      {
         return this._accessoryPosition;
      }
      
      public function set accessoryPosition(param1:String) : void
      {
         if(this._accessoryPosition == param1)
         {
            return;
         }
         this._accessoryPosition = param1;
         this.invalidate("styles");
      }
      
      public function get layoutOrder() : String
      {
         return this._layoutOrder;
      }
      
      public function set layoutOrder(param1:String) : void
      {
         if(this._layoutOrder == param1)
         {
            return;
         }
         this._layoutOrder = param1;
         this.invalidate("styles");
      }
      
      public function get accessoryOffsetX() : Number
      {
         return this._accessoryOffsetX;
      }
      
      public function set accessoryOffsetX(param1:Number) : void
      {
         if(this._accessoryOffsetX == param1)
         {
            return;
         }
         this._accessoryOffsetX = param1;
         this.invalidate("styles");
      }
      
      public function get accessoryOffsetY() : Number
      {
         return this._accessoryOffsetY;
      }
      
      public function set accessoryOffsetY(param1:Number) : void
      {
         if(this._accessoryOffsetY == param1)
         {
            return;
         }
         this._accessoryOffsetY = param1;
         this.invalidate("styles");
      }
      
      public function get accessoryGap() : Number
      {
         return this._accessoryGap;
      }
      
      public function set accessoryGap(param1:Number) : void
      {
         if(this._accessoryGap == param1)
         {
            return;
         }
         this._accessoryGap = param1;
         this.invalidate("styles");
      }
      
      override protected function set currentState(param1:String) : void
      {
         if(!this._isToggle && !this.isSelectableWithoutToggle)
         {
            param1 = "up";
         }
         if(this._useStateDelayTimer)
         {
            if(this._stateDelayTimer && this._stateDelayTimer.running)
            {
               this._delayedCurrentState = param1;
               return;
            }
            if(param1 == "down")
            {
               if(this._currentState == param1)
               {
                  return;
               }
               this._delayedCurrentState = param1;
               if(this._stateDelayTimer)
               {
                  this._stateDelayTimer.reset();
               }
               else
               {
                  this._stateDelayTimer = new Timer(DOWN_STATE_DELAY_MS,1);
                  this._stateDelayTimer.addEventListener("timerComplete",stateDelayTimer_timerCompleteHandler);
               }
               this._stateDelayTimer.start();
               return;
            }
         }
         super.currentState = param1;
      }
      
      public function get stopScrollingOnAccessoryTouch() : Boolean
      {
         return this._stopScrollingOnAccessoryTouch;
      }
      
      public function set stopScrollingOnAccessoryTouch(param1:Boolean) : void
      {
         this._stopScrollingOnAccessoryTouch = param1;
      }
      
      public function get delayTextureCreationOnScroll() : Boolean
      {
         return this._delayTextureCreationOnScroll;
      }
      
      public function set delayTextureCreationOnScroll(param1:Boolean) : void
      {
         this._delayTextureCreationOnScroll = param1;
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set labelField(param1:String) : void
      {
         if(this._labelField == param1)
         {
            return;
         }
         this._labelField = param1;
         this.invalidate("data");
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         if(this._labelFunction == param1)
         {
            return;
         }
         this._labelFunction = param1;
         this.invalidate("data");
      }
      
      public function get iconField() : String
      {
         return this._iconField;
      }
      
      public function set iconField(param1:String) : void
      {
         if(this._iconField == param1)
         {
            return;
         }
         this._iconField = param1;
         this.invalidate("data");
      }
      
      public function get iconFunction() : Function
      {
         return this._iconFunction;
      }
      
      public function set iconFunction(param1:Function) : void
      {
         if(this._iconFunction == param1)
         {
            return;
         }
         this._iconFunction = param1;
         this.invalidate("data");
      }
      
      public function get iconSourceField() : String
      {
         return this._iconSourceField;
      }
      
      public function set iconSourceField(param1:String) : void
      {
         if(this._iconSourceField == param1)
         {
            return;
         }
         this._iconSourceField = param1;
         this.invalidate("data");
      }
      
      public function get iconSourceFunction() : Function
      {
         return this._iconSourceFunction;
      }
      
      public function set iconSourceFunction(param1:Function) : void
      {
         if(this._iconSourceFunction == param1)
         {
            return;
         }
         this._iconSourceFunction = param1;
         this.invalidate("data");
      }
      
      public function get accessoryField() : String
      {
         return this._accessoryField;
      }
      
      public function set accessoryField(param1:String) : void
      {
         if(this._accessoryField == param1)
         {
            return;
         }
         this._accessoryField = param1;
         this.invalidate("data");
      }
      
      public function get accessoryFunction() : Function
      {
         return this._accessoryFunction;
      }
      
      public function set accessoryFunction(param1:Function) : void
      {
         if(this._accessoryFunction == param1)
         {
            return;
         }
         this._accessoryFunction = param1;
         this.invalidate("data");
      }
      
      public function get accessorySourceField() : String
      {
         return this._accessorySourceField;
      }
      
      public function set accessorySourceField(param1:String) : void
      {
         if(this._accessorySourceField == param1)
         {
            return;
         }
         this._accessorySourceField = param1;
         this.invalidate("data");
      }
      
      public function get accessorySourceFunction() : Function
      {
         return this._accessorySourceFunction;
      }
      
      public function set accessorySourceFunction(param1:Function) : void
      {
         if(this._accessorySourceFunction == param1)
         {
            return;
         }
         this._accessorySourceFunction = param1;
         this.invalidate("data");
      }
      
      public function get accessoryLabelField() : String
      {
         return this._accessoryLabelField;
      }
      
      public function set accessoryLabelField(param1:String) : void
      {
         if(this._accessoryLabelField == param1)
         {
            return;
         }
         this._accessoryLabelField = param1;
         this.invalidate("data");
      }
      
      public function get accessoryLabelFunction() : Function
      {
         return this._accessoryLabelFunction;
      }
      
      public function set accessoryLabelFunction(param1:Function) : void
      {
         if(this._accessoryLabelFunction == param1)
         {
            return;
         }
         this._accessoryLabelFunction = param1;
         this.invalidate("data");
      }
      
      public function get iconLoaderFactory() : Function
      {
         return this._iconLoaderFactory;
      }
      
      public function set iconLoaderFactory(param1:Function) : void
      {
         if(this._iconLoaderFactory == param1)
         {
            return;
         }
         this._iconLoaderFactory = param1;
         this.replaceIcon(null);
         this.invalidate("data");
      }
      
      public function get accessoryLoaderFactory() : Function
      {
         return this._accessoryLoaderFactory;
      }
      
      public function set accessoryLoaderFactory(param1:Function) : void
      {
         if(this._accessoryLoaderFactory == param1)
         {
            return;
         }
         this._accessoryLoaderFactory = param1;
         this.replaceAccessory(null);
         this.invalidate("data");
      }
      
      public function get accessoryLabelFactory() : Function
      {
         return this._accessoryLabelFactory;
      }
      
      public function set accessoryLabelFactory(param1:Function) : void
      {
         if(this._accessoryLabelFactory == param1)
         {
            return;
         }
         this._accessoryLabelFactory = param1;
         this.replaceAccessory(null);
         this.invalidate("data");
      }
      
      public function get accessoryLabelProperties() : Object
      {
         if(!this._accessoryLabelProperties)
         {
            this._accessoryLabelProperties = new PropertyProxy(accessoryLabelProperties_onChange);
         }
         return this._accessoryLabelProperties;
      }
      
      public function set accessoryLabelProperties(param1:Object) : void
      {
         var _loc3_:PropertyProxy = null;
         if(this._accessoryLabelProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = new PropertyProxy();
         }
         if(!(param1 is PropertyProxy))
         {
            _loc3_ = new PropertyProxy();
            for(var _loc2_ in param1)
            {
               _loc3_[_loc2_] = param1[_loc2_];
            }
            param1 = _loc3_;
         }
         if(this._accessoryLabelProperties)
         {
            this._accessoryLabelProperties.removeOnChangeCallback(accessoryLabelProperties_onChange);
         }
         this._accessoryLabelProperties = PropertyProxy(param1);
         if(this._accessoryLabelProperties)
         {
            this._accessoryLabelProperties.addOnChangeCallback(accessoryLabelProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      override public function dispose() : void
      {
         this.replaceIcon(null);
         this.replaceAccessory(null);
         if(this._stateDelayTimer)
         {
            if(this._stateDelayTimer.running)
            {
               this._stateDelayTimer.stop();
            }
            this._stateDelayTimer.removeEventListener("timerComplete",stateDelayTimer_timerCompleteHandler);
            this._stateDelayTimer = null;
         }
         super.dispose();
      }
      
      public function itemToLabel(param1:Object) : String
      {
         var _loc2_:Object = null;
         if(this._labelFunction != null)
         {
            _loc2_ = this._labelFunction(param1);
            if(_loc2_ is String)
            {
               return _loc2_ as String;
            }
            return _loc2_.toString();
         }
         if(this._labelField != null && param1 && param1.hasOwnProperty(this._labelField))
         {
            _loc2_ = param1[this._labelField];
            if(_loc2_ is String)
            {
               return _loc2_ as String;
            }
            return _loc2_.toString();
         }
         if(param1 is String)
         {
            return param1 as String;
         }
         if(param1)
         {
            return param1.toString();
         }
         return "";
      }
      
      protected function itemToIcon(param1:Object) : DisplayObject
      {
         var _loc2_:Object = null;
         if(this._iconSourceFunction != null)
         {
            _loc2_ = this._iconSourceFunction(param1);
            this.refreshIconSource(_loc2_);
            return this.iconImage;
         }
         if(this._iconSourceField != null && param1 && param1.hasOwnProperty(this._iconSourceField))
         {
            _loc2_ = param1[this._iconSourceField];
            this.refreshIconSource(_loc2_);
            return this.iconImage;
         }
         if(this._iconFunction != null)
         {
            return this._iconFunction(param1) as DisplayObject;
         }
         if(this._iconField != null && param1 && param1.hasOwnProperty(this._iconField))
         {
            return param1[this._iconField] as DisplayObject;
         }
         return null;
      }
      
      protected function itemToAccessory(param1:Object) : DisplayObject
      {
         var _loc3_:Object = null;
         var _loc2_:Object = null;
         if(this._accessorySourceFunction != null)
         {
            _loc3_ = this._accessorySourceFunction(param1);
            this.refreshAccessorySource(_loc3_);
            return this.accessoryImage;
         }
         if(this._accessorySourceField != null && param1 && param1.hasOwnProperty(this._accessorySourceField))
         {
            _loc3_ = param1[this._accessorySourceField];
            this.refreshAccessorySource(_loc3_);
            return this.accessoryImage;
         }
         if(this._accessoryLabelFunction != null)
         {
            _loc2_ = this._accessoryLabelFunction(param1);
            if(_loc2_ is String)
            {
               this.refreshAccessoryLabel(_loc2_ as String);
            }
            else
            {
               this.refreshAccessoryLabel(_loc2_.toString());
            }
            return DisplayObject(this.accessoryLabel);
         }
         if(this._accessoryLabelField != null && param1 && param1.hasOwnProperty(this._accessoryLabelField))
         {
            _loc2_ = param1[this._accessoryLabelField];
            if(_loc2_ is String)
            {
               this.refreshAccessoryLabel(_loc2_ as String);
            }
            else
            {
               this.refreshAccessoryLabel(_loc2_.toString());
            }
            return DisplayObject(this.accessoryLabel);
         }
         if(this._accessoryFunction != null)
         {
            return this._accessoryFunction(param1) as DisplayObject;
         }
         if(this._accessoryField != null && param1 && param1.hasOwnProperty(this._accessoryField))
         {
            return param1[this._accessoryField] as DisplayObject;
         }
         return null;
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = this.isInvalid("state");
         var _loc1_:Boolean = this.isInvalid("data");
         var _loc3_:Boolean = this.isInvalid("styles");
         if(_loc1_)
         {
            this.commitData();
         }
         if(_loc2_ || _loc1_ || _loc3_)
         {
            this.refreshAccessory();
         }
         super.draw();
      }
      
      override protected function autoSizeIfNeeded() : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc2_:Boolean = isNaN(this.explicitWidth);
         var _loc6_:Boolean = isNaN(this.explicitHeight);
         if(!_loc2_ && !_loc6_)
         {
            return false;
         }
         var _loc3_:Boolean = this._ignoreAccessoryResizes;
         this._ignoreAccessoryResizes = true;
         this.refreshMaxLabelWidth(true);
         this.labelTextRenderer.measureText(HELPER_POINT);
         if(this.accessory is IFeathersControl)
         {
            IFeathersControl(this.accessory).validate();
         }
         if(this.currentIcon is IFeathersControl)
         {
            IFeathersControl(this.currentIcon).validate();
         }
         var _loc4_:Number = this.explicitWidth;
         if(_loc2_)
         {
            if(this._label)
            {
               _loc4_ = HELPER_POINT.x;
            }
            _loc5_ = this._gap == Infinity ? Math.min(this._paddingLeft,this._paddingRight) : this._gap;
            if(this._layoutOrder == "labelAccessoryIcon")
            {
               _loc4_ = this.addAccessoryWidth(_loc4_,_loc5_);
               _loc4_ = this.addIconWidth(_loc4_,_loc5_);
            }
            else
            {
               _loc4_ = this.addIconWidth(_loc4_,_loc5_);
               _loc4_ = this.addAccessoryWidth(_loc4_,_loc5_);
            }
            _loc4_ += this._paddingLeft + this._paddingRight;
            if(isNaN(_loc4_))
            {
               _loc4_ = this._originalSkinWidth;
            }
            else if(!isNaN(this._originalSkinWidth))
            {
               _loc4_ = Math.max(_loc4_,this._originalSkinWidth);
            }
            if(isNaN(_loc4_))
            {
               _loc4_ = 0;
            }
         }
         var _loc1_:Number = this.explicitHeight;
         if(_loc6_)
         {
            if(this._label)
            {
               _loc1_ = HELPER_POINT.y;
            }
            _loc5_ = this._gap == Infinity ? Math.min(this._paddingTop,this._paddingBottom) : this._gap;
            if(this._layoutOrder == "labelAccessoryIcon")
            {
               _loc1_ = this.addAccessoryHeight(_loc1_,_loc5_);
               _loc1_ = this.addIconHeight(_loc1_,_loc5_);
            }
            else
            {
               _loc1_ = this.addIconHeight(_loc1_,_loc5_);
               _loc1_ = this.addAccessoryHeight(_loc1_,_loc5_);
            }
            _loc1_ += this._paddingTop + this._paddingBottom;
            if(isNaN(_loc1_))
            {
               _loc1_ = this._originalSkinHeight;
            }
            else if(!isNaN(this._originalSkinHeight))
            {
               _loc1_ = Math.max(_loc1_,this._originalSkinHeight);
            }
            if(isNaN(_loc1_))
            {
               _loc1_ = 0;
            }
         }
         this._ignoreAccessoryResizes = _loc3_;
         return this.setSizeInternal(_loc4_,_loc1_,false);
      }
      
      protected function addIconWidth(param1:Number, param2:Number) : Number
      {
         if(!this.currentIcon || isNaN(this.currentIcon.width))
         {
            return param1;
         }
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(this._iconPosition == "left" || this._iconPosition == "leftBaseline" || this._iconPosition == "right" || this._iconPosition == "rightBaseline")
         {
            param1 += this.currentIcon.width + param2;
         }
         else
         {
            param1 = Math.max(param1,this.currentIcon.width);
         }
         return param1;
      }
      
      protected function addAccessoryWidth(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         if(!this.accessory || isNaN(this.accessory.width))
         {
            return param1;
         }
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(this._accessoryPosition == "left" || this._accessoryPosition == "right")
         {
            _loc3_ = isNaN(this._accessoryGap) ? param2 : this._accessoryGap;
            if(_loc3_ == Infinity)
            {
               _loc3_ = Math.min(this._paddingLeft,this._paddingRight,this._gap);
            }
            param1 += this.accessory.width + _loc3_;
         }
         else
         {
            param1 = Math.max(param1,this.accessory.width);
         }
         return param1;
      }
      
      protected function addIconHeight(param1:Number, param2:Number) : Number
      {
         if(!this.currentIcon || isNaN(this.currentIcon.height))
         {
            return param1;
         }
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(this._iconPosition == "top" || this._iconPosition == "bottom")
         {
            param1 += this.currentIcon.height + param2;
         }
         else
         {
            param1 = Math.max(param1,this.currentIcon.height);
         }
         return param1;
      }
      
      protected function addAccessoryHeight(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         if(!this.accessory || isNaN(this.accessory.height))
         {
            return param1;
         }
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(this._accessoryPosition == "top" || this._accessoryPosition == "bottom")
         {
            _loc3_ = isNaN(this._accessoryGap) ? param2 : this._accessoryGap;
            if(_loc3_ == Infinity)
            {
               _loc3_ = Math.min(this._paddingTop,this._paddingBottom,this._gap);
            }
            param1 += this.accessory.height + _loc3_;
         }
         else
         {
            param1 = Math.max(param1,this.accessory.height);
         }
         return param1;
      }
      
      protected function commitData() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         if(this._data && this._owner)
         {
            if(this._itemHasLabel)
            {
               this._label = this.itemToLabel(this._data);
            }
            if(this._itemHasIcon)
            {
               _loc1_ = this.itemToIcon(this._data);
               this.replaceIcon(_loc1_);
            }
            if(this._itemHasAccessory)
            {
               _loc2_ = this.itemToAccessory(this._data);
               this.replaceAccessory(_loc2_);
            }
         }
         else
         {
            if(this._itemHasLabel)
            {
               this._label = "";
            }
            if(this._itemHasIcon)
            {
               this.replaceIcon(null);
            }
            if(this._itemHasAccessory)
            {
               this.replaceAccessory(null);
            }
         }
      }
      
      protected function replaceIcon(param1:DisplayObject) : void
      {
         if(this.iconImage && this.iconImage != param1)
         {
            this.iconImage.removeEventListener("complete",loader_completeOrErrorHandler);
            this.iconImage.removeEventListener("error",loader_completeOrErrorHandler);
            this.iconImage.dispose();
            this.iconImage = null;
         }
         if(this._itemHasIcon && this.currentIcon && this.currentIcon != param1 && this.currentIcon.parent == this)
         {
            this.currentIcon.removeFromParent(false);
            this.currentIcon = null;
         }
         if(this._iconSelector.defaultValue != param1)
         {
            this._iconSelector.defaultValue = param1;
            this.setInvalidationFlag("styles");
         }
         if(this.iconImage)
         {
            this.iconImage.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
         }
      }
      
      protected function replaceAccessory(param1:DisplayObject) : void
      {
         if(this.accessory == param1)
         {
            return;
         }
         if(this.accessory)
         {
            this.accessory.removeEventListener("resize",accessory_resizeHandler);
            this.accessory.removeEventListener("touch",accessory_touchHandler);
            if(this.accessory.parent == this)
            {
               this.accessory.removeFromParent(false);
            }
         }
         if(this.accessoryLabel && this.accessoryLabel != param1)
         {
            this.accessoryLabel.dispose();
            this.accessoryLabel = null;
         }
         if(this.accessoryImage && this.accessoryImage != param1)
         {
            this.accessoryImage.removeEventListener("complete",loader_completeOrErrorHandler);
            this.accessoryImage.removeEventListener("error",loader_completeOrErrorHandler);
            this.accessoryImage.dispose();
            this.accessoryImage = null;
         }
         this.accessory = param1;
         if(this.accessory)
         {
            if(this.accessory is IFeathersControl)
            {
               if(!(this.accessory is BitmapFontTextRenderer))
               {
                  this.accessory.addEventListener("touch",accessory_touchHandler);
               }
               this.accessory.addEventListener("resize",accessory_resizeHandler);
            }
            this.addChild(this.accessory);
         }
         if(this.accessoryImage)
         {
            this.accessoryImage.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
         }
      }
      
      protected function refreshAccessory() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Object = null;
         if(this.accessory is IFeathersControl)
         {
            IFeathersControl(this.accessory).isEnabled = this._isEnabled;
         }
         if(this.accessoryLabel)
         {
            _loc3_ = DisplayObject(this.accessoryLabel);
            for(var _loc1_ in this._accessoryLabelProperties)
            {
               if(_loc3_.hasOwnProperty(_loc1_))
               {
                  _loc2_ = this._accessoryLabelProperties[_loc1_];
                  _loc3_[_loc1_] = _loc2_;
               }
            }
         }
      }
      
      protected function refreshIconSource(param1:Object) : void
      {
         if(!this.iconImage)
         {
            this.iconImage = this._iconLoaderFactory();
            this.iconImage.addEventListener("complete",loader_completeOrErrorHandler);
            this.iconImage.addEventListener("error",loader_completeOrErrorHandler);
         }
         this.iconImage.source = param1;
      }
      
      protected function refreshAccessorySource(param1:Object) : void
      {
         if(!this.accessoryImage)
         {
            this.accessoryImage = this._accessoryLoaderFactory();
            this.accessoryImage.addEventListener("complete",loader_completeOrErrorHandler);
            this.accessoryImage.addEventListener("error",loader_completeOrErrorHandler);
         }
         this.accessoryImage.source = param1;
      }
      
      protected function refreshAccessoryLabel(param1:String) : void
      {
         var _loc2_:Function = null;
         if(!this.accessoryLabel)
         {
            _loc2_ = this._accessoryLabelFactory != null ? this._accessoryLabelFactory : FeathersControl.defaultTextRendererFactory;
            this.accessoryLabel = ITextRenderer(_loc2_());
            this.accessoryLabel.nameList.add(this.accessoryLabelName);
         }
         this.accessoryLabel.text = param1;
      }
      
      override protected function layoutContent() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:String = null;
         var _loc3_:Boolean = this._ignoreAccessoryResizes;
         this._ignoreAccessoryResizes = true;
         this.refreshMaxLabelWidth(false);
         if(this._label)
         {
            this.labelTextRenderer.validate();
            _loc2_ = DisplayObject(this.labelTextRenderer);
         }
         if(this.accessory is IFeathersControl)
         {
            IFeathersControl(this.accessory).validate();
         }
         if(this.currentIcon is IFeathersControl)
         {
            IFeathersControl(this.currentIcon).validate();
         }
         var _loc5_:Boolean = this.currentIcon && this._iconPosition != "manual";
         var _loc4_:Boolean = this.accessory && this._accessoryPosition != "manual";
         var _loc6_:Number = isNaN(this._accessoryGap) ? this._gap : this._accessoryGap;
         if(this._label && _loc5_ && _loc4_)
         {
            this.positionSingleChild(_loc2_);
            if(this._layoutOrder == "labelAccessoryIcon")
            {
               this.positionRelativeToOthers(this.accessory,_loc2_,null,this._accessoryPosition,_loc6_,null,0);
               _loc1_ = this._iconPosition;
               if(_loc1_ == "leftBaseline")
               {
                  _loc1_ = "left";
               }
               else if(_loc1_ == "rightBaseline")
               {
                  _loc1_ = "right";
               }
               this.positionRelativeToOthers(this.currentIcon,_loc2_,this.accessory,_loc1_,this._gap,this._accessoryPosition,_loc6_);
            }
            else
            {
               this.positionLabelAndIcon();
               this.positionRelativeToOthers(this.accessory,_loc2_,this.currentIcon,this._accessoryPosition,_loc6_,this._iconPosition,this._gap);
            }
         }
         else if(this._label)
         {
            this.positionSingleChild(_loc2_);
            if(_loc5_)
            {
               this.positionLabelAndIcon();
            }
            else if(_loc4_)
            {
               this.positionRelativeToOthers(this.accessory,_loc2_,null,this._accessoryPosition,_loc6_,null,0);
            }
         }
         else if(_loc5_)
         {
            this.positionSingleChild(this.currentIcon);
            if(_loc4_)
            {
               this.positionRelativeToOthers(this.accessory,this.currentIcon,null,this._accessoryPosition,_loc6_,null,0);
            }
         }
         else if(_loc4_)
         {
            this.positionSingleChild(this.accessory);
         }
         if(this.accessory)
         {
            if(!_loc4_)
            {
               this.accessory.x = this._paddingLeft;
               this.accessory.y = this._paddingTop;
            }
            this.accessory.x += this._accessoryOffsetX;
            this.accessory.y += this._accessoryOffsetY;
         }
         if(this.currentIcon)
         {
            if(!_loc5_)
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
         this._ignoreAccessoryResizes = _loc3_;
      }
      
      override protected function refreshMaxLabelWidth(param1:Boolean) : void
      {
         var _loc3_:Number = NaN;
         if(!this._label)
         {
            return;
         }
         var _loc2_:Number = this.actualWidth;
         if(param1)
         {
            _loc2_ = isNaN(this.explicitWidth) ? this._maxWidth : this.explicitWidth;
         }
         if(this.accessory is IFeathersControl)
         {
            IFeathersControl(this.accessory).validate();
         }
         var _loc4_:Number = this._gap == Infinity ? Math.min(this._paddingLeft,this._paddingRight) : this._gap;
         if(this.currentIcon && (this._iconPosition == "left" || this._iconPosition == "leftBaseline" || this._iconPosition == "right" || this._iconPosition == "rightBaseline"))
         {
            _loc2_ -= _loc4_ + this.currentIcon.width;
         }
         if(this.accessory && (this._accessoryPosition == "left" || this._accessoryPosition == "right"))
         {
            _loc3_ = isNaN(this._accessoryGap) || this._accessoryGap == Infinity ? _loc4_ : this._accessoryGap;
            _loc2_ -= _loc3_ + this.accessory.width;
         }
         this.labelTextRenderer.maxWidth = _loc2_ - this._paddingLeft - this._paddingRight;
      }
      
      protected function positionRelativeToOthers(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:String, param5:Number, param6:String, param7:Number) : void
      {
         var _loc15_:Number = param3 ? Math.min(param2.x,param3.x) : param2.x;
         var _loc14_:Number = param3 ? Math.min(param2.y,param3.y) : param2.y;
         var _loc10_:Number = param3 ? Math.max(param2.x + param2.width,param3.x + param3.width) - _loc15_ : param2.width;
         var _loc11_:Number = param3 ? Math.max(param2.y + param2.height,param3.y + param3.height) - _loc14_ : param2.height;
         var _loc13_:Number = _loc15_;
         var _loc12_:Number = _loc14_;
         if(param4 == "top")
         {
            if(param5 == Infinity)
            {
               param1.y = this._paddingTop;
               _loc12_ = this.actualHeight - this._paddingBottom - _loc11_;
            }
            else
            {
               if(this._verticalAlign == "top")
               {
                  _loc12_ += param1.height + param5;
               }
               else if(this._verticalAlign == "middle")
               {
                  _loc12_ += (param1.height + param5) / 2;
               }
               if(param3)
               {
                  _loc12_ = Math.max(_loc12_,this._paddingTop + param1.height + param5);
               }
               param1.y = _loc12_ - param1.height - param5;
            }
         }
         else if(param4 == "right")
         {
            if(param5 == Infinity)
            {
               _loc13_ = this._paddingLeft;
               param1.x = this.actualWidth - this._paddingRight - param1.width;
            }
            else
            {
               if(this._horizontalAlign == "right")
               {
                  _loc13_ -= param1.width + param5;
               }
               else if(this._horizontalAlign == "center")
               {
                  _loc13_ -= (param1.width + param5) / 2;
               }
               if(param3)
               {
                  _loc13_ = Math.min(_loc13_,this.actualWidth - this._paddingRight - param1.width - _loc10_ - param5);
               }
               param1.x = _loc13_ + _loc10_ + param5;
            }
         }
         else if(param4 == "bottom")
         {
            if(param5 == Infinity)
            {
               _loc12_ = this._paddingTop;
               param1.y = this.actualHeight - this._paddingBottom - param1.height;
            }
            else
            {
               if(this._verticalAlign == "bottom")
               {
                  _loc12_ -= param1.height + param5;
               }
               else if(this._verticalAlign == "middle")
               {
                  _loc12_ -= (param1.height + param5) / 2;
               }
               if(param3)
               {
                  _loc12_ = Math.min(_loc12_,this.actualHeight - this._paddingBottom - param1.height - _loc11_ - param5);
               }
               param1.y = _loc12_ + _loc11_ + param5;
            }
         }
         else if(param4 == "left")
         {
            if(param5 == Infinity)
            {
               param1.x = this._paddingLeft;
               _loc13_ = this.actualWidth - this._paddingRight - _loc10_;
            }
            else
            {
               if(this._horizontalAlign == "left")
               {
                  _loc13_ += param5 + param1.width;
               }
               else if(this._horizontalAlign == "center")
               {
                  _loc13_ += (param5 + param1.width) / 2;
               }
               if(param3)
               {
                  _loc13_ = Math.max(_loc13_,this._paddingLeft + param1.width + param5);
               }
               param1.x = _loc13_ - param5 - param1.width;
            }
         }
         var _loc9_:Number = _loc13_ - _loc15_;
         var _loc8_:Number = _loc12_ - _loc14_;
         if(!param3 || param7 != Infinity || !(param4 == "top" && param6 == "top" || param4 == "right" && param6 == "right" || param4 == "bottom" && param6 == "bottom" || param4 == "left" && param6 == "left"))
         {
            param2.x += _loc9_;
            param2.y += _loc8_;
         }
         if(param3)
         {
            if(param7 != Infinity || !(param4 == "left" && param6 == "right" || param4 == "right" && param6 == "left" || param4 == "top" && param6 == "bottom" || param4 == "bottom" && param6 == "top"))
            {
               param3.x += _loc9_;
               param3.y += _loc8_;
            }
            if(param5 == Infinity && param7 == Infinity)
            {
               if(param4 == "right" && param6 == "left")
               {
                  param2.x = param3.x + (param1.x - param3.x + param3.width - param2.width) / 2;
               }
               else if(param4 == "left" && param6 == "right")
               {
                  param2.x = param1.x + (param3.x - param1.x + param1.width - param2.width) / 2;
               }
               else if(param4 == "right" && param6 == "right")
               {
                  param3.x = param2.x + (param1.x - param2.x + param2.width - param3.width) / 2;
               }
               else if(param4 == "left" && param6 == "left")
               {
                  param3.x = param1.x + (param2.x - param1.x + param1.width - param3.width) / 2;
               }
               else if(param4 == "bottom" && param6 == "top")
               {
                  param2.y = param3.y + (param1.y - param3.y + param3.height - param2.height) / 2;
               }
               else if(param4 == "top" && param6 == "bottom")
               {
                  param2.y = param1.y + (param3.y - param1.y + param1.height - param2.height) / 2;
               }
               else if(param4 == "bottom" && param6 == "bottom")
               {
                  param3.y = param2.y + (param1.y - param2.y + param2.height - param3.height) / 2;
               }
               else if(param4 == "top" && param6 == "top")
               {
                  param3.y = param1.y + (param2.y - param1.y + param1.height - param3.height) / 2;
               }
            }
         }
         if(param4 == "left" || param4 == "right")
         {
            if(this._verticalAlign == "top")
            {
               param1.y = this._paddingTop;
            }
            else if(this._verticalAlign == "bottom")
            {
               param1.y = this.actualHeight - this._paddingBottom - param1.height;
            }
            else
            {
               param1.y = this._paddingTop + (this.actualHeight - this._paddingTop - this._paddingBottom - param1.height) / 2;
            }
         }
         else if(param4 == "top" || param4 == "bottom")
         {
            if(this._horizontalAlign == "left")
            {
               param1.x = this._paddingLeft;
            }
            else if(this._horizontalAlign == "right")
            {
               param1.x = this.actualWidth - this._paddingRight - param1.width;
            }
            else
            {
               param1.x = this._paddingLeft + (this.actualWidth - this._paddingLeft - this._paddingRight - param1.width) / 2;
            }
         }
      }
      
      protected function owner_scrollStartHandler(param1:Event) : void
      {
         if(this._delayTextureCreationOnScroll)
         {
            if(this.accessoryImage)
            {
               this.accessoryImage.delayTextureCreation = true;
            }
            if(this.iconImage)
            {
               this.iconImage.delayTextureCreation = true;
            }
         }
         if(this.touchPointID < 0 && this.accessoryTouchPointID < 0)
         {
            return;
         }
         this.resetTouchState();
         if(this._stateDelayTimer && this._stateDelayTimer.running)
         {
            this._stateDelayTimer.stop();
         }
         this._delayedCurrentState = null;
         if(this.accessoryTouchPointID >= 0)
         {
            this._owner.stopScrolling();
         }
      }
      
      protected function owner_scrollCompleteHandler(param1:Event) : void
      {
         if(this._delayTextureCreationOnScroll)
         {
            if(this.accessoryImage)
            {
               this.accessoryImage.delayTextureCreation = false;
            }
            if(this.iconImage)
            {
               this.iconImage.delayTextureCreation = false;
            }
         }
      }
      
      override protected function button_removedFromStageHandler(param1:Event) : void
      {
         super.button_removedFromStageHandler(param1);
         this.accessoryTouchPointID = -1;
      }
      
      protected function itemRenderer_triggeredHandler(param1:Event) : void
      {
         if(this._isToggle || !this.isSelectableWithoutToggle)
         {
            return;
         }
         this.isSelected = true;
      }
      
      protected function accessoryLabelProperties_onChange(param1:PropertyProxy, param2:String) : void
      {
         this.invalidate("styles");
      }
      
      protected function stateDelayTimer_timerCompleteHandler(param1:TimerEvent) : void
      {
         super.currentState = this._delayedCurrentState;
         this._delayedCurrentState = null;
      }
      
      override protected function button_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:Touch = null;
         if(this.accessory && this.touchPointID < 0)
         {
            _loc2_ = param1.getTouch(this.accessory);
            if(_loc2_)
            {
               this.currentState = "up";
               return;
            }
         }
         super.button_touchHandler(param1);
      }
      
      protected function accessory_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:Touch = null;
         if(!this._isEnabled)
         {
            this.accessoryTouchPointID = -1;
            return;
         }
         if(!this.stopScrollingOnAccessoryTouch || this.accessory == this.accessoryLabel || this.accessory == this.accessoryImage)
         {
            return;
         }
         if(this.accessoryTouchPointID >= 0)
         {
            _loc2_ = param1.getTouch(this.accessory,"ended",this.accessoryTouchPointID);
            if(!_loc2_)
            {
               return;
            }
            this.accessoryTouchPointID = -1;
         }
         else
         {
            _loc2_ = param1.getTouch(this.accessory,"began");
            if(!_loc2_)
            {
               return;
            }
            this.accessoryTouchPointID = _loc2_.id;
         }
      }
      
      protected function accessory_resizeHandler(param1:Event) : void
      {
         if(this._ignoreAccessoryResizes)
         {
            return;
         }
         this.invalidate("size");
      }
      
      protected function loader_completeOrErrorHandler(param1:Event) : void
      {
         this.invalidate("size");
      }
   }
}

