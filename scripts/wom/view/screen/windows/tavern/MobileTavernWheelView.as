package wom.view.screen.windows.tavern
{
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   
   public class MobileTavernWheelView extends Sprite implements View
   {
      
      private var _sliceViews:Vector.<MobileTavernWheelSliceView>;
      
      public function MobileTavernWheelView()
      {
         super();
      }
      
      private static function toRad(param1:Number) : Number
      {
         return param1 / 180 * 3.141592653589793;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _sliceViews = new Vector.<MobileTavernWheelSliceView>(0);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc3_:MobileTavernWheelSliceView = null;
         var _loc7_:Number = NaN;
         var _loc6_:int = 0;
         var _loc1_:int = -38;
         var _loc4_:Number = toRad(-_loc1_);
         var _loc5_:Number = _loc1_;
         var _loc2_:Number = 60;
         _loc6_ = 0;
         while(_loc6_ < _sliceViews.length)
         {
            _loc3_ = _sliceViews[_loc6_];
            _loc7_ = toRad(_loc5_);
            _loc3_.rotation = _loc7_ + _loc4_;
            _loc3_.x = _loc2_ * Math.cos(_loc7_);
            _loc3_.y = _loc2_ * Math.sin(_loc7_);
            _loc5_ += 22.5;
            _loc6_++;
         }
      }
      
      private function clear() : void
      {
         for each(var _loc1_ in _sliceViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _sliceViews.length = 0;
      }
      
      public function update(param1:Vector.<TavernItemDIO>) : void
      {
         var _loc3_:MobileTavernWheelSliceView = null;
         clear();
         for each(var _loc2_ in param1)
         {
            _loc3_ = new MobileTavernWheelSliceView(_loc2_);
            addChild(_loc3_);
            _sliceViews.push(_loc3_);
         }
         drawLayout();
      }
   }
}

