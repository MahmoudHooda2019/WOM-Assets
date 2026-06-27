package peak.component
{
   import com.yahoo.astra.fl.controls.TabBar;
   import fl.controls.Button;
   
   public class PTabBar extends TabBar
   {
      
      private static const TAB_STYLES:Object = {
         "embedFonts":"embedFonts",
         "disabledTextFormat":"disabledTextFormat",
         "textFormat":"textFormat",
         "selectedTextFormat":"selectedTextFormat",
         "textPadding":"textPadding"
      };
      
      public function PTabBar()
      {
         super();
      }
      
      public function get buttonOffset() : int
      {
         return 0;
      }
      
      override protected function drawButtons() : void
      {
         var _loc8_:int = 0;
         var _loc2_:Button = null;
         var _loc1_:Number = NaN;
         var _loc7_:Boolean = this.isInvalid("styles");
         var _loc4_:Boolean = this.isInvalid("rendererStyles");
         var _loc6_:Number = 0;
         var _loc3_:int = int(this.buttons.length);
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc2_ = Button(this.buttons[_loc8_]);
            _loc2_.selected = this._selectedIndex == _loc8_;
            _loc2_.enabled = this.enabled;
            if(_loc8_ == this._focusIndex)
            {
               _loc2_.setMouseState("over");
            }
            else
            {
               _loc2_.setMouseState("up");
            }
            if(_loc7_)
            {
               this.copyStylesToChild(_loc2_,TAB_STYLES);
            }
            if(_loc4_)
            {
               for(var _loc5_ in this.rendererStyles)
               {
                  _loc2_.setStyle(_loc5_,this.rendererStyles[_loc5_]);
               }
            }
            _loc2_.x = _loc6_;
            _loc2_.width = NaN;
            _loc2_.height = this.height;
            _loc2_.drawNow();
            _loc6_ += _loc2_.visible ? _loc2_.width + buttonOffset : (_loc8_ == 0 ? 0 : buttonOffset);
            _loc8_++;
         }
         if(this.autoSizeTabsToTextWidth)
         {
            this._width = _loc6_;
         }
         else
         {
            _loc1_ = _loc6_;
            _loc6_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc2_ = Button(this.buttons[_loc8_]);
               _loc2_.x = _loc6_;
               _loc2_.width = this.width * (_loc2_.width / _loc1_);
               _loc2_.drawNow();
               _loc6_ += _loc2_.width;
               _loc8_++;
            }
         }
         if(_loc4_)
         {
            for(_loc5_ in this.rendererStyles)
            {
               if(this.rendererStyles[_loc5_] == null)
               {
                  delete this.rendererStyles[_loc5_];
               }
            }
         }
      }
      
      public function toggleButtonVisibility(param1:uint, param2:Boolean) : void
      {
         var _loc3_:Button = Button(this.buttons[param1]);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
         }
         this.invalidate("data");
      }
   }
}

