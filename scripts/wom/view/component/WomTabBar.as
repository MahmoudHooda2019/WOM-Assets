package wom.view.component
{
   import com.yahoo.astra.fl.controls.tabBarClasses.TabButton;
   import fl.controls.Button;
   import peak.component.PTabBar;
   
   public class WomTabBar extends PTabBar
   {
      
      public static const BUTTON_OFFSET:int = 144;
      
      private static const TAB_STYLES:Object = {
         "embedFonts":"embedFonts",
         "disabledTextFormat":"disabledTextFormat",
         "textFormat":"textFormat",
         "selectedTextFormat":"selectedTextFormat",
         "textPadding":"textPadding"
      };
      
      private var _buttonOffset:int;
      
      public function WomTabBar(param1:int = 144)
      {
         _buttonOffset = param1;
         super();
      }
      
      override public function get buttonOffset() : int
      {
         return _buttonOffset;
      }
      
      override protected function getButton() : TabButton
      {
         var _loc1_:WomTabButton = null;
         if(this._cachedButtons.length > 0)
         {
            _loc1_ = this._cachedButtons.shift() as WomTabButton;
         }
         else
         {
            _loc1_ = newInstanceOfWomTabButton();
            _loc1_.toggle = true;
            _loc1_.focusEnabled = false;
            _loc1_.addEventListener("change",buttonChangeHandler,false,0,true);
            _loc1_.addEventListener("click",buttonClickHandler,false,0,true);
            _loc1_.addEventListener("rollOver",buttonRollOverHandler,false,0,true);
            _loc1_.addEventListener("rollOut",buttonRollOutHandler,false,0,true);
            this.addChild(_loc1_);
         }
         return _loc1_;
      }
      
      protected function getWomTabButtonWidth() : int
      {
         return buttonOffset - 3;
      }
      
      protected function newInstanceOfWomTabButton() : WomTabButton
      {
         return new WomTabButton(getWomTabButtonWidth());
      }
      
      override protected function drawButtons() : void
      {
         var _loc10_:int = 0;
         var _loc3_:Button = null;
         var _loc8_:int = 0;
         var _loc1_:Number = NaN;
         var _loc9_:Boolean = this.isInvalid("styles");
         var _loc5_:Boolean = this.isInvalid("rendererStyles");
         var _loc7_:Number = 0;
         var _loc4_:int = int(this.buttons.length);
         var _loc2_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < _loc4_)
         {
            _loc3_ = Button(this.buttons[_loc10_]);
            _loc3_.selected = this._selectedIndex == _loc10_;
            _loc3_.enabled = this.enabled;
            if(_loc10_ == this._focusIndex)
            {
               _loc3_.setMouseState("over");
            }
            else
            {
               _loc3_.setMouseState("up");
            }
            if(_loc9_)
            {
               this.copyStylesToChild(_loc3_,TAB_STYLES);
            }
            if(_loc5_)
            {
               for(var _loc6_ in this.rendererStyles)
               {
                  _loc3_.setStyle(_loc6_,this.rendererStyles[_loc6_]);
               }
            }
            _loc7_ = _loc3_.selected ? (_loc10_ != 0 ? _loc7_ - buttonMargin : _loc7_) : (_loc10_ == 0 ? _loc7_ + buttonMargin : _loc7_);
            _loc3_.x = _loc7_;
            _loc3_.y = _loc3_.selected ? selectedButtonOffsetY : 0;
            _loc3_.width = NaN;
            _loc3_.height = this.height;
            _loc3_.drawNow();
            _loc8_ = _loc3_.selected ? selectedButtonOffsetX : buttonOffsetX;
            _loc7_ += _loc3_.visible ? _loc3_.width + _loc8_ : (_loc10_ == 0 ? 0 : buttonOffset);
            _loc2_ = _loc3_.selected;
            _loc10_++;
         }
         if(this.autoSizeTabsToTextWidth)
         {
            this._width = _loc7_;
         }
         else
         {
            _loc1_ = _loc7_;
            _loc7_ = 0;
            _loc10_ = 0;
            while(_loc10_ < _loc4_)
            {
               _loc3_ = Button(this.buttons[_loc10_]);
               _loc3_.x = _loc7_;
               _loc3_.width = this.width * (_loc3_.width / _loc1_);
               _loc3_.drawNow();
               _loc7_ += _loc3_.width;
               _loc10_++;
            }
         }
         if(_loc5_)
         {
            for(_loc6_ in this.rendererStyles)
            {
               if(this.rendererStyles[_loc6_] == null)
               {
                  delete this.rendererStyles[_loc6_];
               }
            }
         }
      }
      
      public function set buttonOffset(param1:int) : void
      {
         _buttonOffset = param1;
      }
      
      public function get selectedButtonOffsetY() : int
      {
         return -7;
      }
      
      public function get selectedButtonOffsetX() : int
      {
         return -5;
      }
      
      public function get buttonOffsetX() : int
      {
         return 3;
      }
      
      public function get buttonMargin() : int
      {
         return 8;
      }
   }
}

