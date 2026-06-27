package wom.view.component
{
   import feathers.controls.Button;
   import peak.component.mobile.MPTabBar;
   
   public class MobileWomTabBar extends MPTabBar
   {
      
      public static const BUTTON_OFFSET:int = 144;
      
      private var _buttonOffset:int;
      
      public function MobileWomTabBar(param1:int = 144)
      {
         _buttonOffset = param1;
         super();
      }
      
      override protected function layoutTabs() : void
      {
         var _loc6_:int = 0;
         var _loc3_:Button = null;
         var _loc7_:int = int(this.activeTabs.length);
         var _loc5_:Number = this._direction == "vertical" ? this.actualHeight : this.actualWidth;
         var _loc2_:Number = _loc5_ - this._gap * (_loc7_ - 1);
         var _loc4_:Number = _loc2_ / _loc7_;
         var _loc1_:Number = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_ = this.activeTabs[_loc6_];
            if(this._direction == "vertical")
            {
               _loc3_.width = this.actualWidth;
               _loc3_.height = _loc4_;
               _loc3_.x = 0;
               _loc3_.y = _loc1_;
               _loc1_ += _loc3_.height + this._gap;
            }
            else
            {
               _loc3_.width = Math.ceil(_loc3_.width);
               _loc3_.height = this.actualHeight;
               _loc3_.x = _loc1_;
               _loc3_.y = 0;
               _loc1_ += _loc3_.width + this._gap;
            }
            _loc3_.validate();
            _loc6_++;
         }
      }
   }
}

